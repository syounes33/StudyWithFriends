//
//  Game.h
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/18/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

@interface Game : NSObject {

    NSMutableArray *questionSet;
    NSMutableArray *answerKey;
    NSString *title;
    
    int gameLength;
    int amtQuestions;

}
@property NSString *title;

@property int gameLength, amtQuestions;

@property NSMutableArray *questionSet;
@property NSMutableArray *answerKey;

-(int) getAmountCorrect: (NSMutableArray*) userAnswers;




@end
