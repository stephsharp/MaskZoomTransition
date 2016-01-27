//
//  MZMaskZoomTransition.m
//  MaskZoomTransition
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZMaskZoomTransition.h"
#import "MZGradientCircleLayer.h"

@interface MZMaskZoomTransition ()

@property (nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic) UIViewController *toViewController;
@property (nonatomic) UIViewController *fromViewController;
@property (nonatomic) UIView *containerView;
@property (nonatomic) UIView *toView;
@property (nonatomic) UIView *fromView;
@property (nonatomic) UIView *maskView;
@property (nonatomic) UIView *shadowView;
@property (nonatomic) UIView *largeViewSnapshot;

@property (nonatomic) CGRect smallFrame;
@property (nonatomic) CGRect largeFrame;
@property (nonatomic) CGRect largeCircleFrame;
@property (nonatomic) CGFloat smallScale;

@end

@implementation MZMaskZoomTransition

static NSTimeInterval const MZDefaultDuration = 0.25;
static CGFloat const MZGradientWidth = 80.0f;
static CGFloat const MZDefaultFadeInOffset = 8.0f;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = MZDefaultDuration;
        _presenting = YES;
        _dismissToZeroSize = NO;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    [self setupPropertiesForTransition];

    self.toView.hidden = YES;
    [self.containerView addSubview:self.toView];

    // Start appearance transition for source controller because UIKit
    // does not remove views from hierarchy when transition is finished.
    if (self.presenting) {
        [self.fromViewController beginAppearanceTransition:NO animated:YES];
    }
    else {
        [self.toViewController beginAppearanceTransition:YES animated:YES];
    }

    // Need to wrap the snapshot in a dispatch_async block, otherwise it's nil
    dispatch_async(dispatch_get_main_queue(), ^{
        self.largeViewSnapshot = [self.largeView snapshotViewAfterScreenUpdates:NO];
        self.largeFrame = [self.largeView convertRect:self.largeView.bounds toView:nil];
        self.toView.hidden = NO;

        [self animateCircleMask];
        [self animateShadowView];
        [self animateMainView];
        [self fadeViews];
    });
}

- (void)setupPropertiesForTransition
{
    self.toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.containerView = [self.transitionContext containerView];
    self.toView = [self.transitionContext viewForKey:UITransitionContextToViewKey];
    self.fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    self.maskView = self.presenting ? self.toView : self.fromView;
    self.smallFrame = [self.smallView convertRect:self.smallView.bounds toView:nil];

    if (!self.presenting && self.dismissToZeroSize) {
        CGPoint center = [self centerOfRect:self.smallFrame];
        self.smallFrame = CGRectMake(center.x, center.y, 1.0f, 1.0f);
    }

    self.largeCircleFrame = [self calculateLargeCircleFrame];
    self.smallScale = CGRectGetWidth(self.smallFrame) / CGRectGetWidth(self.largeCircleFrame);
}

#pragma mark - Animators

- (void)animateCircleMask
{
    MZGradientCircleLayer *maskLayer = [MZGradientCircleLayer layer];
    maskLayer.position = [self centerOfRect:self.largeCircleFrame];
    maskLayer.frame = self.largeCircleFrame;
    maskLayer.gradientWidth = MZGradientWidth;

    CGFloat initialScale = self.presenting ? self.smallScale : 1.0f;
    CGFloat finalScale = self.presenting ? 1.0f : self.smallScale;

    maskLayer.transform = CATransform3DMakeScale(initialScale, initialScale, initialScale);
    [maskLayer setNeedsDisplay];

    self.maskView.layer.mask = maskLayer;

    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    maskLayerAnimation.fromValue = @(initialScale);
    maskLayer.transform = CATransform3DMakeScale(finalScale, finalScale, finalScale);
    maskLayerAnimation.toValue = @(finalScale);
    maskLayerAnimation.duration = [self transitionDuration:self.transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"transform.scale"];
}

- (void)animateShadowView
{
    self.shadowView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    self.shadowView.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:0.6f];

    self.shadowView.alpha = self.presenting ? 0.0f : 1.0f;
    CGFloat finalAlpha = self.presenting ? 1.0f : 0.0f;

    [self.containerView insertSubview:self.shadowView belowSubview:self.maskView];

    [UIView animateWithDuration:[self transitionDuration:self.transitionContext]
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.shadowView.alpha = finalAlpha;
                     } completion:nil];
}

- (void)animateMainView
{
    CGRect initialFrame = self.presenting ? self.smallFrame : self.largeFrame;
    CGRect finalFrame = self.presenting ? self.largeFrame: self.smallFrame;

    CGAffineTransform scaleTransform = [self scaleTransformForInitialFrame:initialFrame finalFrame:finalFrame];
    CGAffineTransform initialTransform = self.presenting ? scaleTransform : CGAffineTransformIdentity;
    CGAffineTransform finalTransform = self.presenting ? CGAffineTransformIdentity : scaleTransform;

    self.largeViewSnapshot.transform = initialTransform;
    self.largeViewSnapshot.center = [self centerOfRect:initialFrame];

    [self.containerView addSubview:self.largeViewSnapshot];
    self.largeView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:self.transitionContext]
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.largeViewSnapshot.transform = finalTransform;
                         self.largeViewSnapshot.center = [self centerOfRect:finalFrame];
                     }
                     completion:^(BOOL finished) {
                         self.largeView.hidden = NO;
                         [self.largeViewSnapshot removeFromSuperview];
                     }];
}

- (void)fadeViews
{
    CGFloat offset = MZDefaultFadeInOffset * [UIScreen mainScreen].scale;

    for (UIView *view in self.viewsToFadeIn) {
        NSTimeInterval transitionDuration = [self transitionDuration:self.transitionContext];
        NSTimeInterval duration = self.presenting ? transitionDuration * 0.9 : transitionDuration * 0.4;
        NSTimeInterval delay = self.presenting ? duration * 0.9 : 0.0;

        view.alpha = self.presenting ? 0.0f : 1.0f;
        CGFloat finalAlpha = self.presenting ? 1.0f : 0.0f;

        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             view.alpha = finalAlpha;
                         } completion:nil];

        if (self.presenting) {
            CGPoint finalCenter = view.center;
            view.center = CGPointMake(view.center.x, view.center.y + offset);

            [UIView animateWithDuration:duration
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 view.center = finalCenter;
                             } completion:^(BOOL finished) {
                                 if ([view isEqual:self.viewsToFadeIn.lastObject]) {
                                     [self completeTransition];
                                 }
                             }];
        }
    }
}

#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!self.presenting || self.viewsToFadeIn.count == 0) {
        [self completeTransition];
    }
}

- (void)completeTransition
{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    self.toView.layer.mask = nil;
    [self.shadowView removeFromSuperview];

    if (self.presenting) {
        [self.fromViewController endAppearanceTransition];
    }
    else {
        [self.toViewController endAppearanceTransition];
    }
}

#pragma mark - Calculations

- (CGRect)calculateLargeCircleFrame
{
    CGPoint smallViewCenter = [self centerOfRect:self.smallFrame];
    CGPoint extremePoint = [self farthestCornerOfRect:self.maskView.bounds fromPoint:smallViewCenter];

    CGFloat radiusToEdgeOfView = [self distanceBetweenPoint1:smallViewCenter point2:extremePoint];
    CGFloat largeCircleRadius = radiusToEdgeOfView + MZGradientWidth;

    CGRect zeroRectCenteredOnSmallView = CGRectMake(smallViewCenter.x, smallViewCenter.y, 0.0f, 0.0f);
    CGRect largeCircleFrame = CGRectInset(zeroRectCenteredOnSmallView, -largeCircleRadius, -largeCircleRadius);

    return largeCircleFrame;
}

- (CGPoint)farthestCornerOfRect:(CGRect)rect fromPoint:(CGPoint)point
{
    CGPoint extremePoint = CGPointZero;

    if (point.x < CGRectGetMidX(rect)) {
        extremePoint.x = CGRectGetMaxX(rect);
    }
    if (point.y < CGRectGetMidY(rect)) {
        extremePoint.y = CGRectGetMaxY(rect);
    }

    return extremePoint;
}

- (CGFloat)distanceBetweenPoint1:(CGPoint)p1 point2:(CGPoint)p2
{
    float dx = (float)(p2.x - p1.x);
    float dy = (float)(p2.y - p1.y);

    return hypotf(dx, dy);
}

- (CGAffineTransform)scaleTransformForInitialFrame:(CGRect)initialFrame finalFrame:(CGRect)finalFrame
{
    CGFloat xScaleFactor, yScaleFactor;

    if (self.presenting) {
        xScaleFactor = CGRectGetWidth(initialFrame) / CGRectGetWidth(finalFrame);
        yScaleFactor = CGRectGetHeight(initialFrame) / CGRectGetHeight(finalFrame);
    }
    else {
        xScaleFactor = CGRectGetWidth(finalFrame) / CGRectGetWidth(initialFrame);
        yScaleFactor = CGRectGetHeight(finalFrame) / CGRectGetHeight(initialFrame);
    }

    return CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
}

- (CGPoint)centerOfRect:(CGRect)rect
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

@end
