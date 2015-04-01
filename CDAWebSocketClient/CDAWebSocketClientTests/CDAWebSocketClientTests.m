//
//  CDAWebSocketClientTests.m
//  CDAWebSocketClientTests
//
//  Created by Alsey Coleman Miller on 3/31/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ObjFW/ObjFW.h>
#import <CDAFoundation/CDAFoundation.h>
#import <CDAWebSocketClient/CDAWebSocketClient.h>

@interface CDAWebSocketClientTests : XCTestCase <CDAWebSocketClientDelegate>

@property CDAWebSocketClient *webSocket;

@property OFString *serverResponse;

@end

@implementation CDAWebSocketClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.serverResponse = nil;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMessageEcho {
    
    OFURL *serverURL = [OFURL URLWithString:@""];
    
    self.webSocket = [[CDAWebSocketClient alloc] initWithURL:serverURL];
}

#pragma mark - CDAWebSocketClientDelegate

-(void)webSocket:(CDAWebSocketClient *)webSocket didRecieveMessage:(OFString *)message
{
    of_log(@"Did recieve message: %@", message);
    
    self.serverResponse = message;
}

@end
