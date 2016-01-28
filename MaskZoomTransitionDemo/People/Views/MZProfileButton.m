//
//  MZProfileButton.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfileButton.h"
#import "UIColor+MZTheme.h"

@implementation MZProfileButton

static CGFloat const MZDefaultSize = 28.0f;

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame profile:(MZProfile *)profile
{
    self = [super initWithFrame:frame];
    if (self) {
        _profile = profile;
        [self setupProfileButton];
    }
    return self;
}

- (instancetype)initWithProfile:(MZProfile *)profile
{
    CGRect frame = CGRectMake(0, 0, MZDefaultSize, MZDefaultSize);
    return [self initWithFrame:frame profile:profile];
}

#pragma mark - Setup

- (void)setupProfileButton
{
    self.adjustsImageWhenHighlighted = NO;
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0f;
    self.layer.masksToBounds = YES;

    [self setPhoto];
}

- (void)setPhoto
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setImage:self.profile.profileImage forState:UIControlStateNormal];
        [self addBorder];
    });
}

- (void)addBorder
{
    CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
    self.layer.borderWidth = onePixel;
    self.layer.borderColor = [UIColor mz_lightGreyColor].CGColor;
}

@end
