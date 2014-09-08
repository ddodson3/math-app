//
//  QuestionViewController.m
//  Math Questions
//
//  Created by Dan Dodson on 9/7/14.
//  Copyright (c) 2014 Six Sigma. All rights reserved.
//

#import "QuestionViewController.h"
#import "BeginViewController.h"

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *answerBox;
@property (weak, nonatomic) IBOutlet UITextView *questionBox;
@end

@implementation QuestionViewController

- (void)nextQuestion {
    if(!(self.questionBox.text = self.questions.nextObject)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Test completed." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        BeginViewController *bgn = [[BeginViewController alloc] init];
        [self presentViewController:bgn animated:YES completion:nil];
    }
    self.answerBox.text = @"";
}

- (IBAction)submitAnswer:(id)sender {
    NSNumber *ans;
    if ([self.answerBox.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Answer blank" message:@"Please enter an answer." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    ans = [formatter numberFromString:self.answerBox.text];
    if ([ans doubleValue] == [self.answer doubleValue]) {
        NSLog(@"success");
    } else {
        NSLog(@"failure");
    }
    [self nextQuestion];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self nextQuestion];
    [self.answerBox becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
