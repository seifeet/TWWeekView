//
//  TWAppDelegate.h
//  TWWeekView
//
//  Created by Andrey Tabachnik on 8/13/12.
//  Copyright (c) 2012 Andrey Tabachnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWViewController;

@interface TWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TWViewController *viewController;

@end
