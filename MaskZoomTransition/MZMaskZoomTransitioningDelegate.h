//
//  MZMaskZoomTransitioningDelegate.h
//  MaskZoomTransition
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MZMaskZoomTransitionPresentedViewController <NSObject>

@property (nonatomic, weak) UIView *largeView;
@property (nonatomic, weak) NSArray *viewsToFadeIn;

@end

@interface MZMaskZoomTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIView *smallView;
@property (nonatomic) BOOL dismissToZeroSize;

@end
