//
//  ReaderManager.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "ReaderManager.h"

@interface ReaderManager ()
@property (strong, nonatomic) DHxlsReader *reader;
@end

@implementation ReaderManager

+ (ReaderManager *)shareManager {
    static ReaderManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[ReaderManager alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"runningshoes.xls"];
        _reader = [DHxlsReader xlsReaderWithPath:path];
        assert(_reader);
    }
    
    return self;
}

- (void)startIteratorSheetNum:(uint32_t)num {
    [self.reader startIterator:num];
}

- (DHcell *)cellInWorkSheetIndex:(uint32_t)sheetNum row:(uint16_t)row col:(uint16_t)col {
    return [self.reader cellInWorkSheetIndex:sheetNum row:row col:col];
}

- (DHcell *)cellInWorkSheetIndex:(uint32_t)sheetNum row:(uint16_t)row colStr:(char *)col {
    return [self.reader cellInWorkSheetIndex:sheetNum row:row colStr:col];
}

@end
