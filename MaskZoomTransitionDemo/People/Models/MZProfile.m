//
//  MZProfile.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfile.h"
#import "NSString+MZProfile.h"
#import "MZProfileCell.h"

static NSString *const MZMobileTitle = @"mobile";
static NSString *const MZPhoneTitle = @"work";
static NSString *const MZEmailTitle = @"email";
static NSString *const MZDepartmentTitle = @"department";

static NSUInteger const MZThumbnailImageSize = 144;
static NSUInteger const MZProfileImageSize = 450;

@interface MZProfile ()

@property (nonatomic) NSArray *tableData;

@end

@implementation MZProfile

- (instancetype)initWithPerson:(MZPerson *)person
{
    self = [super init];
    if (self) {
        _person = person;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithPerson:nil];
}

- (NSString *)displayName
{
    return [NSString stringWithFormat:@"%@ %@", self.person.firstName, self.person.lastName];
}

- (NSString *)initials
{
    return [NSString stringWithFormat:@"%@%@", [self.person.firstName mz_uppercaseInitial], [self.person.lastName mz_uppercaseInitial]];
}

- (UIImage *)thumbnailImage
{
    UIImage *image;

    if (self.person.thumbnailImageName.length > 0) {
        image = [UIImage imageNamed:self.person.thumbnailImageName];
    }

    return image ?: [self.initials mz_placeholderImageFromStringWithSize:MZThumbnailImageSize];
}

- (UIImage *)profileImage
{
    UIImage *image;

    if (self.person.profileImageName.length > 0) {
        image = [UIImage imageNamed:self.person.profileImageName];
    }

    return image ?: [self.initials mz_placeholderImageFromStringWithSize:MZProfileImageSize];
}

- (NSArray *)tableData
{
    if (!_tableData) {
        NSMutableArray *mutableTableData = [NSMutableArray new];

        if (self.person.mobile.length > 0) {
            [mutableTableData addObject:@{ @"title" : MZMobileTitle, @"content" : self.person.mobile }];
        }

        if (self.person.phone.length > 0) {
            [mutableTableData addObject:@{ @"title" : MZPhoneTitle, @"content" : self.person.phone }];
        }

        if (self.person.email.length > 0) {
            [mutableTableData addObject:@{ @"title" : MZEmailTitle, @"content" : self.person.email }];
        }

        if (self.person.department.length > 0) {
            [mutableTableData addObject:@{ @"title" : MZDepartmentTitle, @"content" : self.person.department }];
        }
        
        _tableData = [mutableTableData copy];
    }
    return _tableData;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];

    NSUInteger index = (NSUInteger)indexPath.row;
    cell.titleLabel.text = self.tableData[index][@"title"];
    cell.contentLabel.text = self.tableData[index][@"content"];

    return cell;
}

@end
