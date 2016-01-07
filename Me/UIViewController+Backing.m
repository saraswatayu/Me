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

// assigns the proper transition to view transitions

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if ([presented isKindOfClass:[UINavigationController class]])
        return NULL;
    return [[NextAnimation alloc] initWithDirection:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([dismissed isKindOfClass:[UINavigationController class]])
        return NULL;
    return [[NextAnimation alloc] initWithDirection:NO];
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
