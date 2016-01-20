//
//  MZProfilesController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 21/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfilesController.h"
#import "MZPersonStore.h"

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
        [profiles addObject:[[MZProfile alloc] initWithPerson:person]];
    }
    return [profiles copy];
}

@end
