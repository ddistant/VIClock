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
    
    [self recordStartTime];
    [self getHostClock];

}

-(void) fireTimer {
    
    if (self.timerDoesExist) {
//        NSLog(@"time is: %ld", [self getClockTime]);
//        NSLog(@"seconds elapsed is:%f", self.secondsElapsed);
        
        [self.delegate updateTime];
    }
}

-(void)stopTimer {
    
    if (self.timerDoesExist) {
        [self.timer invalidate];
        
        self.timerDoesExist = NO;
    }
}

-(void) recordStartTime {
    
    self.startTime = [NSDate date];

}

#pragma mark - host clock

-(void) getHostClock {
    
    self.clock = CMClockGetHostTimeClock();
}

-(long) getClockTime {
    
    NSInteger timescale = CMClockGetTime(self.clock).timescale;
    NSInteger value = CMClockGetTime(self.clock).value;
    
    return value / timescale;
}

-(NSInteger)secondsElapsed {
    
    NSDate *now = [NSDate date];
    NSTimeInterval seconds = [now timeIntervalSinceDate:self.startTime];
    
    NSInteger intSeconds = floor(seconds);
    
    return intSeconds;
}

-(NSInteger)minutesElapsed {
    return self.secondsElapsed / 60;
}

-(NSInteger)hoursElapsed {
    return self.minutesElapsed / 60;
}

@end
