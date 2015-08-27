//
// Created by zcw on 15/8/26.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import <Masonry/View+MASAdditions.h>
#import "InfoCellOfListOfKV.h"

NSString * const XLFormRowDescriptorType_infoCellOfKV = @"XLFormRowDescriptorType_infoCellOfKV";

@implementation XLFormRowDescriptor(display_data)

-(void)setDisplayData:(NSMutableDictionary *)newDisplayData {
    objc_setAssociatedObject(self, @selector(displayData), newDisplayData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSMutableDictionary *)displayData {
    if(objc_getAssociatedObject(self, @selector(displayData))){
        return objc_getAssociatedObject(self, @selector(displayData));
    }else{
        objc_setAssociatedObject(self, @selector(displayData), [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return objc_getAssociatedObject(self, @selector(displayData));
    }

}
@end


@interface InfoCellOfListOfKV()
@end
@implementation InfoCellOfListOfKV
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[InfoCellOfListOfKV class] forKey:XLFormRowDescriptorType_infoCellOfKV];
}

- (void)configure {

    [self update];


}



- (void)update
{
    [super update];


    [[self.contentView subviews]
            makeObjectsPerformSelector:@selector(removeFromSuperview)];


    NSMutableArray *lefts=[NSMutableArray new];
    NSMutableArray *rights=[NSMutableArray new];

    NSArray * a=(NSArray *)self.rowDescriptor.value;
    for (NSDictionary *dictionary in a) {
        UILabel *left=[UILabel new];
        left.text= [dictionary allKeys][0];
        left.textColor=THEME_COLOR_TEXT_LIGHT_GRAY;
        left.font=[UIFont systemFontOfSize:15];

        UILabel *right=[UILabel new];
        right.text=[dictionary allValues][0];
        right.textColor=THEME_COLOR_TEXT;
        right.font=[UIFont systemFontOfSize:15];
        [lefts addObject:left];
        [rights addObject:right];
        [self.contentView addSubview:left];
        [self.contentView addSubview:right];
    }



    for (NSUInteger i = 0; i < lefts.count; ++i) {
        UILabel *l=lefts[i];
        UILabel *r=rights[i];
        if(i==0){
            [l mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(17);
            }];
        }else{
            [l mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(((UILabel *)lefts[i-1]).mas_bottom).offset(18);
            }];
        }

        [l mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);

        }];

        [r mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(l);
            make.left.equalTo(l.mas_right).offset(16);
        }];


        if(i==lefts.count &&i>0){
            [l mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.contentView).offset(-17);
            }];
        }
    }





//    if([self.rowDescriptor.value isKindOfClass:[UIImage class]]){
//        self.avatar.image=self.rowDescriptor.value;
//    }else{
//        [self.avatar sd_setImageWithURL:self.rowDescriptor.value
//                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                  self.avatar.image=image;
//                                  [self needsUpdateConstraints];
//                                  [self setNeedsDisplay];
//                              }];
//    }
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {

}


+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return ((NSArray *)rowDescriptor.value).count *(15+18)+17+16;
}

@end