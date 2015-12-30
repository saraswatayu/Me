//
//  ImageAlbumCollectionViewCell.m
//  Me
//
//  Created by Ayush Saraswat on 12/29/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "ImageAlbumCollectionViewCell.h"

@implementation ImageAlbumCollectionViewCell
@synthesize targetView, innerTargetView, albumImageView, titleLabel, descriptionLabel;

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
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shouldRasterize = NO;
}

- (void)configureForImages:(NSArray *)images withTitle:(NSString *)title andDescription:(NSString *)description
{
    self.targetView.layer.cornerRadius = 20.0f;
    self.targetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.targetView.layer.borderWidth = 2.0f;
    
    self.innerTargetView.layer.cornerRadius = 10.0f;
    
    [self.albumImageView stopAnimating];
    
    self.albumImageView.animationImages = images;
    self.albumImageView.animationRepeatCount = 0;
    self.albumImageView.animationDuration = [images count] * 2.0f;
    [self.albumImageView startAnimating];
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;
}

@end
