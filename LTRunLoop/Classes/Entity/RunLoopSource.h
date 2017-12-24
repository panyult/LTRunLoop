//
//  RunLoopSource.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>
#import "LTSourceTask.h"

@interface RunLoopSource : NSObject

- (void)addToCurrentRunLoop;
    
- (void)addTask:(LTSourceTask *)task;
    
- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end
