//
//  LTSourceData.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/23.
//

#import <Foundation/Foundation.h>
#import "LTSourceTask.h"

@interface LTSourceData : NSObject
/**
 default is RunLoopSourceHandleTypeNotScheduled
 */
@property (nonatomic, assign) RunLoopSourceHandleType handlType;

@property (nonatomic, strong) id peddingData;

+ (instancetype)dataWithTask:(LTSourceTask *)task handlType:(RunLoopSourceHandleType)handlType;

@end
