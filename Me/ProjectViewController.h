//
//  ProjectViewController.h
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet UIButton *previousButton;

@end
