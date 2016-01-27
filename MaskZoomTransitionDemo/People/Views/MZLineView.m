//
//  MZLineView.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZLineView.h"

@implementation MZLineView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self drawOnePixelLine];
}

- (void)drawOnePixelLine
{
    CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, onePixel)];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;

    lineView.backgroundColor = self.backgroundColor;
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:lineView];

    // Add constraints
    NSDictionary *views = NSDictionaryOfVariableBindings(lineView);
    NSString *horizontalVFS = @"H:|[lineView]|";
    NSString *verticalVFS = [NSString stringWithFormat:@"V:|[lineView(%f)]", onePixel];

    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalVFS options:0 metrics:nil views:views];
    NSArray *verticalConstriants = [NSLayoutConstraint constraintsWithVisualFormat:verticalVFS options:0 metrics:nil views:views];
    [self addConstraints:[horizontalConstraints arrayByAddingObjectsFromArray:verticalConstriants]];
}

@end
