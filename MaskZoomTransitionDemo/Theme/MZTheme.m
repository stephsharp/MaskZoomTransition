//
//  MZTheme.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 2/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZTheme.h"
#import "UIColor+MZTheme.h"

@implementation MZTheme

+ (void)setupAppTheme
{
    [MZTheme setGlobalTintColor:[UIColor mz_defaultTintColor]];
    [MZTheme setTableCellSelectionColor];
}

+ (UIColor *)globalTintColor
{
    return [UIApplication sharedApplication].delegate.window.tintColor;
}

+ (void)setGlobalTintColor:(UIColor *)globalTintColor
{
    [UIApplication sharedApplication].delegate.window.tintColor = globalTintColor;
}

+ (void)setTableCellSelectionColor
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor mz_lightGreyColor];
    [UITableViewCell appearance].selectedBackgroundView = view;
}

@end
