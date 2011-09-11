//
//  Valid_Example_ProjectAppDelegate.h
//  Valid Example Project
//
//  Created by Jonah Williams on 9/11/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Valid_Example_ProjectViewController;

@interface Valid_Example_ProjectAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Valid_Example_ProjectViewController *viewController;

@end
