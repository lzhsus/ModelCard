//
//  AppDelegate.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/22.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "AppDelegate.h"
#import "Home.h"
#import "Work.h"
#import "TalentPool.h"
#import "Mine.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    /** 模卡 */
    Home * home = [[Home alloc]init];
    UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:home];
    
    /** 工作 */
    Work * work = [[Work alloc]init];
    UINavigationController * navi2 = [[UINavigationController alloc]initWithRootViewController:work];
    
    /** 人才库 */
    TalentPool * talentPool = [[TalentPool alloc]init];
    UINavigationController * navi3 = [[UINavigationController alloc]initWithRootViewController:talentPool];
    
    /** 我的 */
    Mine * mine = [[Mine alloc]init];
    UINavigationController * navi4 = [[UINavigationController alloc]initWithRootViewController:mine];
    
    UITabBarController * tab = [[UITabBarController alloc]init];
    
    [tab addChildViewController:navi1];
    [tab addChildViewController:navi2];
    [tab addChildViewController:navi3];
    [tab addChildViewController:navi4];

    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    /** 全局UINavigationBar */
    
    
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    UIImage *allBack = [[UIImage imageNamed:@"zuojiantou"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = allBack;
    navigationBar.backIndicatorTransitionMaskImage = allBack;
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    [navigationBar setShadowImage:[UIImage new]];
    [navigationBar setBarTintColor:[UIColor blackColor]];
    [navigationBar setTintColor:[UIColor clearColor]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
