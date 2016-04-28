//
//  ClockViewController.m
//  VIClock
//
//  Created by Daniel Distant on 4/22/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "ClockViewController.h"


#define DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)

@interface ClockViewController () <StopwatchDelegate>

@property (nonatomic) UILabel *stopwatchLabel;
@property (nonatomic) BOOL didSetupStopwatchLabelConstraints;

@property (nonatomic) Stopwatch *stopwatch; //keeps time
@property (nonatomic) ClockView *clockView; //handles the UI


@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createStopwatch];
//    [self createStopwatchLabel];
    [self createClockView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
//    [self setupStopwatchLabelConstraints];
    [self.stopwatch startTimer];
    
}

#pragma mark - stopwatchLabel

-(void) createStopwatchLabel { //for digital clock
    
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

#pragma mark - clockView 

-(void) createClockView {
    
    self.clockView = [ClockView newAutoLayoutView];
    [self.view addSubview:self.clockView];
    
    [self.clockView autoSetDimensionsToSize:CGSizeMake(300, 300)];
    [self.clockView autoCenterInSuperview];
    [self createClockViewLayers];
    
}

-(void) createClockViewLayers {
    
    //create 1 o'clock and 2 o'clock ticks
    
    UIBezierPath *oneTwoPath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                              radius:123
                                                          startAngle:DEGREES_TO_RADIANS(299)
                                                            endAngle:DEGREES_TO_RADIANS(335)
                                                           clockwise:YES];
    
    CAShapeLayer *oneTwoLayer = [CAShapeLayer layer];
    [oneTwoLayer setPath: oneTwoPath.CGPath];
    oneTwoLayer.anchorPoint = CGPointMake(0, 0);
    [oneTwoLayer setStrokeColor:[UIColor grayColor].CGColor];
    [oneTwoLayer setFillColor:[UIColor clearColor].CGColor];
    oneTwoLayer.lineWidth = 15;
    oneTwoLayer.lineDashPattern = @[@6, @58.5];
    oneTwoLayer.strokeStart = 0.0;
    oneTwoLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:oneTwoLayer];
    
    //3 & 4
    
    UIBezierPath *fourFivePath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                                radius:123
                                                            startAngle:DEGREES_TO_RADIANS(29)
                                                              endAngle:DEGREES_TO_RADIANS(75)
                                                             clockwise:YES];
    
    CAShapeLayer *fourFiveLayer = [CAShapeLayer layer];
    [fourFiveLayer setPath: fourFivePath.CGPath];
    [fourFiveLayer setStrokeColor:[UIColor grayColor].CGColor];
    [fourFiveLayer setFillColor:[UIColor clearColor].CGColor];
    fourFiveLayer.lineWidth = 15;
    fourFiveLayer.lineDashPattern = @[@6, @58.5];
    fourFiveLayer.strokeStart = 0.0;
    fourFiveLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:fourFiveLayer];
    
    //5 & 6
    
    UIBezierPath *sevenEightPath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                                  radius:123
                                                              startAngle:DEGREES_TO_RADIANS(119)
                                                                endAngle:DEGREES_TO_RADIANS(155)
                                                               clockwise:YES];
    
    CAShapeLayer *sevenEightLayer = [CAShapeLayer layer];
    [sevenEightLayer setPath: sevenEightPath.CGPath];
    [sevenEightLayer setStrokeColor:[UIColor grayColor].CGColor];
    [sevenEightLayer setFillColor:[UIColor clearColor].CGColor];
    sevenEightLayer.lineWidth = 15;
    sevenEightLayer.lineDashPattern = @[@6, @58.5];
    sevenEightLayer.strokeStart = 0.0;
    sevenEightLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:sevenEightLayer];
    
    //7 & 8
    
    UIBezierPath *tenElevenPath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                                 radius:123
                                                             startAngle:DEGREES_TO_RADIANS(209)
                                                               endAngle:DEGREES_TO_RADIANS(255)
                                                              clockwise:YES];
    
    CAShapeLayer *tenElevenLayer = [CAShapeLayer layer];
    [tenElevenLayer setPath: tenElevenPath.CGPath];
    [tenElevenLayer setStrokeColor:[UIColor grayColor].CGColor];
    [tenElevenLayer setFillColor:[UIColor clearColor].CGColor];
    tenElevenLayer.lineWidth = 15;
    tenElevenLayer.lineDashPattern = @[@6, @58.5];
    tenElevenLayer.strokeStart = 0.0;
    tenElevenLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:tenElevenLayer];
}

#pragma mark - stopwatch

-(void) createStopwatch {
    
    self.stopwatch = [[Stopwatch alloc] init];
    self.stopwatch.delegate = self;
    
}

-(void)updateTimeWithHours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds {
    
    //update stopwatchLabel
    
    self.stopwatchLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hours, minutes, seconds];
    
    NSLog(@"%@:%@:%@", hours, minutes, seconds);
    
    //strings to ints
    
    NSInteger hoursInt = [hours integerValue];
    NSInteger minutesInt = [minutes integerValue];
    NSInteger secondsInt = [seconds integerValue];
    
    //convert hours from military time
    
    if (hoursInt > 12) {
        hoursInt = hoursInt - 12;
    }
    
    //get angles
    
    double secondsAngle = GLKMathDegreesToRadians(secondsInt * 6);
    double minutesAngle = GLKMathDegreesToRadians(minutesInt * 6 + 90);
    double hoursAngle = GLKMathDegreesToRadians(hoursInt * 30 - 90);
    
    //update clockView
    
    self.clockView.secondHandLayer.affineTransform = CGAffineTransformMakeRotation(secondsAngle);
    self.clockView.minuteHandLayer.affineTransform = CGAffineTransformMakeRotation(minutesAngle);
    self.clockView.hourHandLayer.affineTransform = CGAffineTransformMakeRotation(hoursAngle);
}


@end
