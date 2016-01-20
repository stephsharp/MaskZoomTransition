//
//  MZPerson.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZPerson : NSObject

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *role;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *department;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *mobile;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *thumbnailImage;
@property (nonatomic) NSString *profileImage;

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *initials;

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                             role:(NSString *)role
                         location:(NSString *)location
                       department:(NSString *)department
                            email:(NSString *)email
                           mobile:(NSString *)mobile
                            phone:(NSString *)phone;

@end
