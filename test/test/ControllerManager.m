//
//  ControllerManager.m
//  test
//
//  Created by Kalicy Zhou on 2017/4/4.
//  Copyright © 2017年 Kalicy Zhou. All rights reserved.
//

#import "ControllerManager.h"

@implementation ControllerManager

+ (instancetype)sharedInstance {
    __strong static ControllerManager* sharedPAMobileAPI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedPAMobileAPI  = [[ControllerManager alloc] init];
    });
    return sharedPAMobileAPI;
}

- (id)tab1 {
    if (_tab1 == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _tab1 = [sb instantiateViewControllerWithIdentifier:@"tab1"];
        _tab1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return _tab1;
}
- (id)tab2 {
    if (_tab2 == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _tab2 = [sb instantiateViewControllerWithIdentifier:@"tab2"];
        _tab2.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return _tab2;
}

- (void)presentModalViewController:(UIViewController*)current {
    UIViewController* toviewcontroller = (current == self.tab1)?self.tab2:self.tab1;
    float width = current.view.frame.size.width;
    float height = current.view.frame.size.height;
    toviewcontroller.view.frame = CGRectMake(0, height, width, height);
    [current.parentViewController transitionFromViewController:current toViewController:toviewcontroller duration:0.4 options:UIViewAnimationOptionTransitionNone animations:^{
        toviewcontroller.view.frame = CGRectMake(0, 0, width, height);
    }  completion:^(BOOL finished) {
        [toviewcontroller didMoveToParentViewController:current.parentViewController];
        //......
    }];
}

- (void)presentFlipViewController:(UIViewController*)current {
    UIViewController* toviewcontroller = (current == self.tab1)?self.tab2:self.tab1;
    UIViewAnimationOptions option = (current == self.tab1)?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
    [current.parentViewController transitionFromViewController:current toViewController:toviewcontroller duration:0.4 options:option animations:^{
    }  completion:^(BOOL finished) {
        [toviewcontroller didMoveToParentViewController:current.parentViewController];
        //......
    }];
}
@end
