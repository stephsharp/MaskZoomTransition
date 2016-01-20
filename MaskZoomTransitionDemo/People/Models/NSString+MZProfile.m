//
//  NSString+MZProfile.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "NSString+MZProfile.h"

@implementation NSString (MZProfile)

- (NSString *)uppercaseInitial
{
    if (self.length > 0) {
        return [[self substringToIndex:1] uppercaseString];
    }

    return @"";
}

- (UIImage *)placeholderImageFromStringWithSize:(CGFloat)size
{
    CGRect rect = CGRectMake(0, 0, size, size);

    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);

    // Set background colour
    UIColor *globalTint = [UIApplication sharedApplication].delegate.window.tintColor;
    [globalTint setFill];
    UIRectFill(rect);

    // Set the font style and size
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];

    CGFloat fontSize = size / 2.4f;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor], NSForegroundColorAttributeName,
                          font, NSFontAttributeName,
                          style, NSParagraphStyleAttributeName, nil];

    CGFloat verticalOffset = CGRectGetMidY(rect) - (font.lineHeight / 2.0f);
    rect.origin.y = verticalOffset;

    [self drawInRect:rect withAttributes:attr];

    // Get image
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return image;
}

@end
