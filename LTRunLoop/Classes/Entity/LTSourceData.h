//
//  LTSourceData.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/23.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,LTRunLoopSourceHandleType) {
    LTRunLoopSourceHandleTypeNotScheduled = 0,
    LTRunLoopSourceHandleTypeScheduled,
    LTRunLoopSourceHandleTypeHandled,
    LTRunLoopSourceHandleTypeCanceled,
};

@class LTSourceData;

@interface LTSourceData : NSObject
/**
 default is RunLoopSourceHandleTypeNotScheduled
 */
@property (nonatomic, assign) LTRunLoopSourceHandleType handleType;

@property (nonatomic, strong) id peddingData;

@end
