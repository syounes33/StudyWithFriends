//
//  Game.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/18/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize amtQuestions, gameLength;
@synthesize answerKey, questionSet;
@synthesize title;






-(int) getAmountCorrect: (NSMutableArray*) userAnswers {
    int amountCorrect=0;
    int answerNumber = 0;
    for (NSString *userAnswer in userAnswers) {
        if([[answerKey objectAtIndex: answerNumber] isEqualToString: userAnswer]) {
            amountCorrect ++;
        }
        answerNumber ++;
    }
    return amountCorrect;
}




@end
