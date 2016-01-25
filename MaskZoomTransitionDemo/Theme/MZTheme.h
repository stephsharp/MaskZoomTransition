//
//  MZTheme.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 2/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZTheme : NSObject

+ (void)setupAppTheme;

+ (UIColor *)globalTintColor;
+ (void)setGlobalTintColor:(UIColor *)globalTintColor;

@end
