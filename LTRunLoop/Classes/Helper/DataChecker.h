//
//  DataChecker.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>

@interface DataChecker : NSObject
    
+ (BOOL)isStringEmptyOrNil:(NSString *)string;
+ (BOOL)isArrayEmptyOrNil:(NSArray *)array;

@end
