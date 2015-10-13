#import <UIKit/UIKit.h>
#import "PHFComposeBarView.h"

@interface MLWebViewWithCommentTextBarViewController : UIViewController <PHFComposeBarViewDelegate>
@property (nonatomic, strong)UIWebView *textView;

@property (strong, nonatomic) PHFComposeBarView *composeBarView;
@property (strong, nonatomic) UIView *container;
@end
