//
//  ControllerManager.h
//  test
//
//  Created by Kalicy Zhou on 2017/4/4.
//  Copyright © 2017年 Kalicy Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ControllerManager : NSObject
@property (nonatomic, strong)UITabBarController* tab1;
@property (nonatomic, strong)UITabBarController* tab2;

/**
 * 获取HTTPDNS全局唯一对象
 */
+ (instancetype)sharedInstance;
- (void)presentModalViewController:(id)current;
- (void)presentFlipViewController:(UIViewController*)current;
@end
