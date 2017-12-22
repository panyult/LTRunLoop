//
//  RunLoopContext.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import "RunLoopContext.h"

@implementation RunLoopContext

#pragma mark - life cycle
    
- (instancetype)initWithSource:(RunLoopSource *)runLoopSource andRunLoop:(CFRunLoopRef)runLoop
{
    if (self = [super init]) {
        _runLoopSource = runLoopSource;
        _workerRunLoop = runLoop;
    }
    return self;
}
@end
