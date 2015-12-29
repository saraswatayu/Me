//
//  IntroductionView.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "IntroductionView.h"

@implementation IntroductionView
@synthesize nameLabel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSAttributedString *firstName = [[NSAttributedString alloc] initWithString:@"Ayush" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:24.0f weight:UIFontWeightHeavy]}];
    NSAttributedString *lastName = [[NSAttributedString alloc] initWithString:@"\nSaraswat" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium]}];
    
    NSMutableAttributedString *nameText = [firstName mutableCopy];
    [nameText appendAttributedString:lastName];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.attributedText = nameText;
    nameLabel.numberOfLines = 2;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel sizeToFit];
    
    [self addSubview:nameLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    nameLabel.center = self.center;
}

@end
