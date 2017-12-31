//
//  LTRunLoopSourceHandler.h
//  Pods
//
//  Created by panyu_lt on 2017/12/23.
//

#ifndef LTRunLoopSourceHandler_h
#define LTRunLoopSourceHandler_h

#import <Foundation/Foundation.h>
#import "LTSourceData.h"

// A RunLoopSource instance is along with kLTRunLoopSourceHandleNotification, and the notif's object refers to it.
static NSString *const kLTRunLoopSourceHandleNotification = @"kLTRunLoopSourceHandleNotification";

@protocol LTRunLoopSourceHandler<NSObject>
@optional

- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData;

+ (void)class_runLoopSourceHandled:(LTSourceData *)sourceData;

@end


#endif /* LTRunLoopSourceHandler_h */
