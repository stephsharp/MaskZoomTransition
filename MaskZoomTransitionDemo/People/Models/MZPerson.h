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
@property (nonatomic) NSString *thumbnailImageName;
@property (nonatomic) NSString *profileImageName;
@property (nonatomic, getter=isAuthenticated) BOOL authenticated;

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                             role:(NSString *)role
                         location:(NSString *)location
                       department:(NSString *)department
                            email:(NSString *)email
                           mobile:(NSString *)mobile
                            phone:(NSString *)phone
               thumbnailImageName:(NSString *)thumbnailImageName
                 profileImageName:(NSString *)profileImageName
                    authenticated:(BOOL)authenticated NS_DESIGNATED_INITIALIZER;

@end
