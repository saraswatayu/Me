//
//  NextAnimation.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "NextAnimation.h"

@implementation NextAnimation
{
    BOOL presenting;
}

#define duration 2.0f

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromArrowView = [[transitionContext viewForKey:UITransitionContextFromViewKey] viewWithTag:10];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [toView setFrame:CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height)];
    toView.alpha = 0.0f;
    
    [containerView addSubview:fromArrowView];
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:duration / 4.0f animations:^{
        [containerView viewWithTag:10].transform = CGAffineTransformMakeRotation(M_PI);
      
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.5f * duration / 2.0f animations:^{
            toView.frame = containerView.frame;
            toView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end
