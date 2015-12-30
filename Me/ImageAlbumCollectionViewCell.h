//
//  ImageAlbumCollectionViewCell.h
//  Me
//
//  Created by Ayush Saraswat on 12/29/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageAlbumCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *targetView;
@property (nonatomic, weak) IBOutlet UIView *innerTargetView;

@property (nonatomic, weak) IBOutlet UIImageView *albumImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

- (void)configureForImages:(NSArray *)images withTitle:(NSString *)title andDescription:(NSString *)description;

@end
