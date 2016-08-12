//
//  AppDelegate.m
//  CDOJ-IOS
//
//  Created by GuessEver on 16/8/8.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "AppDelegate.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import "MainViewController.h"
#import "Color.h"
#import "LocalDataModel.h"
#import "UserModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // pgyer Crash SDK
    [[PgyManager sharedPgyManager] setThemeColor:COLOR_TITLE];
    [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeThreeFingersPan];
    [[PgyManager sharedPgyManager] startManagerWithAppId:@"74616353180ead882c4e5fb795aeb7d7"];
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"74616353180ead882c4e5fb795aeb7d7"];
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
//    [NSThread sleepForTimeInterval:1];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:COLOR_BACKGROUND];
    if([LocalDataModel needWelcome]) {
        // open app for the first time, do something here ...
        NSLog(@"welcome!");
        [LocalDataModel initLocalData];
    }
    self.window.rootViewController = [[MainViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.userSessionKeeperTimer invalidate];
    self.userSessionKeeperTimer = nil;
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
    if(self.userSessionKeeperTimer == nil) {
        NSTimeInterval seconds = 30 * 60; // 30 minutes
        self.userSessionKeeperTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:[UserModel class] selector:@selector(userLoginWithDefaultUser) userInfo:nil repeats:YES];
    }
    [self.userSessionKeeperTimer fire];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
