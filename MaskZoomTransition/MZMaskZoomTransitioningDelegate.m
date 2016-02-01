//
//  MZMaskZoomTransitioningDelegate.m
//  MaskZoomTransition
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZMaskZoomTransitioningDelegate.h"
#import "MZMaskZoomTransition.h"
#import "UIViewController+MZContentViewController.h"

@implementation MZMaskZoomTransitioningDelegate

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    UIViewController *presentedContentViewController = presented.mz_contentViewController;
    [presentedContentViewController.view layoutIfNeeded];

    return [self maskZoomTransitionWithViewController:presentedContentViewController presenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    UIViewController *dismissedContentViewController = dismissed.mz_contentViewController;

    return [self maskZoomTransitionWithViewController:dismissedContentViewController presenting:NO];
}

- (MZMaskZoomTransition *)maskZoomTransitionWithViewController:(UIViewController *)viewController presenting:(BOOL)presenting
{
    MZMaskZoomTransition *animator;

    if ([viewController conformsToProtocol:@protocol(MZMaskZoomTransitionPresentedViewController)]) {
        UIViewController<MZMaskZoomTransitionPresentedViewController> *presentedVC = (UIViewController<MZMaskZoomTransitionPresentedViewController> *)viewController;

        animator = [MZMaskZoomTransition new];
        animator.smallView = self.smallView;
        animator.largeView = presentedVC.largeView;
        animator.viewsToFadeIn = presentedVC.viewsToFadeIn;
        animator.dismissToZeroSize = self.dismissToZeroSize;

        if (!presenting) {
            animator.presenting = NO;
            animator.duration = 0.2;
        }
    }

    return animator;
}

@end
