//
//  MZTopImageButton.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZTopImageButton.h"

@interface MZTopImageButton ()
@property (nonatomic) BOOL isInterfaceBuilder;
@end

@implementation MZTopImageButton

#pragma mark - Initializers

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
    [self setupInspectableDefaults];
    [self layoutButton];
}

- (void)setupInspectableDefaults
{
    self.padding = 5.0f;
}

#pragma mark - Layout

- (void)layoutButton
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;

    if (self.isInterfaceBuilder) {
        // For some reason self.imageView.frame.size.width does not work in IB
        imageSize = [self.imageView intrinsicContentSize];
        titleSize = [self.titleLabel intrinsicContentSize];
    }

    CGFloat totalHeight = imageSize.height + titleSize.height + self.padding;

    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0, 0, -(titleSize.width));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width), -(totalHeight - titleSize.height), 0);

    [self invalidateIntrinsicContentSize];
}

#pragma mark - Properties

- (void)setPadding:(CGFloat)padding
{
    _padding = padding;
    [self layoutButton];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self layoutButton];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self layoutButton];
}

#pragma mark - UIView

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicImageViewSize = [self.imageView intrinsicContentSize];
    CGSize intrinsicTitleLabelSize = [self.titleLabel intrinsicContentSize];

    CGFloat width = MAX(intrinsicImageViewSize.width, intrinsicTitleLabelSize.width);
    CGFloat height = intrinsicImageViewSize.height + self.padding + intrinsicTitleLabelSize.height;

    return CGSizeMake(width, height);
}

- (void)tintColorDidChange
{
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    [super tintColorDidChange];
}

#pragma mark - Interface Builder

- (void)prepareForInterfaceBuilder
{
    self.isInterfaceBuilder = YES;

    // Need this to make Interface Builder render image in tint color
    UIImage *image = [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self setImage:image forState:UIControlStateNormal];

    [self tintColorDidChange];
}

@end
