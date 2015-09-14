//
//  ImageRowCell.m
//  meiLiTianShi
//
//  Created by zcw on 15/7/13.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "ImageRowCell.h"
#import "AFTableViewCell.h"
#import "ELCImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>


NSString * const XLFormRowDescriptorTypeImageRow = @"XLFormRowDescriptorTypeImageRow";

@implementation ImageRowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat w=(int)((SCREEN_WIDTH)/4.0);

    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    layout.itemSize = CGSizeMake(w, w);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[AFIndexedCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;

    [self setCollectionViewDataSourceDelegate:self
                                    indexPath:[NSIndexPath indexPathWithIndex:0]];
    [self.contentView addSubview:self.collectionView];

    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.collectionView.frame = self.contentView.bounds;
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;

    [self.collectionView reloadData];
}


+(void)load
{
    XLFormViewController.cellClassesForRowDescriptorTypes[XLFormRowDescriptorTypeImageRow] = ([ImageRowCell class]);
}

- (void)configure
{
    [super configure];
    //[]

//    [self.ratingView addTarget:self action:@selector(rateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)update
{
    [super update];
//    
//    self.ratingView.value = [self.rowDescriptor.value floatValue];
//    self.rateTitle.text = self.rowDescriptor.title;
//    
//    [self.ratingView setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
//    [self.rateTitle setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}




#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = self.rowDescriptor.value;
    if([collectionViewArray isKindOfClass:[NSArray class]]){
        return collectionViewArray.count+1;
    }else{
        return 1;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];

    NSArray *collectionViewArray = self.rowDescriptor.value;
    //cell.backgroundColor = collectionViewArray[indexPath.item];
    [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    UIImageView *iv= [[UIImageView alloc] initWithFrame:cell.contentView.bounds];

    if(indexPath.item>=collectionViewArray.count){
        iv.image=[UIImage imageNamed:@"selectPhoto.png"];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoSelectPhoto:)];
        [recognizer setNumberOfTapsRequired:1];
        cell.userInteractionEnabled = YES;
        [cell addGestureRecognizer:recognizer];
    }else{
        iv.image=(UIImage *)collectionViewArray[indexPath.item];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollCellSelect:)];
        [recognizer setNumberOfTapsRequired:1];
        cell.userInteractionEnabled = YES;
        [cell addGestureRecognizer:recognizer];
    }

    //iv.image
    //todo add image
    [cell.contentView addSubview:iv];


    return cell;
}


#pragma mark - UIScrollViewDelegate Methods

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
//
//    CGFloat horizontalOffset = scrollView.contentOffset.x;
//
//    UICollectionView *collectionView = (UICollectionView *)scrollView;
//    NSInteger index = collectionView.tag;
//    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
//}

-(void)scrollCellSelect:(UITapGestureRecognizer *) sender{

}

-(void)gotoSelectPhoto:(UITapGestureRecognizer *) sender{
// Create the image picker
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    elcPicker.maximumImagesCount = 6-((NSArray *)self.rowDescriptor.value).count;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;

//Present modally
    [self.formViewController presentViewController:elcPicker animated:YES completion:nil];
}


+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    CGFloat w=(int)((SCREEN_WIDTH)/4.0);
    return w*ceil(rowDescriptor.value?(((NSArray *)rowDescriptor.value).count+1)/4.0:1);
};


#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self.formViewController dismissViewControllerAnimated:YES completion:nil];


    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];

            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }else {
            NSLog(@"Uknown asset type");
        }
    }

    if([self.rowDescriptor.value isKindOfClass:[NSArray class]] ){
        NSMutableArray *v= [((NSArray *) self.rowDescriptor.value) mutableCopy];
        [v addObjectsFromArray:images];
        self.rowDescriptor.value=v;

    }else{
        self.rowDescriptor.value=images;
    }

    [self.collectionView reloadData];
//    [self.formViewController.tableView beginUpdates];
//    [self.formViewController.tableView endUpdates];
    [self.formViewController.tableView reloadData];
}


- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self.formViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
