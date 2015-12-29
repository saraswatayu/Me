//
//  ProjectCollectionViewController.h
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSArray<Project *> *projects;

@end
