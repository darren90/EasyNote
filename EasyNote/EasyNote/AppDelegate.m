//
//  AppDelegate.m
//  EasyNote
//
//  Created by Tengfei on 15/11/25.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/CrashReporter.h>
#import "MobClick.h"
#import <ENSDK.h>

#import "NewNoteController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

////设置是否允许推送为允许
//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    if (self.item.key) {
//[defaults setBool:YES forKey:KSettingPush];
//[defaults setBool:YES forKey:KSettingUse3G];
//[defaults synchronize];

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[CrashReporter sharedInstance] installWithAppId:KBuglyAPPID];
    
    [self initEverNote];
    [self umengTrack];//友盟的方法本身是异步执行，所以不需要再异步调用
    
//    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
//    //根据不同的Action响应不同的事件
//    if ([item.type isEqualToString:@"addNote"]) {//3DTouch 菜单，添加笔记
//        //根据不同的Action响应不同的事件
//        NSLog(@"---sdfsdfds");
//        return NO;
//    }
    return YES;
}
-(void)initEverNote
{
    // Set shared session key information.
    [ENSession setSharedSessionConsumerKey:@"teng"
                            consumerSecret:@"d6c7294a6d2dfb88"
                              optionalHost:ENSessionHostSandbox];
}
- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:NO];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:KUmegnAppKey reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
//    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}
- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[ENSession sharedSession] handleOpenURL:url];
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
//    NSLog(@"---:%@--:%@",shortcutItem,shortcutItem.type);
    if ([shortcutItem.type isEqualToString:@"addNote"]) {//3DTouch 菜单，添加笔记
        //根据不同的Action响应不同的事件
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NewNoteController *newVc = [sb instantiateViewControllerWithIdentifier:@"newNoteVc"];
        BaseNavigationController *nav = (BaseNavigationController *)self.window.rootViewController;
        [nav.topViewController.navigationController pushViewController:newVc animated:YES];
    }
    if (completionHandler) {
        completionHandler(YES);
    }
}

@end
