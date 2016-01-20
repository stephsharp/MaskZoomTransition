//
//  MZProfile.h
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZPerson.h"

@interface MZProfile : NSObject

@property (nonatomic, readonly) MZPerson *person;

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *initials;
@property (nonatomic, readonly) UIImage *thumbnailImage;
@property (nonatomic, readonly) UIImage *profileImage;

- (instancetype)initWithPerson:(MZPerson *)person;

@end
