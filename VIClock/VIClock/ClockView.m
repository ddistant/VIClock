//
//  ClockView.m
//  VIClock
//
//  Created by Daniel Distant on 4/24/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView


- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    
    [self createWhiteView];
    [self createMiddleView];
    [self createLabels];
//    [self createLayers];
    [self createHands];
    
}

#pragma mark - views

-(void) createWhiteView {
    
    self.whiteView = [UIView newAutoLayoutView];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteView];
    [self.whiteView autoSetDimensionsToSize:CGSizeMake(290, 290)];
    [self.whiteView autoCenterInSuperview];
    self.whiteView.layer.cornerRadius = 145;
    
}

-(void) createMiddleView {
    
    self.middleView = [UIView newAutoLayoutView];
    self.middleView.backgroundColor = [UIColor blackColor];
    [self.whiteView addSubview:self.middleView];
    self.middleView.layer.cornerRadius = 7.5;
    [self.middleView autoCenterInSuperview];
    [self.middleView autoSetDimensionsToSize:CGSizeMake(15, 15)];
}

#pragma mark - labels

-(void) createLabels {
    
    [self createTwelveLabel];
    [self createThreeLabel];
    [self createSixLabel];
    [self createNineLabel];
    
}

-(void) createTwelveLabel {
    
    self.twelveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.twelveLabel.backgroundColor = [UIColor clearColor];
    self.twelveLabel.text = @"12";
    self.twelveLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.twelveLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.twelveLabel];
    
    [self.twelveLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.whiteView];
    [self.twelveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.whiteView withOffset:10];
    
}

-(void) createThreeLabel {
    
    self.threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.threeLabel.backgroundColor = [UIColor clearColor];
    self.threeLabel.text = @"3";
    self.threeLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.threeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.threeLabel];
    
    [self.threeLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.whiteView];
    [self.threeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView withOffset:-10];
}

-(void) createSixLabel {
    
    self.sixLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.sixLabel.backgroundColor = [UIColor clearColor];
    self.sixLabel.text = @"6";
    self.sixLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.sixLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.sixLabel];
    
    [self.sixLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.whiteView];
    [self.sixLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.whiteView withOffset:-10];
}

-(void) createNineLabel {
    
    self.nineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.nineLabel.backgroundColor = [UIColor clearColor];
    self.nineLabel.text = @"9";
    self.nineLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.nineLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.nineLabel];
    
    [self.nineLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.whiteView];
    [self.nineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView withOffset:10];
}

#pragma mark - layers

-(void) createLayers {
   
    //this method should happen here, refactor
}

#pragma mark - clock hands

-(void) createHands {
    [self createHourHand];
    [self createMinuteHand];
    [self createSecondHand];
}

-(void) createSecondHand {
    
    self.secondHandLayer = [CAShapeLayer layer];
    [self.secondHandLayer setPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, -110, 1, 110)].CGPath];
    [self.secondHandLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.secondHandLayer setFillColor:[UIColor redColor].CGColor];
    self.secondHandLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    [self.layer addSublayer:self.secondHandLayer];
}

-(void) createMinuteHand {
    
    self.minuteHandLayer = [CAShapeLayer layer];
    [self.minuteHandLayer setPath:[UIBezierPath bezierPathWithRect:CGRectMake(-110, 0, 110, 2)].CGPath];
    [self.minuteHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    [self.minuteHandLayer setFillColor:[UIColor blackColor].CGColor];
    self.minuteHandLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    [self.layer addSublayer:self.minuteHandLayer];
}

-(void) createHourHand {
    
    self.hourHandLayer = [CAShapeLayer layer];
    [self.hourHandLayer setPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, -2, 90, 4)].CGPath];
    [self.hourHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    [self.hourHandLayer setFillColor:[UIColor blackColor].CGColor];
    self.hourHandLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    [self.layer addSublayer:self.hourHandLayer];
}



@end
