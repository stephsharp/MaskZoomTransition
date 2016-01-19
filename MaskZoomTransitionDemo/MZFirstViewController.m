//
//  MZFirstViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZFirstViewController.h"
#import "MZMaskZoomTransitioningDelegate.h"
#import "MZSecondViewController.h"
//#import "UIViewController+MZContentViewController.h"

@interface MZFirstViewController ()

@property (weak, nonatomic) IBOutlet UIButton *circleButton;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (nonatomic) MZMaskZoomTransitioningDelegate *transitioningDelegate;

@end

@implementation MZFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTap:)];
    [self.circleView addGestureRecognizer:tap];
}

#pragma mark - Properties

- (MZMaskZoomTransitioningDelegate *)transitioningDelegate
{
    if (!_transitioningDelegate) {
        _transitioningDelegate = [MZMaskZoomTransitioningDelegate new];
    }
    return _transitioningDelegate;
}

#pragma mark - Actions

- (IBAction)buttonTap:(id)sender
{
    [self performSegueWithIdentifier:@"MaskZoomSegue" sender:sender];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    UIViewController *contentViewController = segue.destinationViewController.mz_contentViewController;

    if ([[segue identifier] isEqualToString:@"MaskZoomSegue"]) {
        UIView *smallView;

        if ([sender isKindOfClass:[UIButton class]]) {
            smallView = self.circleButton;
        }
        else {
            smallView = self.circleView;
        }

        MZSecondViewController *secondVC = (MZSecondViewController *)segue.destinationViewController;
        secondVC.circleColor = smallView.backgroundColor;

        self.transitioningDelegate.smallView = smallView;
        segue.destinationViewController.transitioningDelegate = self.transitioningDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

@end
