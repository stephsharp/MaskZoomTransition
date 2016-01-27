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
#import "UIViewController+MZContentViewController.h"

@interface MZFirstViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *circleButtons;
@property (nonatomic) MZMaskZoomTransitioningDelegate *transitioningDelegate;

@end

@implementation MZFirstViewController

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
//    UIViewController *contentViewController = segue.destinationViewController.mz_contentViewController;

    if ([[segue identifier] isEqualToString:@"MaskZoomSegue"]) {
        MZSecondViewController *secondVC = (MZSecondViewController *)segue.destinationViewController.mz_contentViewController;
        UIButton *button = (UIButton *)sender;

        secondVC.circleColor = button.backgroundColor;
        self.transitioningDelegate.smallView = button;

        segue.destinationViewController.transitioningDelegate = self.transitioningDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

@end
