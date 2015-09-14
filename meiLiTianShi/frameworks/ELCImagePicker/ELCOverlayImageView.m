//
//  ELCOverlayImageView.m
//  ELCImagePickerDemo
//
//  Created by Seamus on 14-7-11.
//  Copyright (c) 2014年 ELC Technologies. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "ELCOverlayImageView.h"
#import "ELCConsole.h"
@implementation ELCOverlayImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {

        self.notSelectedImage=[UIImageView new];
        self.notSelectedImage.image=[UIImage imageNamed:@"未选取照片.png"];
        self.selectedImage=[UIImageView new];
        self.selectedImage.image=[UIImage imageNamed:@"选择取照片.png"];
        [self addSubview:self.notSelectedImage];
        [self addSubview:self.selectedImage];
        [self.notSelectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-4);
        }];

        [self.selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-4);
        }];


        self.labIndex = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 16, 16)];

    }

    return self;
}


- (void)setIndex:(int)_index
{
    self.labIndex.text = [NSString stringWithFormat:@"%d",_index];
}

- (void)dealloc
{
    self.labIndex = nil;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        UIImageView *img = [[UIImageView alloc] initWithImage:image];
        [self addSubview:img];
        
        if ([[ELCConsole mainConsole] onOrder]) {
            self.labIndex = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 16, 16)];
            self.labIndex.backgroundColor = [UIColor redColor];
            self.labIndex.clipsToBounds = YES;
            self.labIndex.textAlignment = NSTextAlignmentCenter;
            self.labIndex.textColor = [UIColor whiteColor];
            self.labIndex.layer.cornerRadius = 8;
            self.labIndex.layer.shouldRasterize = YES;
            //        self.labIndex.layer.borderWidth = 1;
            //        self.labIndex.layer.borderColor = [UIColor greenColor].CGColor;
            self.labIndex.font = [UIFont boldSystemFontOfSize:13];
            [self addSubview:self.labIndex];
        }
    }
    return self;
}




@end
