//
//  MZPeopleTableViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZPeopleTableViewController.h"
#import "MZProfilesController.h"
#import "MZPersonCell.h"
#import "UIViewController+MZContentViewController.h"
#import "MZProfileViewController.h"

@interface MZPeopleTableViewController () <UITableViewDataSource, UITableViewDelegate, MZProfileViewControllerDelegate>

@property (nonatomic) MZProfilesController *profilesController;
@property (nonatomic) MZMaskZoomTransitioningDelegate * transitioningDelegate;

@end

@implementation MZPeopleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.profilesController = [MZProfilesController new];
    self.transitioningDelegate = [MZMaskZoomTransitioningDelegate new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    UITextView *textView;
    textView.textContainerInset = UIEdgeInsetsMake(0, 50, 0, 0);

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.profilesController.profiles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    MZProfile *profile = self.profilesController.profiles[indexPath.row];

    cell.nameLabel.text = profile.displayName;
    cell.roleLabel.text = profile.person.role;
    cell.avatarImageView.image = profile.thumbnailImage;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *contentViewController = segue.destinationViewController.mz_contentViewController;

    if ([[segue identifier] isEqualToString:@"ProfileSegue"]) {
        MZProfileViewController *profileVC = (MZProfileViewController *)contentViewController;
        profileVC.delegate = self;

        if ([sender isKindOfClass:[MZPersonCell class]]) {
            MZPersonCell *cell = (MZPersonCell *)sender;
            self.transitioningDelegate.smallView = cell.avatarImageView;

            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            profileVC.profile = self.profilesController.profiles[indexPath.row];
        }

        segue.destinationViewController.transitioningDelegate = self.transitioningDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

#pragma mark - Actions

- (IBAction)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MZProfileViewControllerDelegate

- (void)MZProfileViewControllerShouldDismiss:(MZProfileViewController *)profileViewController
{
//    if (/* person was deleted */) {
//        self.transitioningDelegate.dismissToZeroSize = YES;
//    }

    [self dismissViewControllerAnimated:YES completion:^{
        // Set dismissToZeroSize back to NO after transition completes.
        self.transitioningDelegate.dismissToZeroSize = NO;
    }];
}

@end
