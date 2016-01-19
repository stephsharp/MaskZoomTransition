//
//  MZSecondViewController.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZMaskZoomTransitioningDelegate.h"

@interface MZSecondViewController : UIViewController <MZMaskZoomTransitionPresentedViewController>

@property (nonatomic) UIColor *circleColor;

@end
