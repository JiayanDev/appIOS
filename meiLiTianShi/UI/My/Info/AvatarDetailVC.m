//
//  AvatarDetailVC.m
//  meiLiTianShi
//
//  Created by zcw on 15/8/3.
//  Copyright (c) 2015年 Jiayan Technologies Co., Ltd. All rights reserved.
//

#import "AvatarDetailVC.h"
#import "MLSession.h"
#import "TSMessage.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface AvatarDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (nonatomic, strong)NSString *avatarUrl;

@end

@implementation AvatarDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                             style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(submit)];

    if([self.rowDescriptor.value isKindOfClass:[UIImage class]]){
        self.avatar.image=self.rowDescriptor.value;
    }else{
        [self.avatar sd_setImageWithURL:self.rowDescriptor.value
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.avatar.image=image;
                                  [self.avatar needsUpdateConstraints];
                                  [self.avatar setNeedsDisplay];
                              }];
    }

}


- (IBAction)changeAvatarButtonPress:(id)sender {
    UIImagePickerController *picker= [[UIImagePickerController alloc] init];
    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.mediaTypes = @[(NSString *) kUTTypeImage];
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)submit{

    if(self.avatarUrl){
        self.rowDescriptor.value=self.avatarUrl;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = (UIImage *) info[UIImagePickerControllerOriginalImage];
    self.avatar.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES].labelText=@"上传中";

    [[MLSession current] getImageUploadPolicyAndSignatureWithMod:@"avatar"
                                                         Success:^(UploadTokenModel *model) {
                                                             [[MLSession current] uploadOneImage:image
                                                                                     uploadToken:model
                                                                                         success:^(NSString *url) {
                                                                                             //self.rowDescriptor.value=url;
                                                                                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                                                             self.avatarUrl=url;


                                                                                         } fail:^(NSInteger i, id o) {
                                                                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                                         [TSMessage showNotificationWithTitle:@"出错了"
                                                                                                     subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                                                                         type:TSMessageNotificationTypeError];
                                                                     }];

                                                         } fail:^(NSInteger i, id o) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [TSMessage showNotificationWithTitle:@"出错了"
                                            subtitle:[NSString stringWithFormat:@"%d - %@", i, o]
                                                type:TSMessageNotificationTypeError];
            }];


}
@end
