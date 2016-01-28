//
//  MZPerson.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZPerson.h"

@implementation MZPerson

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                             role:(NSString *)role
                         location:(NSString *)location
                       department:(NSString *)department
                            email:(NSString *)email
                           mobile:(NSString *)mobile
                            phone:(NSString *)phone
                 profileImageName:(NSString *)profileImageName
                    authenticated:(BOOL)authenticated
{
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _role = role;
        _location = location;
        _department = department;
        _email = email;
        _mobile = mobile;
        _phone = phone;
        _profileImageName = profileImageName;
        _authenticated = authenticated;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFirstName:nil lastName:nil role:nil location:nil department:nil email:nil mobile:nil phone:nil profileImageName:nil authenticated:NO];
}

@end
