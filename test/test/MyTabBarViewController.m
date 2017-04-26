//
//  MyTabBarViewController.m
//  test
//
//  Created by Kalicy Zhou on 2017/4/4.
//  Copyright © 2017年 Kalicy Zhou. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "ControllerManager.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIButton* view = [[UIButton alloc]initWithFrame:CGRectMake(150, self.view.frame.size.height-44, 44, 44)];
    view.backgroundColor = [UIColor redColor];
    [view addTarget:self action:@selector(chooseMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    view = [[UIButton alloc]initWithFrame:CGRectMake(155+44, self.view.frame.size.height-44, 44, 44)];
    view.backgroundColor = [UIColor yellowColor];
    [view addTarget:self action:@selector(chooseMode2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
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

- (void)chooseMode {
    
    [[ControllerManager sharedInstance]presentModalViewController:self];
}
- (void)chooseMode2 {
    
    [[ControllerManager sharedInstance]presentFlipViewController:self];
}
#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0)
    {
      //  [[ControllerManager sharedInstance]presentModalViewController:self];
    }
    else if (tabBarController.selectedIndex == 1)
    {
       // [[ControllerManager sharedInstance]presentFlipViewController:self];
    }

}

@end
