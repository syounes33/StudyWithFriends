//
//  ResultsViewController.h
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/21/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@class Game;
@interface ResultsViewController : UIViewController {
    Game *gamePlayed;
    NSMutableArray *userAnswers;
    IBOutlet UIScrollView *questionsDisplay;

}

@property (weak, nonatomic) IBOutlet UILabel *gameCompletedDisplay;
@property (strong, nonatomic) IBOutlet UIScrollView *questionsDisplay;
@property (nonatomic, strong) NSMutableArray *userAnswers;
@property (nonatomic, strong) Game *gamePlayed;


@end
