//
//  UIViewController+Backing.m
//  Me
//
//  Created by Ayush Saraswat on 12/29/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "UIViewController+Backing.h"
#import "NextAnimation.h"

@implementation UIViewController (Backing)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    segue.destinationViewController.transitioningDelegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[NextAnimation alloc] initWithDirection:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[NextAnimation alloc] initWithDirection:NO];
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
