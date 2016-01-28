//
//  MZProfileButton.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZProfile.h"

@interface MZProfileButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame profile:(MZProfile *)profile;
- (instancetype)initWithProfile:(MZProfile *)profile;

@property (nonatomic) MZProfile *profile;

@end
