//
//  AssetCell.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCConsole.h"
#import "ELCOverlayImageView.h"
#import <Photos/Photos.h>

@interface ELCAssetCell ()

@property (nonatomic, strong) NSArray *rowAssets;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *overlayViewArray;

@end

@implementation ELCAssetCell


typedef struct {
    void *assetRepresentation;
    int decodingIterationCount;
} ThumbnailDecodingContext;
static const int kThumbnailDecodingContextMaxIterationCount = 16;

static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ThumbnailDecodingContext *decodingContext = (ThumbnailDecodingContext *)info;
    ALAssetRepresentation *assetRepresentation = (__bridge ALAssetRepresentation *)decodingContext->assetRepresentation;
    if (decodingContext->decodingIterationCount == kThumbnailDecodingContextMaxIterationCount) {
        NSLog(@"WARNING: Image %@ is too large for thumbnail extraction.", [assetRepresentation url]);
        return 0;
    }
    ++decodingContext->decodingIterationCount;
    NSError *error = nil;
    size_t countRead = [assetRepresentation getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    if (countRead == 0 || error != nil) {
        NSLog(@"ERROR: Failed to decode image %@: %@", [assetRepresentation url], error);
        return 0;
    }
    return countRead;
}


- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(CGFloat)size {
    NSParameterAssert(asset);
    NSParameterAssert(size > 0);
    ALAssetRepresentation *representation = [asset defaultRepresentation];
    if (!representation) {
        return nil;
    }
    CGDataProviderDirectCallbacks callbacks = {
            .version = 0,
            .getBytePointer = NULL,
            .releaseBytePointer = NULL,
            .getBytesAtPosition = getAssetBytesCallback,
            .releaseInfo = NULL
    };
    ThumbnailDecodingContext decodingContext = {
            .assetRepresentation = (__bridge void *)representation,
            .decodingIterationCount = 0
    };
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)&decodingContext, [representation size], &callbacks);
    NSParameterAssert(provider);
    if (!provider) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    NSParameterAssert(source);
    if (!source) {
        CGDataProviderRelease(provider);
        return nil;
    }
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{(NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
            (NSString *)kCGImageSourceThumbnailMaxPixelSize          : [NSNumber numberWithFloat:size],
            (NSString *)kCGImageSourceCreateThumbnailWithTransform   : @YES});
    UIImage *image = nil;
    if (imageRef) {
        image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    CGDataProviderRelease(provider);
    return image;
}

//Using auto synthesizers

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.imageViewArray = mutableArray;
        
        NSMutableArray *overlayArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.overlayViewArray = overlayArray;
        
        self.alignmentLeft = YES;
	}
	return self;
}

- (void)setAssets:(NSArray *)assets
{
    self.rowAssets = assets;
	for (UIImageView *view in _imageViewArray) {
        [view removeFromSuperview];
	}
    for (ELCOverlayImageView *view in _overlayViewArray) {
        [view removeFromSuperview];
	}
    //set up a pointer here so we don't keep calling [UIImage imageNamed:] if creating overlays
    UIImage *overlayImage = nil;
    for (int i = 0; i < [_rowAssets count]; ++i) {

        ELCAsset *asset = [_rowAssets objectAtIndex:i];

        if (i < [_imageViewArray count]) {
            UIImageView *imageView = [_imageViewArray objectAtIndex:i];
            imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
        } else {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.asset.thumbnail]];
            [_imageViewArray addObject:imageView];
        }
        
        if (i < [_overlayViewArray count]) {
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
//            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.notSelectedImage.hidden = asset.selected ? YES : NO;
            overlayView.selectedImage.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%d", asset.index + 1];
        } else {
            if (overlayImage == nil) {
                overlayImage = [UIImage imageNamed:@"Overlay.png"];
            }
            ELCOverlayImageView *overlayView = [[ELCOverlayImageView alloc] init];
            [_overlayViewArray addObject:overlayView];
//            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.notSelectedImage.hidden = asset.selected ? YES : NO;
            overlayView.selectedImage.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%d", asset.index + 1];
        }
    }
}

- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint point = [tapRecognizer locationInView:self];
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * 75 + (c - 1) * 4;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }

    startX=0;

    CGRect frame = CGRectMake(startX, 2, (int ) ((SCREEN_WIDTH+7)/3.0 -7), (int ) ((SCREEN_WIDTH+7)/3.0 -7));
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
        if (CGRectContainsPoint(frame, point)) {
            ELCAsset *asset = [_rowAssets objectAtIndex:i];
            asset.selected = !asset.selected;
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
//            overlayView.hidden = !asset.selected;
            overlayView.notSelectedImage.hidden = asset.selected ? YES : NO;
            overlayView.selectedImage.hidden = asset.selected ? NO : YES;
            if (asset.selected) {
                asset.index = [[ELCConsole mainConsole] numOfSelectedElements];
                [overlayView setIndex:asset.index+1];
                [[ELCConsole mainConsole] addIndex:asset.index];
            }
            else
            {
                int lastElement = [[ELCConsole mainConsole] numOfSelectedElements] - 1;
                [[ELCConsole mainConsole] removeIndex:lastElement];
            }
            break;
        }
        frame.origin.x = frame.origin.x + frame.size.width + 7;
    }
}

- (void)layoutSubviews
{
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = SCREEN_WIDTH;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }

    startX=0;
    
	CGRect frame = CGRectMake(startX, 2, (int ) ((SCREEN_WIDTH+7)/3.0 -7), (int ) ((SCREEN_WIDTH+7)/3.0 -7));
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
		UIImageView *imageView = [_imageViewArray objectAtIndex:i];
		[imageView setFrame:frame];
		[self addSubview:imageView];
        
        ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
        [overlayView setFrame:frame];
        [self addSubview:overlayView];
		
		frame.origin.x = frame.origin.x + frame.size.width + 7;
	}
}


@end
