//
//  LTSourceHandlerUtility.m
//  LTRunLoop_Example
//
//  Created by panyu_lt on 2017/12/28.
//  Copyright © 2017年 panyult. All rights reserved.
//

#import "LTSourceHandlerUtility.h"

#import <LTRunLoop/LTRunLoop.h>

@interface LTSourceHandlerUtility() <RunLoopSourceHandler>

@end

@implementation LTSourceHandlerUtility

+ (void)class_runLoopSourceHandled:(LTSourceData *)sourceData
{
    NSLog(@"---class_handler recieve data from the secondary thread : %@ ----data is --->%@",[NSThread currentThread],sourceData.peddingData);
    if (sourceData.completionBlock) {
        sourceData.completionBlock(sourceData);
    }
}


@end
