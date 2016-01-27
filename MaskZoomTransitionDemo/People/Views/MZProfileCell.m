//
//  MZProfileCell.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfileCell.h"

@implementation MZProfileCell

#pragma mark - Initializers

- (void)tintColorDidChange
{
    self.titleLabel.textColor = self.tintColor;
    [super tintColorDidChange];
}

@end
