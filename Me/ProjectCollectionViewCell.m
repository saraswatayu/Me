//
//  ProjectCollectionViewCell.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "ProjectCollectionViewCell.h"

@implementation ProjectCollectionViewCell
@synthesize iconImageView, nameLabel, descriptionLabel, linkButton;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shouldRasterize = NO;
}

- (void)configureForProject:(Project *)project
{   
    iconImageView.image = project.icon;
    nameLabel.text = project.name;
    descriptionLabel.text = project.details;
    
    if (project.link == NULL)
        [linkButton setTitle:@"TRY A DEMO" forState:UIControlStateNormal];
    else
        [linkButton setTitle:@"CHECK IT OUT" forState:UIControlStateNormal];
}

@end
