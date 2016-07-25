//
//  ElementPositionManager.h
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElementPositionManager : NSObject

+ (ElementPositionManager*)shareManager;

- (void)showPlistDic;
- (NSInteger)brandsDicRow;
- (NSInteger)brandsDicMinCol;
- (NSInteger)brandsDicMaxCol;

- (NSInteger)typesDicCol;
- (NSInteger)typesDicMinRow;
- (NSInteger)typesDicMaxRow;
@end
