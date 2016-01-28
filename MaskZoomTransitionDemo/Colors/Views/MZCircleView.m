//
//  MZCircleView.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZCircleView.h"

@implementation MZCircleView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    self.layer.cornerRadius = CGRectGetMidX(self.bounds);
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetMidX(self.bounds);
}

@end
