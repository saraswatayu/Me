//
//  NextAnimation.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "NextAnimation.h"

@interface NextAnimation()

@property (nonatomic) BOOL direction;

@end

@implementation NextAnimation
@synthesize direction;

#define duration 1.0f

- (instancetype)initWithDirection:(BOOL)forward
{
    self = [super init];
    if (self) {
        self.direction = forward;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    fromView.frame = containerView.frame;
    fromView.alpha = 1.0f;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = CGRectMake(containerView.frame.origin.x, direction ? containerView.frame.size.height - 58 : -containerView.frame.size.height + 58, containerView.frame.size.width, containerView.frame.size.height);
    toView.alpha = 1.0f;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    UIView *arrowToRotate = direction ? [fromView viewWithTag:10] : [fromView viewWithTag:5];

    [UIView animateWithDuration:duration / 4.0f animations:^{
        arrowToRotate.transform = CGAffineTransformMakeRotation(direction ? M_PI : -M_PI);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:3 * duration / 4.0f animations:^{
            [fromView setFrame:CGRectMake(0, direction ? -containerView.frame.size.height + 58 : containerView.frame.size.height - 58, fromView.frame.size.width, fromView.frame.size.height)];
            [toView setFrame:containerView.frame];
        } completion:^(BOOL finished){
            arrowToRotate.transform = CGAffineTransformMakeRotation(0);
            fromView.alpha = 0.0f;
            [fromView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end
