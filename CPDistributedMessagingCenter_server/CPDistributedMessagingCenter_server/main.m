//
//  main.m
//  CPDistributedMessagingCenter_server
//
//  Created by lm mac mini1 on 2017/12/4.
//  Copyright © 2017年 lm mac mini1. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AppSupport/CPDistributedMessagingCenter.h>

@interface MyServerClass : NSObject
@end

@implementation MyServerClass

+ (void)load {
    [self sharedInstance];
}

+ (id)sharedInstance {
    static dispatch_once_t once = 0;
    __strong static id sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        // ...
        // Center name must be unique, recommend using application identifier.
        CPDistributedMessagingCenter * messagingCenter = [CPDistributedMessagingCenter centerNamed:@"unique.name.for.messaging.center"];
        [messagingCenter runServerOnCurrentThread];
        
        // Register Messages
        [messagingCenter registerForMessageName:@"messageThatHasInfo" target:self selector:@selector(handleMessageNamed:withUserInfo:)];
        [messagingCenter registerForMessageName:@"message" target:self selector:@selector(handleSimpleMessageNamed:)];
    }
    
    return self;
}

- (NSDictionary *)handleMessageNamed:(NSString *)name withUserInfo:(NSDictionary *)userinfo {
    // Process userinfo (simple dictionary) and return a dictionary (or nil)
    
    return @{@"key":@"value"};
}

- (void)handleSimpleMessageNamed:(NSString *)name {
    // ...
}
@end

int
main(int argc, char *argv[])
{
    [MyServerClass sharedInstance];
    
    [[NSRunLoop currentRunLoop] run];
}
