//
//  iSwim_ConverterAppDelegate.m
//  iSwim Converter
//
//  Created by Tony Florida on 6/10/10.
//  Copyright Raddfood 2010. All rights reserved.
//

#import "iSwim_ConverterAppDelegate.h"
#import "iSwim_ConverterViewController.h"

@implementation iSwim_ConverterAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
