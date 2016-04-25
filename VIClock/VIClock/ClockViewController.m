//
//  ClockViewController.m
//  VIClock
//
//  Created by Daniel Distant on 4/22/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController () <StopwatchDelegate>

@property (nonatomic) ALView *timeContainer;
@property (nonatomic) UILabel *stopwatchLabel;

@property (nonatomic) BOOL didSetupTimeContainerConstraints;
@property (nonatomic) BOOL didSetupStopwatchLabelConstraints;

@property (nonatomic) Stopwatch *stopwatch;


@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createStopwatch];
    [self createTimeContainer];
    [self createStopwatchLabel];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self setupTimeContainerConstraints];
    [self setupStopwatchLabelConstraints];
    [self.stopwatch startTimer];
    
}

#pragma mark - timeContainer

-(void) createTimeContainer {
    
    self.timeContainer = [ALView newAutoLayoutView];
    self.timeContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.timeContainer];
}

-(void) setupTimeContainerConstraints {
    
    if (!self.didSetupTimeContainerConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.timeContainer autoCenterInSuperview];
            [self.timeContainer autoSetDimensionsToSize:CGSizeMake(200, 200)];
        }];
        
        self.didSetupTimeContainerConstraints = YES;
    }
}

#pragma mark - stopwatchLabel

-(void) createStopwatchLabel {
    
    self.stopwatchLabel = [[UILabel alloc] init];
    self.stopwatchLabel.backgroundColor = [UIColor blackColor];
//    self.stopwatchLabel.text = @"00:00:00";
    [self.stopwatchLabel setFont:[UIFont fontWithName:@"Arial" size:23.0]];
    self.stopwatchLabel.textAlignment = NSTextAlignmentCenter;
    self.stopwatchLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.stopwatchLabel];
    
}

-(void) setupStopwatchLabelConstraints {
    
    if (!self.didSetupStopwatchLabelConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.stopwatchLabel autoCenterInSuperview];
            [self.stopwatchLabel autoSetDimensionsToSize:CGSizeMake(100, 75)];
        }];
        
        self.didSetupStopwatchLabelConstraints = YES;
    }
    
}

#pragma mark - timer

-(void) createStopwatch {
    
    self.stopwatch = [[Stopwatch alloc] init];
    self.stopwatch.delegate = self;
    
}

-(void)updateTimeWithHours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds {
    
    self.stopwatchLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hours, minutes, seconds];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
