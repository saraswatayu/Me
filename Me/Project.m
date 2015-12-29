//
//  Project.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "Project.h"

@implementation Project

- (instancetype)initWithName:(NSString *)name andIcon:(UIImage *)icon andDescription:(NSString *)description andLink:(NSString *)link
{
    self = [super init];
    if (self) {
        self.icon = icon;
        self.name = name;
        self.details = description;
        self.link = link;
    }
    
    return self;
}

@end