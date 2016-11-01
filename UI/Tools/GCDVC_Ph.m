//
//  GCDVC_Ph.m
//  Master
//
//  Created by xhc on 10/28/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "GCDVC_Ph.h"

@interface GCDVC_Ph ()

@end

@implementation GCDVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_semaphore_t getAliyunKeySemaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("GetAliyunKey", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");        
        dispatch_group_t groupDispatch = dispatch_group_create();
        
        dispatch_group_async(groupDispatch, dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT), ^{
            NSLog(@"3");
            dispatch_semaphore_signal(getAliyunKeySemaphore);
        });
        
    });
    NSLog(@"4");
    dispatch_semaphore_wait(getAliyunKeySemaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"5");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
