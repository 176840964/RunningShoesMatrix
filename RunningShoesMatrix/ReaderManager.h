//
//  ReaderManager.h
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../DHlibxls/DHxlsReader/DHxlsReader.h"

@interface ReaderManager : NSObject

+ (ReaderManager *)shareManager;

- (void)startIteratorSheetNum:(uint32_t)num;

- (DHcell *)cellInWorkSheetIndex:(uint32_t)sheetNum row:(uint16_t)row col:(uint16_t)col;
- (DHcell *)cellInWorkSheetIndex:(uint32_t)sheetNum row:(uint16_t)row colStr:(char *)col;
@end
