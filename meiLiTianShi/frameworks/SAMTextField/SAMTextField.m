//
//  SAMTextField.m
//  SAMTextField
//
//  Created by Sam Soffes on 3/11/10.
//  Copyright 2010-2014 Sam Soffes. All rights reserved.
//

#import "SAMTextField.h"
@interface SAMTextField()
///------------------------------
/// @name Drawing and Positioning
///------------------------------

/**
 The inset or outset margins for the edges of the text content drawing rectangle.
 
 Use this property to resize and reposition the effective drawing rectangle for the text content. You can specify a
 different value for each of the four insets (top, left, bottom, right). A positive value shrinks, or insets, that
 edge—moving it closer to the center of the button. A negative value expands, or outsets, that edge. Use the
 `UIEdgeInsetsMake` function to construct a value for this property.
 
 The default value is `UIEdgeInsetsZero`.
 */
@property (nonatomic)  UIEdgeInsets textEdgeInsets;

/**
 The inset or outset margins for the edges of the clear button drawing rectangle.
 
 Use this property to resize and reposition the effective drawing rectangle for the clear button content. You can
 specify a different value for each of the four insets (top, left, bottom, right), but only the top and right insets are
 respected. A positive value will move the clear button farther away from the top right corner. Use the
 `UIEdgeInsetsMake` function to construct a value for this property.
 
 The default value is `UIEdgeInsetsZero`.
 */
@property (nonatomic) UIEdgeInsets clearButtonEdgeInsets;

/**
 The inset or outset margins for the edges of the view assigned to `rightView`.
 
 Use this property to resize and reposition the effective drawing rectangle for the right view content. You can
 specify a different value for each of the four insets (top, left, bottom, right), but only the top and right insets are
 respected. A positive value will move the view farther away from the top right corner. Use the
 `UIEdgeInsetsMake` function to construct a value for this property.
 
 The default value is `UIEdgeInsetsZero`.
 */
@property (nonatomic) UIEdgeInsets rightViewInsets;

/**
 The inset or outset margins for the edges of the view assigned to `leftView`.
 
 Use this property to resize and reposition the effective drawing rectangle for the left view content. You can
 specify a different value for each of the four insets (top, left, bottom, right), but only the top and right insets are
 respected. A positive value will move the view farther away from the top right corner. Use the
 `UIEdgeInsetsMake` function to construct a value for this property.
 
 The default value is `UIEdgeInsetsZero`.
 */
@property (nonatomic) UIEdgeInsets leftViewInsets;
@end

@implementation SAMTextField

#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.leftAndRight=2.0;
        self.UpAndDown=2.0;
        [self initialize];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self initialize];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}


- (void)prepareForInterfaceBuilder {
    
    [self initialize];
}

#pragma mark - UITextField

- (CGRect)textRectForBounds:(CGRect)bounds {
  return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], self.textEdgeInsets);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
  return [self textRectForBounds:bounds];
}


- (CGRect)placeholderRectForBounds:(CGRect)bounds {
  return [self textRectForBounds:bounds];
}


- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
	CGRect rect = [super clearButtonRectForBounds:bounds];
	rect.origin.x += self.clearButtonEdgeInsets.right;
	rect.origin.y += self.clearButtonEdgeInsets.top;
	return rect;
}

//
//- (CGRect)rightViewRectForBounds:(CGRect)bounds {
//	CGRect rect = [super rightViewRectForBounds:bounds];
//	rect.origin.x += self.rightViewInsets.right;
//	rect.origin.y += self.rightViewInsets.top;
//	return rect;
//}
//
//
//- (CGRect)leftViewRectForBounds:(CGRect)bounds {
//    CGRect rect = [super leftViewRectForBounds:bounds];
//	rect.origin.x += self.leftViewInsets.left;
//	rect.origin.y += self.leftViewInsets.top;
//	return rect;
//}


#pragma mark - Private

- (void)initialize {
    self.textEdgeInsets=UIEdgeInsetsMake(self.UpAndDown, self.leftAndRight, self.UpAndDown, self.leftAndRight);
        self.clearButtonEdgeInsets=UIEdgeInsetsMake(self.UpAndDown, self.leftAndRight, self.UpAndDown, self.leftAndRight);
    [self setNeedsLayout];
//  self.textEdgeInsets = UIEdgeInsetsZero;
//  self.clearButtonEdgeInsets = UIEdgeInsetsZero;
//    self.leftViewInsets = UIEdgeInsetsZero;
//    self.rightViewInsets = UIEdgeInsetsZero;
}

@end
