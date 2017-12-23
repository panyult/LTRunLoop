//
//  LTSourceData.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/23.
//

#import "LTSourceData.h"

@implementation LTSourceData

+ (instancetype)dataWithTask:(LTSourceTask *)task handlType:(RunLoopSourceHandleType)handlType
{
    LTSourceData *data = [[self alloc] init];
    data.peddingData = task.peddingData;
    data.handlType = handlType;
    return data;
}

@end
