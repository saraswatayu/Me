//
//  AboutMeViewController.h
//  Me
//
//  Created by Ayush Saraswat on 12/29/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
