//
//  iSwim_ConverterAppDelegate.h
//  iSwim Converter
//
//  Created by Tony Florida on 6/10/10.
//  Copyright Raddfood 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iSwim_ConverterViewController;

@interface iSwim_ConverterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iSwim_ConverterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iSwim_ConverterViewController *viewController;

@end

