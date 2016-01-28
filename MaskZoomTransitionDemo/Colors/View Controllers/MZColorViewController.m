//
//  MZColorViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZColorViewController.h"
#import "MZTheme.h"
#import "UIView+MZNavigationBar.h"

@interface MZColorViewController ()

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *colorLabelRGB;
@property (weak, nonatomic) IBOutlet UILabel *colorLabelHSL;
@property (weak, nonatomic) IBOutlet UILabel *colorLabelHex;

@end

@implementation MZColorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.circleView.backgroundColor = self.circleColor;
    [self setColorLabels];

    self.navigationItem.leftBarButtonItem.tintColor = self.circleColor;
    [self.navigationController.navigationBar mz_hideBottomHairlineAnimated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [MZTheme setGlobalTintColor:self.circleColor];
}

- (void)setColorLabels
{
    CGFloat r = 0.0, g = 0.0, b = 0.0;
    CGFloat h = 0.0, s = 0.0, l = 0.0;
    [self.circleColor getRed:&r green:&g blue:&b alpha:NULL];
    [self.circleColor getHue:&h saturation:&s brightness:&l alpha:NULL];

    int red = r * 255, green = g * 255, blue = b * 255;
    int hue = h * 100, saturation = s * 100, lightness = l * 100;

    self.colorLabelRGB.text = [NSString stringWithFormat:@"R:%d G:%d B:%d", red, green, blue];
    self.colorLabelHSL.text = [NSString stringWithFormat:@"H:%d S:%d L:%d", hue, saturation, lightness];
    self.colorLabelHex.text = [NSString stringWithFormat:@"#%02X%02X%02X", red, green, blue];
}

#pragma mark - Actions

- (IBAction)dismiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MZMaskZoomTransitionPresentedViewController

@synthesize largeView, viewsToFadeIn;

- (NSArray *)viewsToFadeIn
{
    return @[self.colorLabelRGB, self.colorLabelHSL, self.colorLabelHex];
}

- (UIView *)largeView
{
    return self.circleView;
}

@end
