//
//  ShowsModel.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "ShoesModel.h"

@implementation ShoesModel

+ (ShoesModel *)shareInstance {
    static ShoesModel * s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[ShoesModel alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self clear];
    }
    return self;
}

- (void)clear {
    self.isSelectedName = YES;
    self.col = NSIntegerMin;
    self.rowMin = NSIntegerMin;
    self.rowMax = NSIntegerMax;
    self.brandStr = @"";
    self.nameStr = @"";
    self.level1Str = @"";
    self.level2Str = @"无";
}

@end
