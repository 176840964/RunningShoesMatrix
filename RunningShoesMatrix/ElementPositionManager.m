//
//  ElementPositionManager.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "ElementPositionManager.h"

@interface ElementPositionManager ()
@property (strong, nonatomic) NSDictionary *plistDic;

@end

@implementation ElementPositionManager

+ (ElementPositionManager*)shareManager {
    static ElementPositionManager *s_instanse = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instanse = [[ElementPositionManager alloc] init];
        
        NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ElementPosition.plist"];
        s_instanse.plistDic = [NSDictionary dictionaryWithContentsOfFile:path];
    });
    
    return s_instanse;
}

- (void)showPlistDic {
    NSLog(@"plistDic:%@", self.plistDic);
}

- (NSInteger)brandsDicRow {
    return [[[[self.plistDic objectForKey:@"brandsDic"] objectForKey:@"row"] objectForKey:@"min"] integerValue];
}

- (NSInteger)brandsDicMinCol {
    return [[[[self.plistDic objectForKey:@"brandsDic"] objectForKey:@"col"] objectForKey:@"min"] integerValue];
}

- (NSInteger)brandsDicMaxCol {
    return [[[[self.plistDic objectForKey:@"brandsDic"] objectForKey:@"col"] objectForKey:@"max"] integerValue];
}

- (NSInteger)typesDicCol {
    return [[[[self.plistDic objectForKey:@"typesDic"] objectForKey:@"col"] objectForKey:@"min"] integerValue];
}

- (NSInteger)typesDicMinRow {
    return [[[[self.plistDic objectForKey:@"typesDic"] objectForKey:@"row"] objectForKey:@"min"] integerValue];
}

- (NSInteger)typesDicMaxRow {
    return [[[[self.plistDic objectForKey:@"typesDic"] objectForKey:@"row"] objectForKey:@"max"] integerValue];
}

@end
