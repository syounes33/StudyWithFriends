//
//  GameViewController.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/17/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()
    @property (nonatomic, strong) Game *game;
    @property (nonatomic, strong) NSMutableArray *buttonSet;
    @property (nonatomic, strong) NSMutableArray *answers;
@end

@implementation GameViewController

@synthesize game;
@synthesize buttonSet;
@synthesize answers;

@synthesize timeDisplay;
@synthesize questionNumberDisplay;
@synthesize timer;

@synthesize aButton, bButton, cButton, dButton, eButton;
@synthesize aOption, bOption, cOption, dOption, eOption;
@synthesize questionTextDisplay;

int mainInt;
int questionNumber;
BOOL inGame;
BOOL gamePaused;

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ResultsViewController *RVC = [segue destinationViewController];

    RVC.userAnswers = self.answers;
    RVC.gamePlayed = self.game;
}

//lazy instantiation of Game model.
- (Game *)game {
    if(!game) {
        
        //new game
        game = [[Game alloc] init];
        
        //set game length, number of questions
        self.game.gameLength = 180;
        self.game.amtQuestions = 5;
        
        //create question set and answer key
        NSMutableArray *questions, *question1, *question2, *question3, *question4, *question5, *answerSet;
        questions = [[NSMutableArray alloc] init];
        question1 = [[NSMutableArray alloc] init];
        question2 = [[NSMutableArray alloc] init];
        question3 = [[NSMutableArray alloc] init];
        question4 = [[NSMutableArray alloc] init];
        question5 = [[NSMutableArray alloc] init];
        answerSet = [[NSMutableArray alloc] init];
        
        [question1 addObject:@"If x=1 and y=1, what is x+y?"];
        [question1 addObject: @"2"];
        [question1 addObject: @"4"];
        [question1 addObject: @"6"];
        [question1 addObject: @"8"];
        [question1 addObject: @"10"];
        
        [question2 addObject:@"If x=2 and y=2, what is x+y?"];
        [question2 addObject: @"3"];
        [question2 addObject: @"4"];
        [question2 addObject: @"6"];
        [question2 addObject: @"8"];
        [question2 addObject: @"10"];
        
        [question3 addObject:@"If x=3 and y=3, what is x+y?"];
        [question3 addObject: @"4"];
        [question3 addObject: @"4"];
        [question3 addObject: @"6"];
        [question3 addObject: @"8"];
        [question3 addObject: @"10"];
        
        [question4 addObject:@"If x=4 and y=4, what is x+y?"];
        [question4 addObject: @"5"];
        [question4 addObject: @"4"];
        [question4 addObject: @"6"];
        [question4 addObject: @"8"];
        [question4 addObject: @"10"];
        
        [question5 addObject:@"If x=5 and y=5, what is x+y?"];
        [question5 addObject: @"6"];
        [question5 addObject: @"4"];
        [question5 addObject: @"6"];
        [question5 addObject: @"8"];
        [question5 addObject: @"10"];
        
        [questions addObject: question1];
        [questions addObject: question2];
        [questions addObject: question3];
        [questions addObject: question4];
        [questions addObject: question5];
        
        [answerSet addObject: @"A"];
        [answerSet addObject: @"B"];
        [answerSet addObject: @"C"];
        [answerSet addObject: @"D"];
        [answerSet addObject: @"E"];
        
        if([questions count] == self.game.amtQuestions) {
            self.game.questionSet = questions;
        }
        if([answerSet count] == self.game.amtQuestions) {
            self.game.answerKey = answerSet;
        }
        
        self.game.title = @"Arithmetic";

    }
    return game;
}
- (NSMutableArray *)buttonSet
{
    if (!buttonSet)  {
        buttonSet = [[NSMutableArray alloc]init];
        [buttonSet addObject: aButton];
        [buttonSet addObject: bButton];
        [buttonSet addObject: cButton];
        [buttonSet addObject: dButton];
        [buttonSet addObject: eButton];
    }
    return buttonSet;
}
- (NSMutableArray *) answers
{
    if (!answers) {
        answers = [[NSMutableArray alloc] init];
        int i = 1;
        while (i <= self.game.amtQuestions) {
            [answers addObject: @""];
            i = i+1;
        }
    }
    return answers;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)answerPressed:(UIButton *)sender {
    //if user has hit start...
    if(inGame) {
        //gets user's answer
        NSString *answerPicked = sender.currentTitle;
        //adds it to array that stores user's answers
        [self.answers replaceObjectAtIndex:questionNumber-1 withObject:answerPicked];
        //highlights appropriate button
        for(UIButton *button in self.buttonSet) {
            if([button.currentTitle isEqualToString: answerPicked]) {
                [button setBackgroundColor:[UIColor redColor]];
            }
            else {
                [button setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }


}

- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender {
    //if user has hit start...
    if(inGame){
        //user cannot hit back on question 1
        if( questionNumber > 1) {
            //moves back a question
            questionNumber = questionNumber - 1;
            [self changeQuestionsAndAnswers: questionNumber];
            
            //highlights appropriate button
            if(answers) {
                NSString *answerPicked = [answers objectAtIndex: questionNumber-1];
                
                for(UIButton *button in buttonSet) {
                    if([button.currentTitle isEqualToString: answerPicked]) {
                        [button setBackgroundColor:[UIColor redColor]];
                    }
                    else {
                        [button setBackgroundColor:[UIColor whiteColor]];
                    }
                }
            }
        }
    }

}

- (IBAction)swipeNext:(UISwipeGestureRecognizer *)sender {
    //if user has hit start
    if(inGame) {
        //user cannot hit next on final question
        if( questionNumber < self.game.amtQuestions) {
            questionNumber = questionNumber + 1;
            [self changeQuestionsAndAnswers: questionNumber];
            
            //highlight appropriate button
            if(answers) {
                NSString *answerPicked = [answers objectAtIndex:questionNumber-1];
                
                for(UIButton *button in buttonSet) {
                    if([button.currentTitle isEqualToString: answerPicked]) {
                        [button setBackgroundColor:[UIColor redColor]];
                    }
                    else {
                        [button setBackgroundColor:[UIColor whiteColor]];
                    }
                }
            }
        }
    }

}


- (IBAction)startPressed:(UIButton *)sender {
    if(!inGame){
    
        //set boolean for game true
        inGame = TRUE;
    

    
        //display questions and answers
        questionNumber = 1;
        [self changeQuestionsAndAnswers: questionNumber];
    
        mainInt = 0;
        if(!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        }
        
        self.navigationController.navigationBar.topItem.title = self.game.title;
    }
}

- (IBAction)endPressed:(UIButton *)sender {
    //user cannot end game without starting...
    if(inGame){
        mainInt = self.game.gameLength;
    }
    
    
    
}

- (IBAction)pausePressed:(UIButton *)sender {
    if(inGame) {
        if(!gamePaused) {
            [timer invalidate];
            gamePaused = TRUE;
            [sender setBackgroundImage: [UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        }
        else {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            gamePaused = FALSE;
            [sender setBackgroundImage: [UIImage imageNamed:@"pauseButton.jpg"] forState:UIControlStateNormal];
        }
    }
}

- (void) countDown {
    
    int timeLeft = self.game.gameLength - mainInt;
    if(timeLeft < 0) {
        [self endGame];
    }
    else {
        mainInt += 1;
        timeDisplay.text = [NSString stringWithFormat: @"%i", timeLeft];
        if(timeLeft <6) {
            timeDisplay.font= [timeDisplay.font fontWithSize:25.0];
            [timeDisplay setTextColor: [UIColor redColor]];
        }
    }
    
}


-(void) changeQuestionsAndAnswers : (int) questionNumber {
    
    int number = questionNumber -1;
    
    NSString *questionHeader = [NSString stringWithFormat:@"Question %i", questionNumber];
    self.questionNumberDisplay.text = questionHeader;
    
    //display question
    NSString *question = [[self.game.questionSet objectAtIndex:number] objectAtIndex:0];
    self.questionTextDisplay.text = question;
    
    //display answer options
    NSString *aAnswer = [[self.game.questionSet objectAtIndex:number] objectAtIndex:1];
    self.aOption.text = aAnswer;
    
    NSString *bAnswer = [[self.game.questionSet objectAtIndex:number] objectAtIndex:2];
    self.bOption.text = bAnswer;
    
    NSString *cAnswer = [[self.game.questionSet objectAtIndex:number] objectAtIndex:3];
    self.cOption.text = cAnswer;
    
    NSString *dAnswer = [[self.game.questionSet objectAtIndex:number] objectAtIndex:4];
    self.dOption.text = dAnswer;
    
    NSString *eAnswer = [[self.game.questionSet objectAtIndex:number] objectAtIndex:5];
    self.eOption.text = eAnswer;
    
}
-(void) endGame {
    [timer invalidate];
    
    int amountCorrect = [self.game getAmountCorrect:self.answers];
    
    [self performSegueWithIdentifier:@"results" sender:self];
    
    
}

@end
