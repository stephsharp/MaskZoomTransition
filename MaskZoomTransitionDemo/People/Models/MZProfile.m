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
    return [NSString stringWithFormat:@"%@%@", [self.person.firstName mz_uppercaseInitial], [self.person.lastName mz_uppercaseInitial]];
}

- (UIImage *)thumbnailImage
{
    UIImage *image;

    if (self.person.thumbnailImageName.length > 0) {
        image = [UIImage imageNamed:self.person.thumbnailImageName];
    }

    return image ?: [self.initials mz_placeholderImageFromStringWithSize:MZThumbnailImageSize];
}

- (UIImage *)profileImage
{
    UIImage *image;

    if (self.person.profileImageName.length > 0) {
        image = [UIImage imageNamed:self.person.profileImageName];
    }

    return image ?: [self.initials mz_placeholderImageFromStringWithSize:MZProfileImageSize];
}

@end
