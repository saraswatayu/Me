//
//  Project.h
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Project : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *link;

- (instancetype)initWithName:(NSString *)name andIcon:(UIImage *)icon andDescription:(NSString *)description andLink:(NSString *)link;

@end
