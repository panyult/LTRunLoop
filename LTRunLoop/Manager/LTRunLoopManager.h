//
//  LTRunLoopManager.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>
#import "LTSourceTask.h"

@interface LTRunLoopManager : NSObject
+ (instancetype)manager;

- (void)addSourceTask:(LTSourceTask *)task;

- (void)start;


@end
