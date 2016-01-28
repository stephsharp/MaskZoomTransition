//
//  MZProfilesController.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 21/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZProfile.h"

@interface MZProfilesController : NSObject

@property (nonatomic, readonly) NSArray *profiles; /* of MZProfile */
@property (nonatomic, readonly) MZProfile *authenticatedUser;

- (void)deleteProfile:(MZProfile *)profile;

@end
