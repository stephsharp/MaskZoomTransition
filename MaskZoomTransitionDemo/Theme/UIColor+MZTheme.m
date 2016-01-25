//
//  UIColor+MZTheme.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 25/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIColor+MZTheme.h"

@implementation UIColor (MZTheme)

// http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
+ (UIColor *)mz_colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }

    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

    float red = ((baseValue >> 24) & 0xFF) / 255.0f;
    float green = ((baseValue >> 16) & 0xFF) / 255.0f;
    float blue = ((baseValue >> 8) & 0xFF) / 255.0f;
    float alpha = ((baseValue >> 0) & 0xFF) / 255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)mz_colorFromR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b
{
    return [UIColor mz_colorFromR:r G:g B:b A:1.0];
}

+ (UIColor *)mz_colorFromR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a];
}

// http://stackoverflow.com/a/11598127/1367622
- (UIColor *)mz_lighterColor
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MIN(r + 0.25f, 1.0f)
                               green:MIN(g + 0.25f, 1.0f)
                                blue:MIN(b + 0.25f, 1.0f)
                               alpha:a];
    }
    return nil;
}

- (UIColor *)mz_darkerColor
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MAX(r - 0.25f, 0.0f)
                               green:MAX(g - 0.25f, 0.0f)
                                blue:MAX(b - 0.25f, 0.0f)
                               alpha:a];
    }
    return nil;
}

#pragma mark - Theme colors

+ (UIColor *)mz_defaultTintColor
{
    return [UIColor mz_colorFromHexCode:@"007AFF"];
}

+ (UIColor *)mz_lightGreyColor
{
    return [UIColor mz_colorFromHexCode:@"F2F2F2"];
}

@end
