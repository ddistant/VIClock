//
//  Stopwatch.h
//  VIClock
//
//  Created by Daniel Distant on 4/22/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

@interface Stopwatch : NSObject

@property (nonatomic) NSTimeInterval secondsElapsed;
@property (nonatomic) NSTimeInterval minutesElapsed;
@property (nonatomic) NSTimeInterval hoursElapsed;

@property (nonatomic) NSDate *startTime;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) struct OpaqueCMClock *clock;

@property (nonatomic) BOOL timerDoesExist;


-(void) startTimer;
-(void) stopTimer;

@end
