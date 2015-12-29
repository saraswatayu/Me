//
//  MainViewController.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "MainViewController.h"

#import "IntroductionView.h"
#import "ProjectCollectionViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rightHalf = CGRectMake(self.view.frame.size.width * .3, 0, self.view.frame.size.width * .7, self.view.frame.size.height);
    
    IntroductionView *introductionView = [[IntroductionView alloc] init];
    introductionView.frame = rightHalf;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(176, 355);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ProjectCollectionViewController *projectsController = [[ProjectCollectionViewController alloc] initWithCollectionViewLayout:layout];
    UICollectionView *projectsCollection = projectsController.collectionView;
    projectsCollection.frame = CGRectMake(rightHalf.origin.x, self.view.frame.size.height, rightHalf.size.width, rightHalf.size.height);
    
    [scrollView addSubview:introductionView];
    [scrollView addSubview:projectsCollection];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
