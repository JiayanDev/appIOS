//
// Created by zcw on 15/8/27.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "UILabel+MLStyle.h"


@implementation UILabel (MLStyle)
+(UILabel *)newMLStyleWithSize:(CGFloat)size isGrey:(BOOL)isGrey{
    UILabel *l=[UILabel new];
    l.font=[UIFont systemFontOfSize:size<=0?15:size];
    l.textColor=isGrey?THEME_COLOR_TEXT_LIGHT_GRAY:THEME_COLOR_TEXT;
    return l;
}

-(void)appendIcon:(UIImage *)icon{
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = icon;
    attachment.bounds=CGRectMake(0, self.font.descender, attachment.image.size.width, attachment.image.size.height);

    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];


//    self.text=[NSString stringWithFormat:@"%@ ",self.text];
    NSMutableAttributedString *myString= [self.attributedText mutableCopy];
    [myString insertAttributedString:[[NSAttributedString alloc] initWithString:@"  "] atIndex:[myString length]];
    [myString appendAttributedString:attachmentString];

    self.attributedText = myString;
};

-(void)appendIconOfGender:(NSUInteger)gender{
    if(gender){
        [self appendIcon:[UIImage imageNamed:@"男.png"] ];
    }else{
        [self appendIcon:[UIImage imageNamed:@"女.png"] ];
    }

};



-(void)prependIconOfGender:(NSUInteger)gender{
    if(gender){
        [self prependIcon:[UIImage imageNamed:@"男.png"] ];
    }else{
        [self prependIcon:[UIImage imageNamed:@"女.png"] ];
    }

};


-(void)appendIconOfTag:(NSString *)tag{
    if([tag isEqualToString:@"angel"]){

        [self appendIcon:[UIImage imageNamed:@"标签_美丽天使.png"]];
    }else if([tag isEqualToString:@"official"]){
        [self appendIcon:[UIImage imageNamed:@"标签_官方.png"]];
    }else if([tag isEqualToString:@"company"]){
        [self appendIcon:[UIImage imageNamed:@"标签_伴美.png"]];
    }
}


-(void)prependIcon:(UIImage *)icon{
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = icon;
    attachment.bounds=CGRectMake(0, self.font.descender, attachment.image.size.width, attachment.image.size.height);

    self.text=[NSString stringWithFormat:@" %@",self.text];

    NSMutableAttributedString *attachmentString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];

    NSMutableAttributedString *myString= [self.attributedText mutableCopy];
    [attachmentString appendAttributedString:myString];

    self.attributedText = attachmentString;
};




@end