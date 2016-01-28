//
//  MZProfilesController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 21/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfilesController.h"
#import "MZPersonStore.h"

@interface MZProfilesController ()

@property (nonatomic, readwrite) MZProfile *authenticatedUser;

@end

@implementation MZProfilesController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _profiles = [self createProfiles];
    }
    return self;
}

- (NSArray *)createProfiles
{
    MZPersonStore *store = [MZPersonStore new];
    NSMutableArray *profiles = [NSMutableArray array];

    for (MZPerson *person in store.people) {
        MZProfile *profile = [[MZProfile alloc] initWithPerson:person];

        if (person.isAuthenticated && !self.authenticatedUser) {
            self.authenticatedUser = profile;
        }
        else {
            [profiles addObject:profile];
        }
    }
    return [profiles copy];
}

@end
