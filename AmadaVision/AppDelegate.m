//
//  AppDelegate.m
//  MagnaVision
//
//  Created by eSecForte on 22/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "VideoViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navControl;
- (void)dealloc
{
    [_window release];
    [navControl release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    navControl=[[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.navControl.navigationBarHidden=YES;
    self.window.rootViewController = self.navControl;
    
    //Display error is there is no URL
    if (![launchOptions objectForKey:UIApplicationLaunchOptionsURLKey])
    {
//        UIAlertView *alertView;
//        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This app was launched without any text. Open this app using the Sender app to send text." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//        [alertView release];
    }

    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // Display text
    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *arrTemp=[text componentsSeparatedByString:@","];
    VideoViewController *obj=[[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:[NSBundle mainBundle]];
    obj.strSession=[arrTemp objectAtIndex:0];
    obj.strToke=[arrTemp objectAtIndex:1];
    obj.strPassKey_Id=[arrTemp objectAtIndex:2];
    obj.strFrmuType=[arrTemp objectAtIndex:3];
    [self.navControl pushViewController:obj animated:YES];
    [obj release];
    
    
    //UIAlertView *alertView;
//    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    alertView = [[UIAlertView alloc] initWithTitle:@"Text" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Opentok streams all stop when the app goes to background. Which means that voice connections are shut off, too.
    // there is apparantely a way to make things work, but the SDK often crashes on going to the background. 
    // I set the UIApplicationExitsOnSuspend to YES in the info plists. So now no problems on bacgrounding :) 
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"EnteringBackGround"
     object:self];
    
    //return; // we seem to hang in here, so we just let the app quit, as it does for background operation
    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
    }];
    [self performSelector:@selector(killApp) withObject:nil afterDelay:8.45];

}

-(void)killApp;
{
    if (bgTask)
    {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        exit(0);
    }
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (bgTask)
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    bgTask = 0;
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
