//
// Created by zcw on 15/11/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLKILabel.h"


@implementation MLKILabel {

}



+(MLKILabel *)newMLStyleWithSize:(CGFloat)size isGrey:(BOOL)isGrey string:(NSString *)s DetectString:(NSString *)ds{
    MLKILabel *l= [MLKILabel new];
    l.detectString = ds;

    [l setupTextSystem];

    l.font=[UIFont systemFontOfSize:size<=0?15:size];
    l.textColor=isGrey?THEME_COLOR_TEXT_LIGHT_GRAY:THEME_COLOR_TEXT;
    l.text = s;
    return l;
}





- (instancetype)initWithString:(NSString *)s DetectString:(NSString *)ds {
    if (self = [super init]) {
        self.detectString = ds;
        self.text = s;

        [self setupTextSystem];
    }
    return self;
}

/**
 *  Returns array of ranges for all special words, user handles, hashtags and urls in the specfied
 *  text.
 *
 *  @param text Text to parse for links
 *
 *  @return Array of dictionaries describing the links.
 */
- (NSArray *)getRangesForLinks:(NSAttributedString *)text
{
    NSString *  KILabelLinkTypeKey = @"linkType";
    NSString *  KILabelRangeKey = @"range";
    NSString *  KILabelLinkKey = @"link";
    NSMutableArray *rangesForLinks = [[super getRangesForLinks:text] mutableCopy];
    NSRange range = [[text string] rangeOfString:self.detectString];

    if (range.location == NSNotFound) {

    }
    else {
        [rangesForLinks addObject:@{KILabelLinkTypeKey : @(KILinkTypeDetectedString),
                KILabelRangeKey : [NSValue valueWithRange:range],
                KILabelLinkKey : self.detectString,
        }];
    }


    return rangesForLinks;
}


- (void)receivedActionForLinkType:(KILinkType)linkType string:(NSString*)string range:(NSRange)range
{
    if(linkType==KILinkTypeDetectedString){
        self.detectStringTapHandler(self,string,range);
    }else{
        [super receivedActionForLinkType:linkType string:string range:range];
//        NSMethodSignature *sig = [super methodSignatureForSelector:@selector(receivedActionForLinkType:string:range:)];
//        if (!sig)
//            return ;
//
//        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
//        [invo setTarget:self];
//        [invo setSelector:@selector(receivedActionForLinkType:string:range:)];
//        [invo setArgument:&linkType atIndex:2];
//        [invo setArgument:&string atIndex:3];
//        [invo setArgument:&range atIndex:4];
//        [invo invoke];
//        if (sig.methodReturnLength) {
//            id anObject;
//            [invo getReturnValue:&anObject];
////            return anObject;
//        }
    }
//    switch (linkType)
//    {
//        case KILinkTypeDetectedString:
//            if (_userHandleLinkTapHandler)
//            {
//                _userHandleLinkTapHandler(self, string, range);
//            }
//            break;
//
//        case KILinkTypeHashtag:
//            if (_hashtagLinkTapHandler)
//            {
//                _hashtagLinkTapHandler(self, string, range);
//            }
//            break;
//
//        case KILinkTypeURL:
//            if (_urlLinkTapHandler)
//            {
//                _urlLinkTapHandler(self, string, range);
//            }
//            break;
//    }
}
@end