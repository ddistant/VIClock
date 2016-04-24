//
//  Stopwatch.h
//  VIClock
//
//  Created by Daniel Distant on 4/22/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

@protocol StopwatchDelegate <NSObject>

-(void) updateTime;

@end

@interface Stopwatch : NSObject

@property (nonatomic) NSInteger secondsElapsed;
@property (nonatomic) NSInteger minutesElapsed;
@property (nonatomic) NSInteger hoursElapsed;
@property (nonatomic) NSDate *startTime;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) BOOL timerDoesExist;
@property (nonatomic) struct OpaqueCMClock *clock;

@property (nonatomic) id<StopwatchDelegate>delegate;

-(void) startTimer;
-(void) stopTimer;

@end
