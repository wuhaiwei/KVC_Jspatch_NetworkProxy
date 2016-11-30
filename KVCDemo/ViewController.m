//
//  ViewController.m
//  KVCDemo
//
//  Created by  wuhiwi on 16/11/28.
//  Copyright © 2016年 wanglibank.com. All rights reserved.
//

#import "ViewController.h"
#import "KVCModel.h"
#import <JPEngine.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *crashButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVCModel *model = [[KVCModel alloc] init];
    [model setValue:@"It's ivar value!" forKey:@"ivar"];
    NSLog(@"%@",[model valueForKey:@"ivar"]);
    
    //kvc的开箱、封箱操作
    [model setValue:@11.345 forKey:@"number"];
    NSLog(@"%@",[model valueForKey:@"number"]);
    
    //万能容器
    [model setValue:@"吴海伟" forKey:@"name"];
    [model setValue:@25 forKey:@"age"];
    
    NSLog(@"\n%@,%@]\n",[model valueForKey:@"name"],[model valueForKey:@"age"]);
    
    //检测是否设置了网络代理
    BOOL isSetProxy = [self hasSetProxy];
}


- (BOOL)hasSetProxy
{
    BOOL proxy = NO;
    
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSURL *url = [NSURL URLWithString:@"https://www.wanglibao.com"];
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef)(url),
                                                                       (__bridge CFDictionaryRef)(proxySettings)));
    NSLog(@"proxies:%@", proxies);
    NSDictionary *settings = proxies[0];
    NSLog(@"kCFProxyHostNameKey: %@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"kCFProxyPortNumberKey: %@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"kCFProxyTypeKey: %@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
        proxy = NO;
    }
    else {
        proxy = YES;
    }
    
    return proxy;
}

//测试JSPathc热修复
- (IBAction)crashAction:(id)sender {
    NSArray *array = @[@1,@2];
    NSNumber *number = [array objectAtIndex:4];
    NSLog(@"%@",number);
}

@end
