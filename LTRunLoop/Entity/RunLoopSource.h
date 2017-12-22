//
//  RunLoopSource.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>

@interface RunLoopSource : NSObject
    
- (void)addToCurrentRunLoop;
    
- (void)addPeddingData:(id)data;
    
- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end
