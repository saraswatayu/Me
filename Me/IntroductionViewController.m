//
//  IntroductionViewController.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "IntroductionViewController.h"

#import "UIViewController+Backing.h"
#import "UIView+Pulse.h"
#import "NextAnimation.h"

@interface IntroductionViewController ()

@property (nonatomic, strong) NSArray *rotatingLabels;

@end

@implementation IntroductionViewController
@synthesize rotatingLabels;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        rotatingLabels = @[@"student", @"athlete", @"developer", @"photographer", @"wannabe designer", @"and so much more..."];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    currentSpinningIndex = 0;
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(updateSpinnerText:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // start pulsing button
    [self.nextButton startPulsing];
}

- (void)updateSpinnerText:(NSTimer *)timer
{
    // rotate text through a fade
    CATransition *rotationAnimation = [CATransition animation];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.type = kCATransitionFade;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.rotatingAboutLabel.layer addAnimation:rotationAnimation forKey:@"kCATransitionFade"];
    
    [self.rotatingAboutLabel setText:[rotatingLabels objectAtIndex:currentSpinningIndex]];
    currentSpinningIndex++;
    if (currentSpinningIndex == [rotatingLabels count])
        currentSpinningIndex = 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    segue.destinationViewController.transitioningDelegate = self;
}

@end
