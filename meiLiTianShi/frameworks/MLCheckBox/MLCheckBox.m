//
// Created by zcw on 15/8/19.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLCheckBox.h"


@implementation MLCheckBox {

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    [self setImage:[UIImage imageNamed:@"checkbox_blank.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
    [self addTarget:self action:<#(SEL)action#> forControlEvents:<#(UIControlEvents)controlEvents#>];
}

-(void)pressed:(MLCheckBox *)checkbox{
    checkbox.selected=!checkbox.selected;
    self.titleLabel.textColor=self.selected?THEME_COLOR_TEXT:THEME_COLOR_TEXT_LIGHT_GRAY;


}

@end