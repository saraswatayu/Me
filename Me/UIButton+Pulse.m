//
//  UIButton+Pulse.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "UIButton+Pulse.h"

@implementation UIButton (Pulse)

- (void)startPulsing
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    pulseAnimation.duration = 1.0f;
    pulseAnimation.repeatCount = HUGE_VALF;
    pulseAnimation.autoreverses = YES;
    pulseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    pulseAnimation.toValue = [NSNumber numberWithFloat:0.4f];
    [self.layer addAnimation:pulseAnimation forKey:@"animateOpacity"];
}

@end
