//
//  MZSecondViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZSecondViewController.h"

@interface MZSecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation MZSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.circleView.backgroundColor = self.circleColor;
    self.colorLabel.text = self.circleColor.description;
}

#pragma mark - MZMaskZoomTransitionPresentedViewController

@synthesize largeView, viewsToFadeIn;

- (NSArray *)viewsToFadeIn
{
    return @[self.colorLabel];
}

- (UIView *)largeView
{
    return self.circleView;
}

@end
