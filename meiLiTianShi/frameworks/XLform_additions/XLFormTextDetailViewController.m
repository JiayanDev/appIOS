//
//  InputsFormViewController.m
//  XLForm ( https://github.com/xmartlabs/XLForm )
//
//  Copyright (c) 2014 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "XLFormTextDetailViewController.h"
#import "RegExCategories.h"
#import <objc/runtime.h>

#import "NSDate+XLformPushDisplay.h"

#import "MLXLFormTextFieldCell.h"


@implementation XLFormRowDescriptor(push)

-(void)setPushConfigs:(NSMutableDictionary *)newPushConfigs{
    objc_setAssociatedObject(self, @selector(pushConfigs), newPushConfigs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSMutableDictionary *)pushConfigs {
    if(objc_getAssociatedObject(self, @selector(pushConfigs))){
        return objc_getAssociatedObject(self, @selector(pushConfigs));
    }else{
        objc_setAssociatedObject(self, @selector(pushConfigs), [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return objc_getAssociatedObject(self, @selector(pushConfigs));
    }

}
@end


@interface XLFormTextDetailViewController ()
@property XLFormRowDescriptor* row;
@property BOOL alreadyInit;

@end



@implementation XLFormTextDetailViewController
@synthesize rowDescriptor = _rowDescriptor;
@synthesize popoverController = __popoverController;


-(id)initWithRowDescriptor:(XLFormRowDescriptor *)rowDescriptor
{
    self.rowDescriptor=rowDescriptor;
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:rowDescriptor.title];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:nil];
    //section.footerTitle = @"This is a long text that will appear on section footer";
    [formDescriptor addFormSection:section];
    
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:rowDescriptor.pushConfigs[kPushInnerRowType] title:@""];
    row.required = YES;
    row.value=self.rowDescriptor.value;
//    row.validators=self.rowDescriptor.validators;
    
    self.row=row;
    [section addFormRow:row];
    
    self.alreadyInit=YES;
    self.title=self.rowDescriptor.pushConfigs[kPushInnerTitle]?self.rowDescriptor.pushConfigs[kPushInnerTitle]:self.rowDescriptor.title;
    return [super initWithForm:formDescriptor];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(savePressed:)];
    if(!self.alreadyInit){
        [self initWithRowDescriptor:self.rowDescriptor];
    }
}




-(IBAction)savePressed:(UIBarButtonItem * __unused)button
{
    button.enabled = NO;
    NSLog(@"button :%@", button);
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        button.enabled=YES;
        return;
    }

    if([[self.row cellForFormController:self] isKindOfClass:[XLFormTextFieldCell class]]){
    NSString *s= ((XLFormTextFieldCell *)[self.row cellForFormController:self]).textField.text;
    if([self.rowDescriptor.pushConfigs[kPushInnerRowType] isEqualToString: XLFormRowDescriptorTypeDecimal]){
        if([s isMatch:RX(@"^\\-?\\d+(\\.\\d*)?$")]){
            //continue
        }else{
            button.enabled=YES;
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"错误"
                                                           message:@"请输入合法的数字"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }else if([self.rowDescriptor.pushConfigs[kPushInnerRowType] isEqualToString: XLFormRowDescriptorTypeInteger]){
        if([s isMatch:RX(@"^\\-?\\d+$")]){
            //continue
        }else{
            button.enabled=YES;
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"错误"
                                                           message:@"请输入合法的整数"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    }

    [self.tableView endEditing:YES];
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil) message:@"No errors found" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//    [alertView show];
    
    [self.rowDescriptor setValue :self.row.value ];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
