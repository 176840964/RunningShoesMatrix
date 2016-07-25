//
//  ViewController.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/21.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *brandArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    _brandArr = [[NSMutableArray alloc] init];
    [self getBrandsDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)getBrandsDate {
//    DHcell *cell = [[ReaderManager shareManager] cellInWorkSheetIndex:0 row:3 col:1];
//    NSLog(@"info:%@", [cell dump]);
    
    NSInteger col = [[ElementPositionManager shareManager] brandsDicMinCol];
    while (YES) {
        DHcell *cell = [[ReaderManager shareManager] cellInWorkSheetIndex:0 row:2 col:col];
        if (cell.type == cellBlank) {
            break;
        }
        [self.brandArr addObject:cell];
        col ++;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brandArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    DHcell *xlsCell = [self.brandArr objectAtIndex:indexPath.row];
    cell.textLabel.text = xlsCell.str;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DHcell *xlsCell = [self.brandArr objectAtIndex:indexPath.row];
    
    [[ShoesModel shareInstance] clear];
    [ShoesModel shareInstance].col = xlsCell.col;
    [ShoesModel shareInstance].brandStr = xlsCell.str;
    
    [self performSegueWithIdentifier:@"ShowSelectViewController" sender:self];
}

@end
