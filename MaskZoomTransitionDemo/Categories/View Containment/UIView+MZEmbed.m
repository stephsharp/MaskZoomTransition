//
//  UIView+MZEmbed.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIView+MZEmbed.h"

@implementation UIView (MZEmbed)

- (void)mz_addContainerConstraintsToSubview:(UIView *)subview
{
    subview.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(subview);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

@end
