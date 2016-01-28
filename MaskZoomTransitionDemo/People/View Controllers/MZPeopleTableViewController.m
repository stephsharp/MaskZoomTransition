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
#import "MZProfileButton.h"

@interface MZPeopleTableViewController () <UITableViewDataSource, UITableViewDelegate, MZProfileViewControllerDelegate>

@property (nonatomic) MZProfilesController *profilesController;
@property (nonatomic) MZMaskZoomTransitioningDelegate * transitioningDelegate;
@property (nonatomic) MZProfileButton *myProfileButton;

@end

@implementation MZPeopleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.profilesController = [MZProfilesController new];
    self.transitioningDelegate = [MZMaskZoomTransitioningDelegate new];

    if (self.profilesController.authenticatedUser) {
        [self addProfileButtonToNavigationBar];
    }
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
    cell.avatarImageView.image = profile.profileImage;
    
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
        else if ([sender isEqual:self.myProfileButton]) {
            self.transitioningDelegate.smallView = self.myProfileButton;
            profileVC.profile = self.profilesController.authenticatedUser;
        }

        segue.destinationViewController.transitioningDelegate = self.transitioningDelegate;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

- (void)addProfileButtonToNavigationBar
{
    self.myProfileButton = [[MZProfileButton alloc] initWithProfile:self.profilesController.authenticatedUser];
    [self.myProfileButton addTarget:self action:@selector(profilePressed:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.myProfileButton];
}

#pragma mark - Actions

- (IBAction)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)profilePressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"ProfileSegue" sender:sender];
}

#pragma mark - MZProfileViewControllerDelegate

- (void)MZProfileViewControllerShouldDelete:(MZProfileViewController *)profileViewController
{
    [self.profilesController deleteProfile:profileViewController.profile];
    [self.tableView reloadData];
    self.transitioningDelegate.dismissToZeroSize = YES;

    [self dismissViewControllerAnimated:YES completion:^{
        // Set dismissToZeroSize back to NO after transition completes.
        self.transitioningDelegate.dismissToZeroSize = NO;
    }];
}

@end
