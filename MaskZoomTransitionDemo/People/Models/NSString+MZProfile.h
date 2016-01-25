//
//  NSString+MZProfile.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (MZProfile)

- (NSString *)mz_uppercaseInitial;
- (UIImage *)mz_placeholderImageFromStringWithSize:(CGFloat)size;

@end
