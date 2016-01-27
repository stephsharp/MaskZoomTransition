//
//  UIView+MZNavigationBar.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MZNavigationBar)

- (void)mz_hideBottomHairlineAnimated:(BOOL)animated;
- (void)mz_showBottomHairlineAnimated:(BOOL)animated;
- (BOOL)mz_hairlineIsVisible;

@end
