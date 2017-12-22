//
//  RunLoopContext.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>
#import "RunLoopSource.h"

@interface RunLoopContext : NSObject

@property (nonatomic, assign, readonly) CFRunLoopRef workerRunLoop;
@property (nonatomic, strong, readonly) RunLoopSource *runLoopSource;

- (instancetype)initWithSource:(RunLoopSource *)runLoopSource andRunLoop:(CFRunLoopRef)runLoop;

@end
