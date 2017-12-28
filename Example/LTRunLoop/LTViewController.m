//
//  LTViewController.m
//  LTRunLoop
//
//  Created by panyult on 12/22/2017.
//  Copyright (c) 2017 panyult. All rights reserved.
//

#import "LTViewController.h"
#import <LTRunLoop/LTRunLoop.h>

@interface LTViewController ()<RunLoopSourceHandler>
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, assign) int count;
@end

@implementation LTViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tipLabel];
    
    [[LTRunLoopManager manager] start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:[NSString stringWithFormat:@"success test send a LTRunLoopTask\n%d",++self.count] sourceHandler:self];

    [[LTRunLoopManager manager] addSourceTask:task];
}

#pragma mark - RunLoopSourceHandler

- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData
{
    NSLog(@"---recieve data from the secondary thread : %@ ----data is --->%@",[NSThread currentThread],sourceData.peddingData);

    dispatch_async(dispatch_get_main_queue(), ^{
        if (sourceData.peddingData && [sourceData.peddingData isKindOfClass:[NSString class]]) {
            self.tipLabel.text = sourceData.peddingData;
            self.tipLabel.textColor = [[UIColor greenColor] colorWithAlphaComponent:0.8];
        }
    });
}

#pragma mark - getters and setters

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _tipLabel.center = self.view.center;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"click the screen";
    }
    return _tipLabel;
}


@end
