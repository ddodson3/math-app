//
//  Question.m
//  Math Questions
//
//  Created by Dan Dodson on 9/8/14.
//  Copyright (c) 2014 Six Sigma. All rights reserved.
//

#import "Question.h"

@implementation Question

- (BOOL) checkAnswer:(NSNumber*)userAnswer {
    if ([userAnswer isEqualToNumber: _answer]) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (BOOL) checkStringAnswer:(NSString*)userAnswer {
    if (userAnswer.doubleValue == _answer.doubleValue) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (id) initQuestion:(NSString*)question answer:(NSNumber*)answer {
    self = [super init];
    if (self ) {
        _question = question;
        _answer = answer;
    }
    return self;
}

@end
