//
//  IntroductionViewController.m
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import "IntroductionViewController.h"

#import "UIButton+Pulse.h"

@interface IntroductionViewController ()

@property (nonatomic, strong) NSArray *rotatingLabels;

@end

@implementation IntroductionViewController
@synthesize rotatingLabels;

- (void)viewDidLoad {
    [super viewDidLoad];

    rotatingLabels = @[@"student.", @"athlete.", @"engineer.", @"tinkerer."];
    
    currentSpinningIndex = 0;
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(updateSpinnerText:) userInfo:nil repeats:YES];
    
    [self.nextButton startPulsing];
}

- (void)updateSpinnerText:(NSTimer *)timer
{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
