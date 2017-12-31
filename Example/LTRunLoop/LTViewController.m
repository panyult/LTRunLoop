//
//  LTViewController.m
//  LTRunLoop
//
//  Created by panyult on 12/22/2017.
//  Copyright (c) 2017 panyult. All rights reserved.
//

#import "LTViewController.h"
#import <LTRunLoop/LTRunLoop.h>
#import "LTSourceHandlerUtility.h"

@interface LTViewController ()<LTRunLoopSourceHandler>

@property (nonatomic, strong) UIButton *useObjHandlerButton;
@property (nonatomic, strong) UIButton *useClassHandlerButton;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, assign) int count;
@end

@implementation LTViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultValue];
    [self setupSubviews];
    
    [[LTRunLoopManager manager] start];
}

- (void)setupDefaultValue
{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - layout subviews

- (void)setupSubviews
{
    [self addSubviews];
    [self setupSubviewsConstraints];
}

- (void)addSubviews
{
    UIView *supserView = self.view;
    
    [supserView addSubview:self.useObjHandlerButton];
    [supserView addSubview:self.useClassHandlerButton];
    [supserView addSubview:self.tipLabel];
}

- (void)setupSubviewsConstraints
{
    CGRect frame = self.tipLabel.frame;
    frame.origin.y = CGRectGetMaxY(self.useClassHandlerButton.frame) + 20;
    self.tipLabel.frame = frame;
    
}

#pragma mark - RunLoopSourceHandler

- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData
{
    NSLog(@"---obj_handler recieve data from the secondary thread : %@ ----data is --->%@",[NSThread currentThread],sourceData.peddingData);
    [self updateTipLabelWithData:sourceData.peddingData];
}

- (void)updateTipLabelWithData:(id)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (data && [data isKindOfClass:[NSString class]]) {
            self.tipLabel.text = data;
            self.tipLabel.textColor = [[UIColor greenColor] colorWithAlphaComponent:0.8];
        }
    });
}

#pragma mark - event response

- (void)useObjHandlerButtonAciton
{
    LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:[self getDataWithPreString:@"obj_handler"] sourceHandler:self];
    
    [[LTRunLoopManager manager] addSourceTask:task];
}

- (void)useClassHandlerButtonAciton
{
    
    __weak typeof(self) weakSelf = self;
    
    LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:[self getDataWithPreString:@"class_handler"]
                                          sourceHandlerClassName:NSStringFromClass([LTSourceHandlerUtility class])
                                                      completion:^(LTSourceData *sourceData){
                                                          [weakSelf updateTipLabelWithData:sourceData.peddingData];
    }];
    
    [[LTRunLoopManager manager] addSourceTask:task];
}

#pragma mark - private methods

- (NSString *)getDataWithPreString:(NSString *)preString
{
    return [NSString stringWithFormat:@" %@_success \n%d",preString,++self.count];
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target sel:(SEL)sel index:(int)index
{
    CGFloat height = 50;
    CGFloat paddingV = 20;
    CGFloat width = 300;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - width)/2.0;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, index*(height+paddingV) + 64 ,width, height)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [button setBackgroundColor:[UIColor purpleColor]];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - getters and setters

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _tipLabel.center = self.view.center;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"click the buttons above";
    }
    return _tipLabel;
}

- (UIButton *)useObjHandlerButton
{
    if (!_useObjHandlerButton) {
        _useObjHandlerButton = [self buttonWithTitle:@"use an obj handle" target:self sel:@selector(useObjHandlerButtonAciton) index:0];
    }
    return _useObjHandlerButton;
}

- (UIButton *)useClassHandlerButton
{
    if (!_useClassHandlerButton) {
        _useClassHandlerButton = [self buttonWithTitle:@"use a class handle" target:self sel:@selector(useClassHandlerButtonAciton) index:1];
    }
    return _useClassHandlerButton;
}


@end
