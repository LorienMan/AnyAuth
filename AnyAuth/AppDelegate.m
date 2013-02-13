//
//  AppDelegate.m
//  AnyAuth
//
//  Created by Ilya Amelchenkov on 2/12/13.
//  Copyright (c) 2013 ASM. All rights reserved.
//

#import "AppDelegate.h"
#import "VkontakteAuthHandler.h"
#import "FacebookAuthHandler.h"
#import "AnyAuthViewController.h"
#import "FoursquareAuthHandler.h"

@interface AppDelegate () <AnyAuthViewControllerDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    VkontakteAuthHandler *handler = [[VkontakteAuthHandler alloc] initWithAppId:@"xxxxx" scope:@"photos"];
    //FacebookAuthHandler *handler = [[FacebookAuthHandler alloc] initWithAppId:@"xxxxxxxxx" scope:@"email,read_friendlists"];
    //FoursquareAuthHandler *handler = [[FoursquareAuthHandler alloc] initWithClientId:@"xxxxxxxxxx" redirectURI:@"xxxxxxxxx" languagePrefix:@"ru"];
    AnyAuthViewController *controller = [[AnyAuthViewController alloc] initWithHandler:handler];
    controller.delegate = self;
    self.window.rootViewController = controller;

    [self.window makeKeyAndVisible];

    return YES;
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

#pragma mark AnyAuthViewControllerDelegate

- (void)authController:(AnyAuthViewController *)controller didFinishAuthorized:(BOOL)authorized {
    NSLog(@"authorized = %d", authorized);
    NSLog(@"accessToken = %@", [(VkontakteAuthHandler *)controller.handler accessToken]);
}

@end
