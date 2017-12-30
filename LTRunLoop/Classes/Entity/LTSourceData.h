//
//  LTSourceData.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/23.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,RunLoopSourceHandleType) {
    RunLoopSourceHandleTypeNotScheduled = 0,
    RunLoopSourceHandleTypeWillScheduled,
    RunLoopSourceHandleTypeHandled,
    RunLoopSourceHandleTypeCanceled,
};

@class LTSourceData;

@interface LTSourceData : NSObject
/**
 default is RunLoopSourceHandleTypeNotScheduled
 */
@property (nonatomic, assign) RunLoopSourceHandleType handleType;

@property (nonatomic, strong) id peddingData;

@end
