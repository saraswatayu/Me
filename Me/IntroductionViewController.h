//
//  IntroductionViewController.h
//  Me
//
//  Created by Ayush Saraswat on 12/28/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController <UIViewControllerTransitioningDelegate>
{
    int currentSpinningIndex;
}

@property (nonatomic, weak) IBOutlet UILabel *rotatingAboutLabel;

@property (nonatomic, weak) IBOutlet UIButton *nextButton;

@end
