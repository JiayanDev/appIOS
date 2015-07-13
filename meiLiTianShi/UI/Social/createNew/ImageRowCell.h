//
//  ImageRowCell.h
//  meiLiTianShi
//
//  Created by zcw on 15/7/13.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "XLFormBaseCell.h"
#import "ELCImagePickerController.h"
#import <UIKit/UIKit.h>

@class AFIndexedCollectionView;

extern NSString * const XLFormRowDescriptorTypeImageRow;


@interface ImageRowCell : XLFormBaseCell <UICollectionViewDataSource, UICollectionViewDelegate, ELCImagePickerControllerDelegate>
@property (nonatomic, strong) AFIndexedCollectionView *collectionView;

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor;
@end
