//
//  KVCModel.m
//  KVCDemo
//
//  Created by  wuhiwi on 16/11/28.
//  Copyright © 2016年 wanglibank.com. All rights reserved.
//

#import "KVCModel.h"

@interface KVCModel ()

//万能容器
@property (nonatomic, strong) NSMutableDictionary *containerDic;

@end

@implementation KVCModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!key || [key isEqualToString:@""]) {
        return;
    }
    if (!_containerDic) {
        _containerDic = [NSMutableDictionary dictionary];
    }
    [_containerDic setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    if (!key || [key isEqualToString:@""]) {
        return nil;
    }
    return [_containerDic valueForKey:key];
}


@end
