//
//  NCAppDelegate.m
//  Demo
//
//  Created by Daniel Brooker on 3/23/14
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import "NCAppDelegate.h"
#import "Redact.h"

//#define NSLog RedactedLog

@implementation NCAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    NSLog(@"password = %@",@"super-secret-password");
}

@end
