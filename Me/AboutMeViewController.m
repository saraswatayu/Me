//
//  AboutMeViewController.m
//  Me
//
//  Created by Ayush Saraswat on 12/29/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "AboutMeViewController.h"
#import "NextAnimation.h"
#import "ImageAlbumCollectionViewCell.h"
#import "UIViewController+Backing.h"
#import "UIView+Pulse.h"

@interface AboutMeViewController ()

@property (nonatomic, strong) NSArray *components;

@end

@implementation AboutMeViewController
@synthesize components;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    components = @[@{
                       @"images": @[[UIImage imageNamed:@"LRCentral"]],
                       @"title": @"High School - 2010",
                       @"description": @"The transition to high school was when I discovered a new interest in software development. It was also around this time that I realized I needed a way to get away from it all, which I found in swimming."},
                   @{
                       @"images": @[[UIImage imageNamed:@"USC"]],
                       @"title": @"USC - 2014",
                       @"description": @"By 2014, I had become far more passionate about software development than I had ever expected, but I still wasn't sure if that's all I wanted to study. So I packed my bags and left home to study Computer Science and Business Administration at USC."},
                   @{
                       @"images": @[[UIImage imageNamed:@"Triathlon"]],
                       @"title": @"Discovering New Hobbies",
                       @"description": @"I'm always pushing my limits and now that my swimming career was over, I decided to turn to something just a little bit harder. Now I'm a part of USC's triathlon team, where I train for ultra-endurance running and triathlon events."},
                   @{
                       @"images": @[[UIImage imageNamed:@"Udacity Logo"]],
                       @"title": @"Learning and Teaching",
                       @"description": @"I now work at Udacity, where every day I get to learn more about iOS development and teach others who are just diving into it."
                    }];
    
    [self.previousButton startPulsing];
    [self.nextButton startPulsing];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [components count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageAlbumCell" forIndexPath:indexPath];
    
    NSDictionary *componentDetails = [components objectAtIndex:indexPath.section];
    [cell configureForImages:[componentDetails objectForKey:@"images"] withTitle:[componentDetails objectForKey:@"title"] andDescription:[componentDetails objectForKey:@"description"]];

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (ImageAlbumCollectionViewCell *cell in self.collectionView.visibleCells)
    {
        cell.innerTargetView.frame = CGRectMake((self.collectionView.contentOffset.x - cell.frame.origin.x) / 30 + (cell.frame.size.width / 2 - 10), cell.innerTargetView.frame.origin.y, cell.innerTargetView.frame.size.width, cell.innerTargetView.frame.size.height);
    }
}

#pragma mark <UICollectionViewLayoutDelegate>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, self.view.frame.size.width / 2 - 160, 0, self.view.frame.size.width / 2 - 160);
}

@end