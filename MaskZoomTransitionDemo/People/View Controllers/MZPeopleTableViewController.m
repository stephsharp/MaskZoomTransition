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

@interface MZPeopleTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) MZProfilesController *profilesController;

@end

@implementation MZPeopleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profilesController = [MZProfilesController new];
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
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
