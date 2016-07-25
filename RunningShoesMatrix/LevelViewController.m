//
//  LevelViewController.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "LevelViewController.h"

@interface LevelViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* levelsArr;
@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"level1"];
    self.levelsArr = [NSMutableArray new];
    
    NSInteger rowMin = [[ElementPositionManager shareManager] typesDicMinRow];
    NSInteger rowMax = [[ElementPositionManager shareManager] typesDicMaxRow];
    NSInteger row = rowMin;
    NSInteger col = 1;
    
    while (YES) {
        DHcell *cell = [[ReaderManager shareManager] cellInWorkSheetIndex:0 row:row col:col];
        if (cell.type == cellBlank) {
            row ++;
            continue;
        } else {
            row += cell.rowSpan;
        }
        [self.levelsArr addObject:cell];
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
    return self.levelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"level1"];
    DHcell *xlsCell = [self.levelsArr objectAtIndex:indexPath.row];
    cell.textLabel.text = xlsCell.str;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DHcell *xlsCell = [self.levelsArr objectAtIndex:indexPath.row];
    [ShoesModel shareInstance].isSelectedName = NO;
    [ShoesModel shareInstance].rowMin = xlsCell.row;
    [ShoesModel shareInstance].rowMax = xlsCell.row + xlsCell.rowSpan - 1;
    [ShoesModel shareInstance].level1Str = xlsCell.str;
    if (1 == xlsCell.colSpan) {
        [self performSegueWithIdentifier:@"showNextLevelViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"showNameViewController" sender:self];
    }
    
}

@end
