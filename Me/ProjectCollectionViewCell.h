//
//  ProjectCollectionViewCell.h
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIButton *linkButton;

- (void)configureForProject:(Project *)project;

@end
