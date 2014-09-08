//
//  ViewController.m
//  Math Questions
//
//  Created by Dan Dodson on 9/7/14.
//  Copyright (c) 2014 Six Sigma. All rights reserved.
//

#import "BeginViewController.h"
#import "QuestionViewController.h"

@interface BeginViewController ()

@end

@implementation BeginViewController

NSArray *questions;
NSEnumerator *questionHandler;
NSNumber *answer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    questions = [NSArray arrayWithObjects: @"Test1", @"Test2", @"Test3", nil];
    answer = [NSNumber numberWithDouble: 27];
    questionHandler = questions.objectEnumerator;
    // add error handling if data isnt found
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"beginQuestions"]) {
        QuestionViewController *controller = (QuestionViewController *) segue.destinationViewController;
        controller.questions = questionHandler;
        controller.answer = answer;
    }
    
}
@end
