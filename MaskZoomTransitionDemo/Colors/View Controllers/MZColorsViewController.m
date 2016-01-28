//
//  MZColorsViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 16/12/2015.
//  Copyright © 2015 Stephanie Sharp. All rights reserved.
//

#import "MZColorsViewController.h"
#import "MZMaskZoomTransitioningDelegate.h"
#import "MZColorViewController.h"
#import "UIViewController+MZContentViewController.h"

@interface MZColorsViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *circleButtons;
@property (nonatomic) MZMaskZoomTransitioningDelegate *transitioningDelegate;

@end

@implementation MZColorsViewController

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

- (IBAction)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MaskZoomSegue"]) {
        MZColorViewController *colorVC = (MZColorViewController *)segue.destinationViewController.mz_contentViewController;
        UIButton *button = (UIButton *)sender;

        colorVC.circleColor = button.backgroundColor;
        self.transitioningDelegate.smallView = button;

        segue.destinationViewController.transitioningDelegate = self.transitioningDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

@end
