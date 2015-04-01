//
//  CDAWebSocketClient.h
//  CDAWebSocketClient
//
//  Created by Alsey Coleman Miller on 3/31/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <ObjFW/ObjFW.h>
#import <CDAFoundation/CDAFoundation.h>

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

/** The URL of the WebSockets server. */
@property (readonly) OFURL *url;

/** Whether frames sent to the server are masked. */
@property (readonly) BOOL masksFrames;

/** The state of the WebSocket's connection. Not KVO-compliant. */
@property (readonly) CDAWebSocketClientState state;

@end
