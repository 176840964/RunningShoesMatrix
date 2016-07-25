//
//  NameViewController.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *namesArr;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"name"];
    self.namesArr = [NSMutableArray new];
    
    NSInteger rowMin = [ShoesModel shareInstance].rowMin;
    NSInteger rowMax = [ShoesModel shareInstance].rowMax;
    NSInteger row = rowMin;
    NSInteger col = [ShoesModel shareInstance].col;
    if ([ShoesModel shareInstance].isSelectedName) {
        rowMin = [[ElementPositionManager shareManager] typesDicMinRow];
        rowMax = [[ElementPositionManager shareManager] typesDicMaxRow];
        row = rowMin;
        col = [ShoesModel shareInstance].col;
    }
    
    
    while (YES) {
        DHcell *cell = [[ReaderManager shareManager] cellInWorkSheetIndex:0 row:row col:col];
        if (cell.type == cellBlank) {
            row ++;
        } else {
            [self.namesArr addObject:cell];
            row += cell.rowSpan;
        }
        if (row > rowMax) {
            break;
        }
    }
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.namesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"name"];
    DHcell *xlsCell = [self.namesArr objectAtIndex:indexPath.row];
    cell.textLabel.text = xlsCell.str;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DHcell *xlsCell = [self.namesArr objectAtIndex:indexPath.row];
    [ShoesModel shareInstance].nameStr = xlsCell.str;
    if ([ShoesModel shareInstance].isSelectedName) {
        [ShoesModel shareInstance].rowMax = xlsCell.row;
    }
    [self performSegueWithIdentifier:@"ShowDetailViewController" sender:self];
}

@end
