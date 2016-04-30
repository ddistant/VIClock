//
//  Stopwatch.m
//  VIClock
//
//  Created by Daniel Distant on 4/22/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "Stopwatch.h"

@implementation Stopwatch

#pragma mark - timer

-(void) startTimer {
    
    if (!self.timerDoesExist) {
    
        self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        self.timerDoesExist = YES;
    }
    
    [self setupDateFormatter];

}

-(void) fireTimer {
    
    if (self.timerDoesExist) {
        
        [self getHoursMinutesSeconds];
    }
}

-(void)stopTimer {
    
    if (self.timerDoesExist) {
        [self.timer invalidate];
        
        self.timer = nil;
        self.timerDoesExist = NO;
    }
}

#pragma mark - date formatter

-(void) setupDateFormatter {
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH:mm:ss"];
}

-(void) getHoursMinutesSeconds {
    
    //get date, convert to string without colons
    
    NSDate *now = [NSDate date];
    NSString *dateString = [self.dateFormatter stringFromDate:now];
    NSString *dateStringCleaned = [dateString stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    //convert string to array of strings
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < dateStringCleaned.length; i++) {
        [dateArray addObject:[NSString stringWithFormat:@"%C", [dateStringCleaned characterAtIndex:i]]];
    }
    
    //get seconds, minutes and hours from array
    
    NSString *hours = [NSString stringWithFormat:@"%@%@", dateArray[0], dateArray[1]];
    NSString *minutes = [NSString stringWithFormat:@"%@%@", dateArray[2], dateArray[3]];
    NSString *seconds = [NSString stringWithFormat:@"%@%@", dateArray[4], dateArray[5]];
    
    //pass to delegate
    
    [self.delegate updateTimeWithHours:hours minutes:minutes seconds:seconds];
}



@end
