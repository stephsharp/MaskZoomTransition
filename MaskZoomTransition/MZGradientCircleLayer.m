//
//  MZGradientCircleLayer.m
//  MaskZoomTransition
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZGradientCircleLayer.h"

@implementation MZGradientCircleLayer

- (void)drawInContext:(CGContextRef)context
{
    CGPoint origin = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat gradientRadius = CGRectGetWidth(self.bounds) / 2.0f;
    CGFloat innerCircleRadius = gradientRadius - self.gradientWidth;

    CGColorSpaceRef baseColorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colours[8] = { 0.0f, 0.0f, 0.0f, 1.0f,
                           0.0f, 0.0f, 0.0f, 0.0f
                         };
    CGFloat colourLocations[2] = { 0.0f, 1.0f };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseColorSpace, colours, colourLocations, 2);

    CGContextDrawRadialGradient(context, gradient, origin, innerCircleRadius, origin, gradientRadius, kCGGradientDrawsBeforeStartLocation);

    CGColorSpaceRelease(baseColorSpace);
    CGGradientRelease(gradient);
}

@end
