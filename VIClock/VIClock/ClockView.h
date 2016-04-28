//
//  ClockView.h
//  VIClock
//
//  Created by Daniel Distant on 4/24/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PureLayout/PureLayout.h>
#import <QuartzCore/QuartzCore.h>

@interface ClockView : UIView

@property (nonatomic) UIView *whiteView;
@property (nonatomic) UIView *middleView;

@property (nonatomic) CAShapeLayer *secondHandLayer;
@property (nonatomic) CAShapeLayer *minuteHandLayer;
@property (nonatomic) CAShapeLayer *hourHandLayer;

@property (nonatomic) UILabel *twelveLabel;
@property (nonatomic) UILabel *threeLabel;
@property (nonatomic) UILabel *sixLabel;
@property (nonatomic) UILabel *nineLabel;

@end
