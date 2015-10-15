#import <Masonry/View+MASAdditions.h>
#import "MLWebViewWithCommentTextBarViewController.h"

CGRect const kInitialViewFrame = { 0.0f, 0.0f, 320.0f, 480.0f };

@implementation MLWebViewWithCommentTextBarViewController

- (id)init {
    self = [super init];

    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillToggle:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillToggle:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:kInitialViewFrame];
    [view setBackgroundColor:[UIColor whiteColor]];

    UIView *container = [self container];
    [container addSubview:[self webView]];
    [container addSubview:[self composeBarView]];
    [view addSubview:container];
//    [self setEdgesForExtendedLayout:UIRectEdgeNone];

    [self setView:view];
    [self.composeBarView.likeButton addTarget:self
                                       action:@selector(likeButtonPress:)
                             forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setScrollTopToNOToView:self.view];
    _webView.scrollView.scrollsToTop=YES;
}


- (void)setScrollTopToNOToView:(UIView *)view
{
    NSLog(@"%@", self);

    for (UIView *sub  in view.subviews)
    {
        if ([sub isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)sub).scrollsToTop = NO;

        }

        [self setScrollTopToNOToView:sub];
    }
}

- (void)keyboardWillToggle:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSTimeInterval duration;
    UIViewAnimationCurve animationCurve;
    CGRect startFrame;
    CGRect endFrame;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]    getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey]        getValue:&startFrame];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]          getValue:&endFrame];

    NSInteger signCorrection = 1;
    if (startFrame.origin.y < 0 || startFrame.origin.x < 0 || endFrame.origin.y < 0 || endFrame.origin.x < 0){
       signCorrection = -1;

    }else{

    }


    if([notification.name isEqualToString:UIKeyboardWillShowNotification]){
        self.composeBarView.submitButton.hidden=NO;
        self.composeBarView.likeButton.hidden=YES;
        [self keyboardGoesUped];
    }else{
        self.composeBarView.submitButton.hidden=YES;
        self.composeBarView.likeButton.hidden=NO;
    }

    CGFloat widthChange  = (endFrame.origin.x - startFrame.origin.x) * signCorrection;
    CGFloat heightChange = (endFrame.origin.y - startFrame.origin.y) * signCorrection;

    CGFloat sizeChange = UIInterfaceOrientationIsLandscape([self interfaceOrientation]) ? widthChange : heightChange;

    CGRect newContainerFrame = [[self container] frame];
    newContainerFrame.size.height += sizeChange;

    [UIView animateWithDuration:duration
                          delay:0
                        options:(animationCurve << 16)|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [[self container] setFrame:newContainerFrame];
                         if([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
                             [self.webView.scrollView setContentOffset:CGPointMake(0, self.webView.scrollView.contentOffset.y - heightChange)];
                         }
                     }
                     completion:^(BOOL finished){

                     }];
}

- (void)composeBarViewDidPressButton:(PHFComposeBarView *)composeBarView {
//    NSString *text = [NSString stringWithFormat:@"Main button pressed. Text:\n%@", [composeBarView text]];
//    [self prependTextToTextView:text];
    [composeBarView setText:@"" animated:YES];
    [composeBarView resignFirstResponder];
}

-(void)likeButtonPress:(UIButton *)sender{

}

- (void)composeBarViewDidPressUtilityButton:(PHFComposeBarView *)composeBarView {
    [self prependTextToTextView:@"Utility button pressed"];
}

- (void)composeBarView:(PHFComposeBarView *)composeBarView
   willChangeFromFrame:(CGRect)startFrame
               toFrame:(CGRect)endFrame
              duration:(NSTimeInterval)duration
        animationCurve:(UIViewAnimationCurve)animationCurve
{
    [self prependTextToTextView:[NSString stringWithFormat:@"Height changing by %ld", (long)(endFrame.size.height - startFrame.size.height)]];
    UIEdgeInsets insets = self.webView.scrollView.contentInset;//UIEdgeInsetsMake(0.0f, 0.0f, endFrame.size.height, 0.0f);
    insets.bottom=endFrame.size.height;
    UIWebView *webView = [self webView];
    [webView.scrollView setContentInset:insets];
//    [webView setScrollIndicatorInsets:insets];
}

- (void)composeBarView:(PHFComposeBarView *)composeBarView
    didChangeFromFrame:(CGRect)startFrame
               toFrame:(CGRect)endFrame
{
    [self prependTextToTextView:@"Height changed"];
}

- (void)prependTextToTextView:(NSString *)text {
//    NSString *newText = [text stringByAppendingFormat:@"\n\n%@", [[self webView] text]];
//    [[self webView] setText:newText];
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:kInitialViewFrame];
        [_container setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    }

    return _container;
}


- (MLComposeBarView *)composeBarView {
    if (!_composeBarView) {
        CGRect frame = CGRectMake(0.0f,
                                  kInitialViewFrame.size.height - PHFComposeBarViewInitialHeight,
                                  kInitialViewFrame.size.width,
                                  PHFComposeBarViewInitialHeight);
        _composeBarView = [[MLComposeBarView alloc] initWithFrame:frame];
        _composeBarView.viewController=self;
//        [_composeBarView setMaxCharCount:160];
        [_composeBarView setMaxLinesCount:5];
        [_composeBarView setPlaceholder:@"评论"];
//        [_composeBarView setUtilityButtonImage:[UIImage imageNamed:@"Camera"]];
        [_composeBarView setDelegate:self];
    }

    return _composeBarView;
}

- (UIWebView *)webView {
    if (!_webView) {
        CGRect frame = CGRectMake(0.0f,
                                  0.0f,
                                  kInitialViewFrame.size.width,
                                  kInitialViewFrame.size.height);
        _webView = [[UIWebView alloc] initWithFrame:frame];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//        [_webView setEditable:NO];
        [_webView setBackgroundColor:[UIColor clearColor]];
//        [_webView setAlwaysBounceVertical:YES];
//        [_webView setFont:[UIFont systemFontOfSize:[UIFont labelFontSize]]];
        UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f, PHFComposeBarViewInitialHeight, 0.0f);
//        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://news.qq.com/"]]];
        _webView.scrollView.contentInset=insets;
        _webView.scrollView.scrollsToTop=YES;
//        [_webView setContentInset:insets];
//        [_webView setScrollIndicatorInsets:insets];
//        [_webView setText:@"Welcome to the Demo!\n\nThis is just some placeholder text to give you a better feeling of how the compose bar can be used along other components."];

//        UIView *bubbleView = [[UIView alloc] initWithFrame:CGRectMake(80.0f, 480.0f, 220.0f, 60.0f)];
//        [bubbleView setBackgroundColor:[UIColor colorWithHue:206.0f/360.0f saturation:0.81f brightness:0.99f alpha:1]];
//        [[bubbleView layer] setCornerRadius:25.0f];
//        [_webView addSubview:bubbleView];
    }

    return _webView;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}


-(void)keyboardGoesUped{

}


-(BOOL)textViewWillBecomeFirstResponder{

    return YES;
}
@end
