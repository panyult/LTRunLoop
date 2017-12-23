//
//  DataChecker.m
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import "DataChecker.h"

@implementation DataChecker

#pragma mark - NSString
+ (BOOL)isStringEmptyOrNil:(NSString *)string
{
    if(!string || ![string isKindOfClass:[NSString class]]){
        return YES;
    }
    
    return string.length == 0;
}

#pragma mark - NSArray

+ (BOOL)isArrayEmptyOrNil:(NSArray *)array
{
    if(!array || ![array isKindOfClass:[NSArray class]]){
        return YES;
    }
    
    return array.count == 0;
}

@end
