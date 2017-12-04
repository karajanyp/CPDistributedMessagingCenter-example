//
//  main.m
//  CPDistributedMessagingCenter_client
//
//  Created by lm mac mini1 on 2017/12/4.
//  Copyright © 2017年 lm mac mini1. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AppSupport/CPDistributedMessagingCenter.h>

int main(void) {
    @autoreleasepool {
        CPDistributedMessagingCenter *messagingCenter;
        messagingCenter = [CPDistributedMessagingCenter centerNamed:@"unique.name.for.messaging.center"];
        
        // One-way (message only)
        [messagingCenter sendMessageName:@"message" userInfo:nil/* optional dictionary. in this example it will be ignored. */];
        
        // Two-way (wait for reply)
        NSDictionary *reply;
        reply = [messagingCenter sendMessageAndReceiveReplyName:@"messageThatHasInfo" userInfo:nil/* optional dictionary */];
        
        NSLog(@"reply = %@", reply);
    }
    return 0;
}
