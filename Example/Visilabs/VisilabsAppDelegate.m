//
//  VisilabsAppDelegate.m
//  Visilabs
//
//  Created by visilabs on 12/15/2015.
//  Copyright (c) 2015 visilabs. All rights reserved.
//

#import "VisilabsAppDelegate.h"
#import "EuroIOSFramework/EuroManager.h"

@implementation VisilabsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //NSString * euromsgmobilappSiteID = @"482B67724F524B5A6353633D";
    //NSString * euromsgmobilappDataSource = @"euromsgmobilapp";
    
    /*
    NSString * visilabsDemoOID = @"53444A2B4B5071322F50303D";
    NSString * visilabsDemoSiteID = @"515977535854504E506E413D";
    NSString * visilabsDemoDataSource = @"mrhp";
    */
    
    NSString * visilabsNewOID = @"53444A2B4B5071322F50303D";
    NSString * visilabsNewSiteID = @"362F714E306C756B2B37593D";
    NSString * visilabsNewDataSource = @"visilabsnew";
    
    [Visilabs createAPI:visilabsNewOID withSiteID:visilabsNewSiteID withSegmentURL:@"http://lgr.visilabs.net" withDataSource:visilabsNewDataSource withRealTimeURL:@"http://rt.visilabs.net" withChannel:@"IOS" withRequestTimeout:30 withTargetURL:@"http://s.visilabs.net/json" withActionURL:@"http://s.visilabs.net/actjson" withGeofenceURL:@"http://s.visilabs.net/geojson" withGeofenceEnabled:YES];
    // Override point for customization after application launch.
    
    [Visilabs callAPI].checkForNotificationsOnLoggerRequest = YES;
    
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        #ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
        #endif
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    
    //[[VisilabsGFMainController sharedInstance] start];

    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    [[EuroManager sharedManager:@"VisilabsIOSDemoTest2"] registerToken:deviceToken];
    [[EuroManager sharedManager:@"VisilabsIOSDemoTest2"] synchronize];

    
    NSString *tokenString = [[[deviceToken description] stringByTrimmingCharactersInSet:
                              [NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                             stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[Visilabs callAPI] login:@"egemen@visilabs.com"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:tokenString forKey:@"OM.sys.TokenID"];
    [dic setObject:@"VisilabsIOSDemoTest2" forKey:@"OM.sys.AppID"];
    [[Visilabs callAPI] customEvent:@"RegisterToken" withProperties:dic];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registration failed : %@",error.description);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //NSLog(@"didReceiveRemoteNotification : %@",userInfo);
    [[EuroManager sharedManager:@"VisilabsIOSDemoTest2"] handlePush:userInfo];
}








- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
