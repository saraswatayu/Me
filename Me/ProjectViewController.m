//
//  ProjectViewController.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectCollectionViewCell.h"
#import "Project.h"

@interface ProjectViewController ()

@property (nonatomic, strong) NSArray<Project *> *projects;

@end

@implementation ProjectViewController
@synthesize projects;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        Project *kaBadges = [[Project alloc] initWithName:@"KA Badges" andIcon:[UIImage imageNamed:@"KA Badges"] andDescription:@"A practice exercise to learn more about RESTful APIs and Core Data concurrency." andLink:NULL];
        Project *udacity = [[Project alloc] initWithName:@"Udacity" andIcon:[UIImage imageNamed:@"Udacity"] andDescription:@"A mobile version of Udacity's learning platform." andLink:@"itms://itunes.apple.com/us/app/udacity-learn-programming/id819700933?mt=8"];
        Project *fsr2015 = [[Project alloc] initWithName:@"FSR 2015" andIcon:[UIImage imageNamed:@"FSR 2015"] andDescription:@"An app to allow conference attendees to stay up to date with things around them." andLink:@"itms://itunes.apple.com/us/app/fsr-2015/id1033664993?mt=8"];
        Project *hortPlants = [[Project alloc] initWithName:@"Hort Plants" andIcon:[UIImage imageNamed:@"Hort Plants"] andDescription:@"Winner of the 2016 ASABE Blue Ribbon Award for Best Mobile Agricultural Solution. Allows horticulture specialists to view pertinent information about the horticulture around them." andLink:@"itms://itunes.apple.com/us/app/hort-plants/id682206135?mt=8"];
        
        projects = @[kaBadges, udacity, fsr2015, hortPlants];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [projects count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    
    [cell configureForProject:[projects objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Project *selectedProject = [projects objectAtIndex:indexPath.row];
    if (selectedProject.link == NULL)
    {
        
    }
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectedProject.link]];
}
@end
