//
//  AppDelegate.h
//  MinesweeperApp
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIWindow *window;
    UITabBarController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *viewController;

@end