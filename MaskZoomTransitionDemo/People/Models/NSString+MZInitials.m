//
//  NSString+MZInitials.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 20/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "NSString+MZInitials.h"

@implementation NSString (MZInitials)

- (NSString *)uppercaseInitial
{
    if (self.length > 0) {
        return [[self substringToIndex:1] uppercaseString];
    }

    return @"";
}

@end
