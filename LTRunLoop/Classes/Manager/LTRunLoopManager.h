//
//  LTRunLoopManager.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>
#import "LTSourceTask.h"

@interface LTRunLoopManager : NSObject

@property (nonatomic, readonly) BOOL isWorkerThreadExcuting;

/**
 A shared singleton you can use to start a run loop and add source task.

 @return LTRunLoopManager singleton.
 */
+ (instancetype)manager;

- (void)start;

- (void)addSourceTask:(LTSourceTask *)task;

@end
