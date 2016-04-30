//
//  StopwatchTests.m
//  VIClock
//
//  Created by Daniel Distant on 4/29/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Stopwatch.h"

@interface StopwatchTests : XCTestCase <StopwatchDelegate>

@property (nonatomic) Stopwatch *stopwatchToTest;
@property (nonatomic) BOOL stopwatchDelegateInvoked;

@end

@implementation StopwatchTests

- (void)setUp {
    [super setUp];
    
    self.stopwatchToTest = [[Stopwatch alloc] init];
    self.stopwatchToTest.delegate = self;
    [self.stopwatchToTest startTimer];
}

-(void)updateTimeWithHours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds {
    
    self.stopwatchDelegateInvoked = YES;
}

-(void) testDelegate {
    
    XCTAssertNotNil(self.stopwatchToTest.delegate, @"delegate must be assigned");
    [self.stopwatchToTest.delegate updateTimeWithHours:@"" minutes:@"" seconds:@""];
    XCTAssertTrue(self.stopwatchDelegateInvoked, @"Delegate should call -updateTimeWithHours:");
}


-(void) testStartTimer {
    
    XCTAssertTrue(self.stopwatchToTest.timerDoesExist, @"timerDoesExist should be YES");
    XCTAssertTrue(self.stopwatchToTest.timer, @"timer must be instantiated");
    
}

-(void) testForDateFormatter {
    
    XCTAssertTrue(self.stopwatchToTest.dateFormatter, @"dateFormatter must be instantiated");
}

-(void) testStopTimer {
    
    [self.stopwatchToTest stopTimer];
    
    XCTAssertFalse([self.stopwatchToTest.timer isValid], @"timer should not be running");
    XCTAssertNil(self.stopwatchToTest.timer, @"timer should not be instantiated");
    XCTAssertFalse(self.stopwatchToTest.timerDoesExist, @"timerDoesExist should be NO");
    
}

- (void)tearDown {
    
    self.stopwatchToTest.delegate = nil;
    
    [super tearDown];
}

@end
