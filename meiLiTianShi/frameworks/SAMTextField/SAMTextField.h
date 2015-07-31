//
//  SAMTextField.h
//  SAMTextField
//
//  Created by Sam Soffes on 3/11/10.
//  Copyright 2010-2014 Sam Soffes. All rights reserved.
//



/**
 Simple UITextField subclass to adds text insets.
 */
IB_DESIGNABLE
@interface SAMTextField : UITextField
@property(nonatomic,assign)IBInspectable CGFloat leftAndRight;
@property(nonatomic,assign)IBInspectable CGFloat UpAndDown;


@end
