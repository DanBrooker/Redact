//
//  NCStringTests.h
//  Demo
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Redact.h"

@interface NCTestPaths : XCTestCase

@end

@implementation NCTestPaths

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [NCRedact reset];
    [super tearDown];
}

// Reduce string paths
- (void)testMakingPathsRelative
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *longerPath = [path stringByAppendingPathComponent:@"folderWeCareAbout"];
    
    XCTAssertTrue([longerPath includes:path],@"full path is present");
    
    [NCRedact addRedactString:path];
    
    NSString *redactedPath = [longerPath redactedDescription];
    XCTAssertFalse([redactedPath includes:path],@"full path has been trimmed to reduce visual spam");
}

@end
