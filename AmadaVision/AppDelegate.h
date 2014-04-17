//
//  AppDelegate.h
//  MagnaVision
//
//  Created by eSecForte on 22/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navControl;
    UIBackgroundTaskIdentifier bgTask;
}
@property (nonatomic,retain)    UINavigationController *navControl;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end
