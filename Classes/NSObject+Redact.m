//
//  NSObject+Redact.m
//  Demo
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import "NSObject+Redact.h"
#import "NCRedact.h"

@implementation NSObject (Redact)

- (NSString *)redactedDescription
{
    return [NCRedact redactString:[self description]];
}

@end
