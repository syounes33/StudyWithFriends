//
//  ResultsViewController.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/21/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "ResultsViewController.h"
#import "Game.h"

@interface ResultsViewController () 


@end



@implementation ResultsViewController

#define QUESTION_HEIGHT 220.0

@synthesize gameCompletedDisplay;
@synthesize gamePlayed;
@synthesize userAnswers;
@synthesize questionsDisplay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    NSString *gameOver = [NSString stringWithFormat:@"You completed the %@ quiz! You got %i/%i correct!", self.gamePlayed.title, [self.gamePlayed getAmountCorrect: self.userAnswers], self.gamePlayed.amtQuestions];
    
    self.gameCompletedDisplay.text = gameOver;
    
    [questionsDisplay setScrollEnabled:TRUE];
    [questionsDisplay setContentSize:CGSizeMake(320,QUESTION_HEIGHT*self.gamePlayed.amtQuestions)];
    
    for (int i = 0; i < self.gamePlayed.amtQuestions; i++) {
        UILabel *question;
        question = [[UILabel alloc] initWithFrame: CGRectMake(10, QUESTION_HEIGHT*i, 300, QUESTION_HEIGHT)];
        question.numberOfLines = self.gamePlayed.amtQuestions + 2;
        NSString *questionAssesment = [NSString stringWithFormat: @"You chose %@; the correct answer is %@.",
                                       [userAnswers objectAtIndex: i],
                                       [self.gamePlayed.answerKey objectAtIndex: i]];
        question.text = [NSString stringWithFormat:@"%@ \n (A) %@ \n (B) %@ \n (C) %@ \n (D) %@ \n (E) %@ \n %@",
                          [[self.gamePlayed.questionSet objectAtIndex:i] objectAtIndex: 0],
                          [[self.gamePlayed.questionSet objectAtIndex:i] objectAtIndex: 1],
                          [[self.gamePlayed.questionSet objectAtIndex:i] objectAtIndex: 2],
                          [[self.gamePlayed.questionSet objectAtIndex:i] objectAtIndex: 3],
                          [[self.gamePlayed.questionSet objectAtIndex:i] objectAtIndex: 4],
                          [[self.gamePlayed.questionSet objectAtIndex:i] objectAtIndex: 5],
                          questionAssesment];
        [questionsDisplay addSubview: question];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
