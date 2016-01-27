//
//  MZProfileViewController.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZProfile.h"
#import "MZMaskZoomTransitioningDelegate.h"

@class MZProfileViewController;

@protocol MZProfileViewControllerDelegate <NSObject>

- (void)MZProfileViewControllerShouldDismiss:(MZProfileViewController *)profileViewController;

@end

@interface MZProfileViewController : UIViewController <MZMaskZoomTransitionPresentedViewController>

@property (nonatomic, weak) id<MZProfileViewControllerDelegate> delegate;

@property (nonatomic) MZProfile *profile;

@end
