//
//  StopwatchTests.m
//  VIClock
//
//  Created by Daniel Distant on 4/29/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Stopwatch.h"

@interface StopwatchTests : XCTestCase

@property (nonatomic) Stopwatch *stopwatchToTest;

@end

@implementation StopwatchTests

- (void)setUp {
    [super setUp];
    
    self.stopwatchToTest = [[Stopwatch alloc] init];
    [self.stopwatchToTest startTimer];
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
    
    [super tearDown];
}

@end
