#import <UIKit/UIKit.h>
#import "PHFComposeBarView.h"

@interface MLWebViewWithCommentTextBarViewController : UIViewController <PHFComposeBarViewDelegate>
@property (nonatomic, strong)UIWebView *webView;

@property (strong, nonatomic) PHFComposeBarView *composeBarView;
@property (strong, nonatomic) UIView *container;
@end
