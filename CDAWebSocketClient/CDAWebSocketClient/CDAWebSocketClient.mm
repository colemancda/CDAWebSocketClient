//
//  CDAWebSocketClient.m
//  WebSocketClient
//
//  Created by Alsey Coleman Miller on 3/31/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDAWebSocketClient.h"
#import "easywsclient.hpp"

@interface CDAWebSocketClient ()

// Private Properties

@property easywsclient::WebSocket::pointer internalWebSocketClient;

@property dispatch_queue_t connectionQueue;

// Mutable Properties

@property OFURL *url;

@property BOOL masksFrames;

@end

@implementation CDAWebSocketClient

#pragma mark - Initializers

-(void)dealloc
{
    delete _internalWebSocketClient;
}

-(instancetype)init
{
    OF_UNRECOGNIZED_SELECTOR
}

-(instancetype)initWithURL:(OFURL *)url
{
    return [self initWithURL:url masksFrames:true];
}

-(instancetype)initWithURL:(OFURL *)url masksFrames:(BOOL)masksFrames
{
    self = [super init];
    if (self) {
        
        self.url = url;
        
        self.masksFrames = masksFrames;
        
        OFString *urlString = url.string;
        
        if (masksFrames) {
            
            self.internalWebSocketClient = easywsclient::WebSocket::from_url(urlString.UTF8String);
        }
        else {
            
            self.internalWebSocketClient = easywsclient::WebSocket::from_url_no_mask(urlString.UTF8String);
        }
        
        self.connectionQueue = dispatch_queue_create("CDAWebSocketClient Connection Queue", NULL);
        
        // start polling
        
        dispatch_async(self.connectionQueue, ^{
            
            while (self.state != CDAWebSocketClientStateClosed) {
                
                self.internalWebSocketClient->poll();
                self.internalWebSocketClient->dispatch([self](const std::string & message) {
                    
                    [self.delegate webSocket:self didRecieveMessage:[OFString stringWithUTF8String:message.c_str()]];
                });
            }
        });
        
    }
    return self;
}

#pragma mark - Special Properties

-(CDAWebSocketClientState)state
{
    easywsclient::WebSocket::readyStateValues value = self.internalWebSocketClient->getReadyState();
    
    switch (value) {
            
        case easywsclient::WebSocket::OPEN:
            return CDAWebSocketClientStateOpen;
            break;
            
        case easywsclient::WebSocket::CONNECTING:
            return CDAWebSocketClientStateConnecting;
            break;
            
        case easywsclient::WebSocket::CLOSING:
            return CDAWebSocketClientStateClosing;
            break;
            
        case easywsclient::WebSocket::CLOSED:
            return CDAWebSocketClientStateClosed;
            break;
            
        default:
            break;
    }
}

#pragma mark - Methods

-(void)sendMessage:(OFString *)message
{
    self.internalWebSocketClient->send(message.UTF8String);
}

-(void)sendDataString:(OFString *)dataString
{
    self.internalWebSocketClient->sendBinary(dataString.UTF8String);
}

-(void)sendPing
{
    self.internalWebSocketClient->sendPing();
}

-(void)close
{
    self.internalWebSocketClient->close();
}

@end
