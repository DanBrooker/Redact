//
//  NCDictionaryTests.m
//  Demo
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NCDictionaryTests : XCTestCase

@end

@implementation NCDictionaryTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [NCRedact reset];
}

- (void)testRedactsPasswordFromDictionary
{
    NSDictionary *dictionary = @{@"password":@"secret",@"private_key":@"jdzfbd623hirkjbb7"};
    NSString *redacted = [dictionary redactedDescription];
    
    XCTAssertFalse([redacted includes:@"secret"], @"a redacted dictionary shouldn't include your password");
    XCTAssertTrue([redacted includes:@"jdzfbd623hirkjbb7"], @"currently doesn't know how to redact private key");
}

- (void)testRedactsOtherKeywordsFromDictionary
{
    NSDictionary *dictionary = @{@"password":@"secret",@"private_key":@"jdzfbd623hirkjbb7"};
    [NCRedact addRedactedKey:@"private_key"];
    
    NSString *redacted = [dictionary redactedDescription];
    
    XCTAssertFalse([redacted includes:@"secret"], @"a redacted dictionary shouldn't include your password");
    XCTAssertFalse([redacted includes:@"jdzfbd623hirkjbb7"], @"a redacted dictionary shouldn't include your private key");
}

@end
