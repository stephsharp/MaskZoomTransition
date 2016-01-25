//
//  MZSecondViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZSecondViewController.h"
#import "MZTheme.h"

@interface MZSecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *colorLabelRGB;
@property (weak, nonatomic) IBOutlet UILabel *colorLabelHSL;
@property (weak, nonatomic) IBOutlet UILabel *colorLabelHex;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)close:(UIButton *)button;

@end

@implementation MZSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.circleView.backgroundColor = self.circleColor;
    self.closeButton.tintColor = self.circleColor;
    [self setColorLabels];
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

- (void)close:(UIButton *)button
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
