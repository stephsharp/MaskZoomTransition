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

#pragma mark - Theme colors

+ (UIColor *)mz_defaultTintColor
{
    return [UIColor mz_colorFromHexCode:@"2979FF"];
}

+ (UIColor *)mz_lightGreyColor
{
    return [UIColor mz_colorFromHexCode:@"F2F2F2"];
}

@end
