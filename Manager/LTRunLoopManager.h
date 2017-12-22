//
//  LTRunLoopManager.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>

@interface LTRunLoopManager : NSObject
+ (instancetype)manager;
    
- (void)addPendingData:(id)data;
- (void)start;
@end
