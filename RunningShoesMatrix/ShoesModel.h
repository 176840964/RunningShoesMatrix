//
//  ShowsModel.h
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoesModel : NSObject
@property (assign, nonatomic) NSInteger col;
@property (assign, nonatomic) NSInteger rowMin;
@property (assign, nonatomic) NSInteger rowMax;
@property (strong, nonatomic) NSString *brandStr;
@property (strong, nonatomic) NSString *nameStr;
@property (strong, nonatomic) NSString *level1Str;
@property (strong, nonatomic) NSString *level2Str;
@property (assign, nonatomic) BOOL isSelectedName;

+ (ShoesModel *)shareInstance;

- (void)clear;
@end
