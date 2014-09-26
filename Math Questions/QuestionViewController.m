//
//  QuestionViewController.m
//  Math Questions
//
//  Created by Dan Dodson on 9/9/14.
//  Copyright (c) 2014 Six Sigma. All rights reserved.
//

#import "QuestionViewController.h"


@interface QuestionViewController () {
    NSMutableArray *questions;
    NSEnumerator *questionList;
    Question *currentQuestion;
    NSOperationQueue *answerQueue;
}
@property (weak, nonatomic) IBOutlet UIWebView *equationBox;
@end

@implementation QuestionViewController
    

-(void)loadQuestion {
    if ((currentQuestion = questionList.nextObject)) {
        [_equationBox loadHTMLString:currentQuestion.question baseURL:nil];
    } else {
        [self performSegueWithIdentifier:@"restart" sender:self];
    }
}

- (void)waitToLoadAnswer {
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(loadAnswer) userInfo:nil repeats:NO];
}

- (void)loadAnswer {
    [self performSegueWithIdentifier:@"showAnswerBox" sender:self];
}

- (IBAction)getAnswer:(UIStoryboardSegue *)sender {
    BOOL correctAnswer;
    NSInteger defaultUser = 1;
    
    if ([currentQuestion checkStringAnswer:_answer] ) {
        correctAnswer = YES;
    } else  {
        correctAnswer = NO;
    }
    
    [self recordAnswer:_answer forUser:&defaultUser isCorrect:correctAnswer time:_time];
    [self loadQuestion];
    [self waitToLoadAnswer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    answerQueue = [[NSOperationQueue alloc] init];
    
    NSArray *data = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"equations" ofType:@"plist"]];
    questions = [[NSMutableArray alloc] init];
    for (NSArray *line in data) {
        if (line.count == 2) {
            Question *q = [[Question alloc] initQuestion:[line objectAtIndex:0] answer:[line objectAtIndex:1]];
            [questions addObject:q];
        }
    }
    
    questionList = questions.objectEnumerator;
    
    
    
    [self loadQuestion];
    [self waitToLoadAnswer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recordAnswer:(NSString *)answer forUser:(NSInteger *)user isCorrect:(BOOL)correct time:(NSString *)time {
    NSString *post = [NSString stringWithFormat: @"user=%ld&answer=%@&correct=%d&time=%@", (long)*user, answer, correct, time];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    NSURL *url = [NSURL URLWithString:@"http://six-sigma.dandodson.com/api/v1/answers"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:answerQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        long statusCode = 0;
        if ([response isKindOfClass: [NSHTTPURLResponse class]])
            statusCode = [(NSHTTPURLResponse*) response statusCode];
        if (connectionError) {
            NSLog(@"Error:%@", connectionError.localizedDescription);
        } else if (statusCode != 201) {
            NSLog(@"Error creating resource");
        }
    }];

}

@end
