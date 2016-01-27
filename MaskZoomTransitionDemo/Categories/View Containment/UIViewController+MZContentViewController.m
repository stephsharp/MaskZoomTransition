//
//  UIViewController+MZContentViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIViewController+MZContentViewController.h"

@implementation UIViewController (MZContentViewController)

- (UIViewController *)mz_contentViewController
{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navcon = (UINavigationController *)self;
        return navcon.visibleViewController;
    }
    return self;
}

@end
