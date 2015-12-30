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

@interface AboutMeViewController ()

@property (nonatomic, strong) NSArray *components;

@end

@implementation AboutMeViewController
@synthesize components;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    components = @[@{@"images": @[[UIImage imageNamed:@"LRAR1"], [UIImage imageNamed:@"LRAR2"], [UIImage imageNamed:@"LRAR3"], [UIImage imageNamed:@"LRAR4"]], @"title": @"Little Rock, AR", @"description": @"i lived here."}, @{@"images": @[[UIImage imageNamed:@"LRAR1"], [UIImage imageNamed:@"LRAR2"], [UIImage imageNamed:@"LRAR3"], [UIImage imageNamed:@"LRAR4"]], @"title": @"Little Rock, AR", @"description": @"i lived here."}];
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