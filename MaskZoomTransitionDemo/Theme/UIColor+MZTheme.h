//
//  UIColor+MZTheme.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 25/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MZTheme)

+ (UIColor *)mz_colorFromHexCode:(NSString *)hexString;
+ (UIColor *)mz_colorFromR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
+ (UIColor *)mz_colorFromR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

- (UIColor *)mz_lighterColor;
- (UIColor *)mz_darkerColor;

+ (UIColor *)mz_defaultTintColor;
+ (UIColor *)mz_lightGreyColor;

@end
