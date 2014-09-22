//
//  Question.h
//  Math Questions
//
//  Created by Dan Dodson on 9/8/14.
//  Copyright (c) 2014 Six Sigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic, copy, readonly) NSString *question;
@property (nonatomic, copy, readonly) NSNumber *answer;
- (id) initQuestion:(NSString*)question answer:(NSNumber*)answer;
- (BOOL) checkAnswer:(NSNumber*)userAnswer;
- (BOOL) checkStringAnswer:(NSString*)userAnswer;
@end
