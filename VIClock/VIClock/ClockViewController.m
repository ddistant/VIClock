//
//  ClockViewController.m
//  VIClock
//
//  Created by Daniel Distant on 4/22/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()

@property (nonatomic) UILabel *timeLabel;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    self.view.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
