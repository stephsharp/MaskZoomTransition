//
//  MZPerson.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZPerson.h"
#import "NSString+MZInitials.h"

@interface MZPerson ()

@property (nonatomic) NSString *firstInitial;
@property (nonatomic) NSString *lastInitial;

@end

@implementation MZPerson

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                             role:(NSString *)role
                         location:(NSString *)location
                       department:(NSString *)department
                            email:(NSString *)email
                           mobile:(NSString *)mobile
                            phone:(NSString *)phone
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
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFirstName:nil lastName:nil role:nil location:nil department:nil email:nil mobile:nil phone:nil];
}

- (NSString *)displayName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSString *)initials
{
    return [NSString stringWithFormat:@"%@%@", [self.firstName uppercaseInitial], [self.lastName uppercaseInitial]];
}

@end
