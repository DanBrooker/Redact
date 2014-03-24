//
//  NCObjectTests.m
//  Demo
//
//  Created by Daniel Brooker on 24/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+AutoDescription.h"

@interface NCTestUser : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end

@implementation NCTestUser

- (NSString *)description
{
    return [NSString stringWithFormat:@"username: %@, password: %@",self.username,self.password];
}

@end

@interface NCObjectTests : XCTestCase
{
    NCTestUser *user;
}

@end

@implementation NCObjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    user  = [[NCTestUser alloc] init];
    user.username = @"axeman13";
    user.password = @"secret";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [NCRedact reset];
    [super tearDown];
}

- (void)testUserObjectWithDescription
{
    XCTAssertTrue([[user description] includes:user.password], @"normal description includes password");
    NSLog(@"redacted: %@",[user redactedDescription]);
    XCTAssertFalse([[user redactedDescription] includes:user.password], @"redacted description shouldn't contain the actual password");
}

- (void)testUserObjectWithAudtodescribe
{
    NSString *description = [user autoDescription];
    XCTAssertTrue([description includes:user.password], @"normal description includes password");
    NSLog(@"redacted: %@",[description redactedDescription]);
    XCTAssertFalse([[description redactedDescription] includes:user.password], @"redacted description shouldn't contain the actual password");
}

@end
