//
//  RunLoopSourceHandler.h
//  LTRunLoop
//
//  Created by panyu_lt on 2017/12/22.
//

#import <Foundation/Foundation.h>

@interface RunLoopSourceHandler : NSObject
    
@property (nonatomic, copy  ) NSString *dataClassName;
@property (nonatomic, copy  ) NSString *handlerClassName;
@property (nonatomic, assign) SEL handlerSelector;

@end
