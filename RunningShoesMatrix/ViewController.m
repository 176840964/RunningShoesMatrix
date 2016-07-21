//
//  ViewController.m
//  RunningShoesMatrix
//
//  Created by zxl on 16/7/21.
//  Copyright © 2016年 Xiaolong-Playing. All rights reserved.
//

#import "ViewController.h"
#import "../DHlibxls/DHxlsReader/DHxlsReader.h"

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
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"runningshoes.xls"];
    DHxlsReader *reader = [DHxlsReader xlsReaderWithPath:path];
    assert(reader);
    [reader startIterator:0];//参数是sheet编号
    int col = 3;
    while (YES) {
        DHcell *cell = [reader cellInWorkSheetIndex:0 row:2 col:col];
        if (cell.type == cellBlank) {
            break;
        }
        [self.brandArr addObject:cell.str];
        col ++;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brandArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    NSString *str = [self.brandArr objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
