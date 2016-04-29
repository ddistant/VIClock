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

@property (nonatomic) BOOL didSetupClockViewConstraints;


@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createStopwatch];
    [self createClockView];
    [self createStopwatchLabel];
    [self.stopwatch startTimer];
    
}

#pragma mark - stopwatch

-(void) createStopwatch {
    
    self.stopwatch = [[Stopwatch alloc] init];
    self.stopwatch.delegate = self;
    
}

-(void)updateTimeWithHours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds {
    
    //update stopwatchLabel
    
    self.stopwatchLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hours, minutes, seconds];
    
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
//    double hoursExtensionAngle = GLKMathDegreesToRadians((minutesInt * 6 / 12)); //hour hand moves by the minute
    double hoursAngle = GLKMathDegreesToRadians(hoursInt * 30 - 90 + (minutesInt * 6 / 12));
    
    //update clockView
    
    self.clockView.secondHandLayer.affineTransform = CGAffineTransformMakeRotation(secondsAngle);
    self.clockView.minuteHandLayer.affineTransform = CGAffineTransformMakeRotation(minutesAngle);
    self.clockView.hourHandLayer.affineTransform = CGAffineTransformMakeRotation(hoursAngle);
}

#pragma mark - stopwatchLabel

-(void) createStopwatchLabel { //for digital clock
    
    self.stopwatchLabel = [[UILabel alloc] init];
    self.stopwatchLabel.backgroundColor = [UIColor blackColor];
    [self.stopwatchLabel setFont:[UIFont fontWithName:@"Arial" size:23.0]];
    self.stopwatchLabel.textAlignment = NSTextAlignmentCenter;
    self.stopwatchLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.stopwatchLabel];
    
    [self setupStopwatchLabelConstraints];
    
}

-(void) setupStopwatchLabelConstraints {
    
    if (!self.didSetupStopwatchLabelConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.stopwatchLabel autoSetDimensionsToSize:CGSizeMake(100, 75)];
            [self.stopwatchLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
            [self.stopwatchLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.clockView withOffset:20];
            
        }];
        
        self.didSetupStopwatchLabelConstraints = YES;
    }
    
}

#pragma mark - clockView 

-(void) createClockView {
    
    self.clockView = [ClockView newAutoLayoutView];
    [self.view addSubview:self.clockView];

    [self setupClockViewConstraints];
    [self createClockViewLayers];
    
}

-(void) setupClockViewConstraints {
    
    if (!self.didSetupClockViewConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.clockView autoSetDimensionsToSize:CGSizeMake(300, 300)];
            [self.clockView autoCenterInSuperview];
            
        }];
        
        self.didSetupClockViewConstraints = YES;
    }
    
}

-(void) createClockViewLayers {
    
    //create 1 o'clock and 2 o'clock ticks
    
    [self createClockViewLayerWithStartAngle:299 endAngle:335];
    [self createClockViewLayerWithStartAngle:29 endAngle:75]; //4 & 5
    [self createClockViewLayerWithStartAngle:119 endAngle:155]; //7 & 8
    [self createClockViewLayerWithStartAngle:209 endAngle:255]; //10 & 11

}

-(void) createClockViewLayerWithStartAngle:(NSInteger)startAngle endAngle:(NSInteger)endAngle {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                        radius:123
                                                    startAngle:DEGREES_TO_RADIANS(startAngle)
                                                      endAngle:DEGREES_TO_RADIANS(endAngle)
                                                     clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setPath: path.CGPath];
    [layer setStrokeColor:[UIColor grayColor].CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    layer.lineWidth = 15;
    layer.lineDashPattern = @[@6, @58.5];
    layer.strokeStart = 0.0;
    layer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:layer];
}


@end
