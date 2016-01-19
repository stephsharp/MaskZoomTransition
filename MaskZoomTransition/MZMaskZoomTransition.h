//
//  MZMaskZoomTransition.h
//  MaskZoomTransition
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZMaskZoomTransition : NSObject <UIViewControllerAnimatedTransitioning>

/**
 * Small view to transition from.
 */
@property (nonatomic) UIView *smallView;

/**
 * Large view to transition to.
 */
@property (nonatomic) UIView *largeView;

/**
 * Views to fade in at the end of the transition.
 */
@property (nonatomic) NSArray *viewsToFadeIn;

/**
 * Default is 0.25 seconds.
 */
@property (nonatomic) NSTimeInterval duration;

/**
 * Default is YES. Set to NO when dismissing a view controller.
 */
@property (nonatomic) BOOL presenting;

/**
 * Default is NO. Set to YES if you want the dismiss transition to shrink the view down to zero.
 * This is useful if the smallView in the presentingViewController is no longer visible.
 */
@property (nonatomic) BOOL dismissToZeroSize;

@end
