//
//  UIView+MZNavigationBar.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIView+MZNavigationBar.h"

@implementation UIView (MZNavigationBar)

static NSTimeInterval const MZDefaultDuration = 0.2;

- (void)mz_hideBottomHairlineAnimated:(BOOL)animated
{
    UIImageView *navigationBarImageView = [self mz_hairlineImageViewInNavigationBar];
    NSTimeInterval duration = animated ? MZDefaultDuration : 0;

    [UIView animateWithDuration:duration animations:^{
        navigationBarImageView.alpha = 0.0f;
    }];
}

- (void)mz_showBottomHairlineAnimated:(BOOL)animated
{
    UIImageView *navigationBarImageView = [self mz_hairlineImageViewInNavigationBar];
    NSTimeInterval duration = animated ? MZDefaultDuration : 0;

    [UIView animateWithDuration:duration animations:^{
        navigationBarImageView.alpha = 1.0f;
    }];
}

- (BOOL)mz_hairlineIsVisible
{
    UIImageView *navigationBarImageView = [self mz_hairlineImageViewInNavigationBar];
    return (navigationBarImageView.alpha > 0.0f);
}

- (UIImageView *)mz_hairlineImageViewInNavigationBar
{
    if ([self isKindOfClass:UIImageView.class] && self.bounds.size.height <= 1.0) {
        return (UIImageView *)self;
    }
    for (UIView *subview in self.subviews) {
        UIImageView *imageView = [subview mz_hairlineImageViewInNavigationBar];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
