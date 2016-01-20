//
//  MZPeopleTableViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZPeopleTableViewController.h"
#import "MZPeopleController.h"
#import "MZPerson.h"
#import "MZPersonCell.h"

@interface MZPeopleTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) MZPeopleController *peopleController;

@end

@implementation MZPeopleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.peopleController = [MZPeopleController new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peopleController.people.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    MZPerson *person = self.peopleController.people[indexPath.row];

    cell.nameLabel.text = person.displayName;
    cell.roleLabel.text = person.role;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
