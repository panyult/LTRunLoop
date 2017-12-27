//
//  LTSampleSepc.m
//  LTRunLoop_Tests
//
//  Created by panyu_lt on 2017/12/26.
//  Copyright © 2017年 panyult. All rights reserved.
//

//#import "Kiwi/Kiwi.h"
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END
