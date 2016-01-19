//
//  UIViewController+MZContentViewController.m
//  MaskZoomTransition
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
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
