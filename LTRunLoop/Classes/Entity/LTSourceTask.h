//
//  LTSourceTask.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/23.
//

#import <Foundation/Foundation.h>
#import "RunLoopSourceHandler.h"
@class LTSourceTask;
@interface LTSourceTask : NSObject

/**
 the data you want handled by the SourceHandler you provided
 */
@property (nonatomic, strong) id peddingData;

/**
 sourceHandler is the instance which handles the peddingData when the run loop dispatch the source.
 
 @Note When this property was set, the methods of 'sourceHandlerClassName' Class wuould not been invoked.Whenever the 'kLTRunLoopSourceHandleNotification' will be post and the RunLoopSource along with it in the notification's object.
 */
@property (nonatomic, weak  ) id<RunLoopSourceHandler> sourceHandler;

/**
 When you just want to hand the source off to a Class, set your target Class name to this property.
 
 @Note When the 'sourceHandler' was set, the methods of 'sourceHandlerClassName' Class wuould not been invoked.Whenever the 'kLTRunLoopSourceHandleNotification' will be post and the RunLoopSource along with it in the notification's object.
 */
@property (nonatomic, copy  ) NSString *sourceHandlerClassName;

+ (instancetype)getASourceTaskWithPeddingData:(id)data
                                sourceHandler:(id<RunLoopSourceHandler>)sourceHandler;

+ (instancetype)getASourceTaskWithPeddingData:(id)data
                     sourceHandlerClassName:(NSString *)sourceHandlerClassName;

@end
