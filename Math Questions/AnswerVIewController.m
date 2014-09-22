//
//  AnswerViewController.m
//  Math Questions
//
//  Created by Dan Dodson on 9/7/14.
//  Copyright (c) 2014 Six Sigma. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController () {
    UIAlertView *alert;
    NSDate *start;
}
@property (weak, nonatomic) IBOutlet UITextField *answerBox;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation AnswerViewController

-(void)manualSegue {
    [self performSegueWithIdentifier:@"returnToQuestion" sender:self];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.answerBox becomeFirstResponder];
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(manualSegue) userInfo:nil repeats:NO];
    start = [NSDate date];
    alert = [[UIAlertView alloc] initWithTitle:@"Answer blank" message:@"Please enter an answer." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QuestionViewController *dest = (QuestionViewController *) segue.destinationViewController;
    NSDate *end = [NSDate date];
    NSTimeInterval diff = [end timeIntervalSinceDate:start];
    
    dest.answer = _answerBox.text;
    dest.time = [NSString stringWithFormat:@"%f", diff];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (sender == _doneButton && [_answerBox.text isEqualToString:@""]) {
        [alert show];
        return NO;
    }
    return YES;
}
@end
