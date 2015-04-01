//
//  CDAWebSocketClient.h
//  CDAWebSocketClient
//
//  Created by Alsey Coleman Miller on 3/31/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <ObjFW/ObjFW.h>
#import <CDAFoundation/CDAFoundation.h>
#import <dispatch/dispatch.h>

@protocol CDAWebSocketClientDelegate;

/** The state of the WebSocket client connection. */
typedef enum {
    
    CDAWebSocketClientStateOpen,
    CDAWebSocketClientStateConnecting,
    CDAWebSocketClientStateClosing,
    CDAWebSocketClientStateClosed
    
} CDAWebSocketClientState;

/** Used to connect to a WebSocket server. Not thread-safe. */
@interface CDAWebSocketClient : OFObject

#pragma mark - Initialization

/** Initializes the WebSocket with the specified URL and masked frames by default. */
-(instancetype)initWithURL:(OFURL *)url;

/** Initializes the WebSocket with the specified URL and optionally masks frames. */
-(instancetype)initWithURL:(OFURL *)url masksFrames:(BOOL)masksFrames;

#pragma mark - Properties

/** The delegate for the WebSocket. */
@property id<CDAWebSocketClientDelegate> delegate;

/** The URL of the WebSockets server. */
@property (readonly) OFURL *url;

/** Whether frames sent to the server are masked. */
@property (readonly) BOOL masksFrames;

/** The state of the WebSocket's connection. Not KVO-compliant. */
@property (readonly) CDAWebSocketClientState state;

#pragma mark - Methods

/** Sends a string message to the server. */
-(void)sendMessage:(OFString *)message;

/** Sends data to the server. */
// TODO: -(void)sendData:(OFDataArray *)data;

/** Sends a string as binary data to the server. */
-(void)sendDataString:(OFString *)dataString;

/** Sends a ping to the server. */
-(void)sendPing;

/** Closes the connection with the server. */
-(void)close;

@end

#pragma mark - Protocol

@protocol CDAWebSocketClientDelegate <OFObject>

-(void)webSocket:(CDAWebSocketClient *)webSocket didRecieveMessage:(OFString *)message;

// TODO: -(void)webSocket:(CDAWebSocketClient *)webSocket didRecieveData:(OFDataArray *)data;

@end
