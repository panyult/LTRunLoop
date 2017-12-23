//
//  RunLoopSourceHandler.h
//  Pods
//
//  Created by panyu_lt on 2017/12/23.
//

#ifndef RunLoopSourceHandler_h
#define RunLoopSourceHandler_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,RunLoopSourceHandleType) {
    RunLoopSourceHandleTypeNotScheduled = 0,
    RunLoopSourceHandleTypeWillScheduled,
    RunLoopSourceHandleTypeHandled,
    RunLoopSourceHandleTypeCanceled,
};

// A RunLoopSource instance is along with kLTRunLoopSourceHandleNotification, and the notif's object refers to it.
static NSString *const kLTRunLoopSourceHandleNotification = @"kLTRunLoopSourceHandleNotification";

@class LTSourceData;
@protocol RunLoopSourceHandler<NSObject>
@optional

- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData;

+ (void)class_runLoopSourceHandled:(LTSourceData *)sourceData;

@end


#endif /* RunLoopSourceHandler_h */
