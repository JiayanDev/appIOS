//
// Created by zcw on 15/11/15.
// Copyright (c) 2015 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "MLKILabel.h"


@implementation MLKILabel {

}

- (instancetype)initWithString:(NSString *)s DetectString:(NSString *)ds {
    if (self = [super init]) {
        self.detectString = ds;
        self.text = s;

        [self performSelector:@selector(setupTextSystem)];
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
    NSMutableArray *rangesForLinks = [super performSelector:@selector(getRangesForLinks:) withObject:text];
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
@end