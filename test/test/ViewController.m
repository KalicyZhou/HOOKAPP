//
//  ViewController.m
//  test
//
//  Created by Kalicy Zhou on 2017/4/4.
//  Copyright © 2017年 Kalicy Zhou. All rights reserved.
//

#import "ViewController.h"
#import "ControllerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self addChildViewController:[ControllerManager sharedInstance].tab2];
    [self addChildViewController:[ControllerManager sharedInstance].tab1];
    [self.view  addSubview:[ControllerManager sharedInstance].tab1.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
