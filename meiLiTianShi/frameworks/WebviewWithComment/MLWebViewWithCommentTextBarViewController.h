#import <UIKit/UIKit.h>
#import "MLComposeBarView.h"

@interface MLWebViewWithCommentTextBarViewController : UIViewController <PHFComposeBarViewDelegate>
@property (nonatomic, strong)UIWebView *webView;

@property (strong, nonatomic) MLComposeBarView *composeBarView;
@property (strong, nonatomic) UIView *container;

- (void)composeBarViewDidPressButton:(PHFComposeBarView *)composeBarView;


- (void)likeButtonPress:(UIButton *)sender;

- (void)keyboardGoesUped;

- (BOOL)textViewWillBecomeFirstResponder;
@end
