//
//  NextLevelViewController.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/25.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "NextLevelViewController.h"

@interface NextLevelViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *levelsArr;
@end

@implementation NextLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"level2"];
    self.levelsArr = [NSMutableArray new];
    
    NSInteger rowMin = [ShoesModel shareInstance].rowMin;
    NSInteger rowMax = [ShoesModel shareInstance].rowMax;
    NSInteger row = rowMin;
    NSInteger col = 2;
    
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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"level2"];
    DHcell *xlsCell = [self.levelsArr objectAtIndex:indexPath.row];
    cell.textLabel.text = xlsCell.str;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DHcell *xlsCell = [self.levelsArr objectAtIndex:indexPath.row];
    [ShoesModel shareInstance].rowMin = xlsCell.row;
    [ShoesModel shareInstance].rowMax = xlsCell.row + xlsCell.rowSpan - 1;
    [ShoesModel shareInstance].level2Str = xlsCell.str;
    [self performSegueWithIdentifier:@"showNameViewController" sender:self];
}

@end
