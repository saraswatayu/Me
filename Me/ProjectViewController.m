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
#import "NextAnimation.h"
#import "UIViewController+Backing.h"
#import "UIView+Pulse.h"

@interface ProjectViewController ()

@property (nonatomic, strong) NSArray<Project *> *projects;

@end

@implementation ProjectViewController
@synthesize projects;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        Project *kaBadges = [[Project alloc] initWithName:@"KA Badges" andIcon:[UIImage imageNamed:@"KA Badges"] andDescription:@"a short exercise to combine the worlds of networking and Core Data concurrency" andLink:NULL];
        Project *virtualTourist = [[Project alloc] initWithName:@"Virtual Tourist" andIcon:[UIImage imageNamed:@"Virtual Tourist"] andDescription:@"a short exercise using NSURLSession, MapKit, and Core Data" andLink:NULL];
        Project *udacity = [[Project alloc] initWithName:@"Udacity" andIcon:[UIImage imageNamed:@"Udacity"] andDescription:@"an effort to completely rethink Udacity's mobile offerings - keep checking back to our website for updates" andLink:@"itms://itunes.apple.com/us/app/udacity-learn-programming/id819700933?mt=8"];
        Project *fsr2015 = [[Project alloc] initWithName:@"FSR 2015" andIcon:[UIImage imageNamed:@"FSR 2015"] andDescription:@"an app for OSU's FSR conference that connects thousands of conference attendees with event details, notifications, and so much more" andLink:@"itms://itunes.apple.com/us/app/fsr-2015/id1033664993?mt=8"];
        Project *hortPlants = [[Project alloc] initWithName:@"Hort Plants" andIcon:[UIImage imageNamed:@"Hort Plants"] andDescription:@"an award-winning mobile guide to hundreds of popular plants found in the Southern region of the US. it's got filters, great pictures, and cool tips to get you on your way." andLink:@"itms://itunes.apple.com/us/app/hort-plants/id682206135?mt=8"];
        
        projects = @[kaBadges, virtualTourist, udacity, fsr2015, hortPlants];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.previousButton startPulsing];
    [self.nextButton startPulsing];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [projects count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCell" forIndexPath:indexPath];
    
    [cell configureForProject:[projects objectAtIndex:indexPath.section]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Project *selectedProject = [projects objectAtIndex:indexPath.section];
    if (selectedProject.link == NULL)
    {
        [self performSegueWithIdentifier:selectedProject.name sender:self];
    }
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectedProject.link]];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, self.view.frame.size.width / 2 - 88, 0, self.view.frame.size.width / 2 - 88);
}

#


@end
