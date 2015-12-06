//
//  BaseNavigationController.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak BaseNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}


//系统第一次使用这个类的时候会调用
+(void)initialize
{
    //导航栏的主题
    UINavigationBar *appeance = [UINavigationBar appearance];
    //    [appeance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    att[NSForegroundColorAttributeName] = [UIColor blackColor];
    att[UITextAttributeTextShadowOffset] =[NSValue valueWithUIOffset:UIOffsetZero];//结构体，只有包装成NSValue对象，才可以放进字典。
    [appeance setTitleTextAttributes:att];
    
    //UIBarButtonItem主题设置
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *Ddict = [NSMutableDictionary dictionary];
    Ddict[NSForegroundColorAttributeName] = [UIColor blackColor];
    Ddict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:Ddict forState:UIControlStateNormal];
    
    NSMutableDictionary *Hdict = [NSMutableDictionary dictionary];
    Hdict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:Hdict forState:UIControlStateHighlighted];
    
    NSMutableDictionary *Disdict = [NSMutableDictionary dictionary];
    Disdict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:Disdict forState:UIControlStateDisabled];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //出去navbar上面的细线
    [appeance setShadowImage:[UIImage new]];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}


@end
