# LTRunLoop

[![CI Status](http://img.shields.io/travis/panyult/LTRunLoop.svg?style=flat)](https://travis-ci.org/panyult/LTRunLoop)
[![codecov.io](https://codecov.io/gh/panyult/LTRunLoop/coverage.svg?branch=master)](https://codecov.io/gh/panyult/LTRunLoop?branch=master)
[![Version](https://img.shields.io/cocoapods/v/LTRunLoop.svg?style=flat)](http://cocoapods.org/pods/LTRunLoop)
[![License](https://img.shields.io/cocoapods/l/LTRunLoop.svg?style=flat)](http://cocoapods.org/pods/LTRunLoop)
[![Platform](https://img.shields.io/cocoapods/p/LTRunLoop.svg?style=flat)](http://cocoapods.org/pods/LTRunLoop)

Using **LTRunLoop** you can just deliver your pending data,which needs to be handled on a secondary thread by the the method you provide,then LTRunLoop help you create a secondary thread and run the run loop of the thread to dispatch your data via input source.Finally,the run loop will invoke your method to handle the data,as an argument passed in,which you had delivered.LTRunLoop let you focus on input and hanlers of data.

## Quick Start


### 1.Start the manager.

```ObjC
    [[LTRunLoopManager manager] start];
```

### 2.Add a task to manager and declare who will handle the task's data.


***Using an object to handle the data***

the object should confirm the `protocol` ***LTRunLoopSourceHandler***.

```ObjC

    id data = [NSString stringWithFormat:@"success test send a LTRunLoopTask\n%d",++self.count];
	
    LTSourceTask *task = [LTSourceTask getASourceTaskWithPeddingData:data
        sourceHandler:anObject]; 
            
    [[LTRunLoopManager manager] addSourceTask:task];
    
```

***Or Using a class to handle the data***

, but the class must confirm the `protocol` ***LTRunLoopSourceHandler***.

```ObjC
    static int count = 0;
    
    id data = [NSString stringWithFormat:@"success test send a LTRunLoopTask\n%d",++count];
	
    LTSourceTask *task = [LTSourceTask sourceTaskWithPeddingData:data
    sourceHandlerClassName:NSStringFromClass(LTViewController.class)
    completion:^(LTSourceData *sourceData){
    // code you want to execute in the call back...
    }];];
    
    [[LTRunLoopManager manager] addSourceTask:task];
    
```

### 3.handle the data dispatched by the run loop of a secondary

***`RunLoopSourceHandler.h` declare two methods as follow:***

```ObjC
- (void)object_runLoopSourceHandled:(LTSourceData *)sourceData;

+ (void)class_runLoopSourceHandled:(LTSourceData *)sourceData;
```




## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

LTRunLoop is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LTRunLoop'
```

## Author

panyult, litaoxiwang@163.com

## License

LTRunLoop is available under the MIT license. See the LICENSE file for more info.
