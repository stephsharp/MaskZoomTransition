//
//  MZProfile.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfile.h"
#import "NSString+MZProfile.h"

static NSUInteger const MZThumbnailImageSize = 144;
static NSUInteger const MZProfileImageSize = 450;

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
    return [NSString stringWithFormat:@"%@%@", [self.person.firstName uppercaseInitial], [self.person.lastName uppercaseInitial]];
}

- (UIImage *)thumbnailImage
{
    UIImage *image = [UIImage imageNamed:self.person.thumbnailImageName];
    return image ?: [self.initials placeholderImageFromStringWithSize:MZThumbnailImageSize];
}

- (UIImage *)profileImage
{
    UIImage *image = [UIImage imageNamed:self.person.profileImageName];
    return image ?: [self.initials placeholderImageFromStringWithSize:MZProfileImageSize];
}

@end
