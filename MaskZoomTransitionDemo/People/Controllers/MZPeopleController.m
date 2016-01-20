//
//  MZPeopleController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZPeopleController.h"
#import "MZPerson.h"

@implementation MZPeopleController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _people = [self peopleFromPlist];
    }
    return self;
}
- (NSArray *)peopleFromPlist
{
    NSMutableArray *people = [NSMutableArray array];

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MZPeople" ofType:@"plist"];
    NSArray *peopleData = [NSArray arrayWithContentsOfFile:plistPath];

    for (NSDictionary *p in peopleData) {
        [people addObject:[[MZPerson alloc] initWithFirstName:p[@"firstName"]
                                                     lastName:p[@"lastName"]
                                                         role:p[@"role"]
                                                     location:p[@"location"]
                                                   department:p[@"department"]
                                                        email:p[@"email"]
                                                       mobile:p[@"mobile"]
                                                        phone:p[@"phone"]]];
    }

    return [people copy];
}

@end
