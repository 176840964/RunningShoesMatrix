//
//  DetailViewController.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property(weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *brandLab;
@property (weak, nonatomic) IBOutlet UILabel *level1Lab;
@property (weak, nonatomic) IBOutlet UILabel *level2Lab;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([ShoesModel shareInstance].isSelectedName) {
        NSInteger rowMin = [[ElementPositionManager shareManager] typesDicMinRow];
        NSInteger rowMax = [ShoesModel shareInstance].rowMax;
        NSInteger row = rowMax;
        NSInteger col = 1;
        
        BOOL isHasNextLevel = YES;
        
        for (NSInteger index = 0; index < 2; index++) {//第一次找一级分类，第二次找二级分类
            row = rowMax;
            col = index + 1;
            while (YES) {
                DHcell *cell = [[ReaderManager shareManager] cellInWorkSheetIndex:0 row:row col:col];
                if (cell.type == cellBlank) {
                    row --;
                } else {
                    if (index == 0) {
                        [ShoesModel shareInstance].level1Str = cell.str;
                        isHasNextLevel = cell.colSpan == 1;
                    } else {
                        [ShoesModel shareInstance].level2Str = cell.str;
                    }
                    break;
                }
                if (row < rowMin) {
                    break;
                }
            }
            if (!isHasNextLevel) {
                [ShoesModel shareInstance].level2Str = @"无";
                break;
            }
        }
    }
    
    self.nameLab.text = [ShoesModel shareInstance].nameStr;
    self.brandLab.text = [NSString stringWithFormat:@"品牌：%@", [ShoesModel shareInstance].brandStr];
    self.level1Lab.text = [NSString stringWithFormat:@"第一级别：%@", [ShoesModel shareInstance].level1Str];
    self.level2Lab.text = [NSString stringWithFormat:@"第二级别：%@", [ShoesModel shareInstance].level2Str];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTapDone:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
