//
//  ViewController.m
//  NACommon
//
//  Created by ND on 15/11/19.
//  Copyright © 2015年 LJH. All rights reserved.
//

#import "ViewController.h"
#import "NATableView.h"
#import "NARefreshLoadTableView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,NARefreshLoadTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
    
    NARefreshLoadTableView *bv = [NATableView na_tableViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) useRefresh:YES useLoadMore:YES delegateAndDatasource:self];
    [self.view addSubview:bv];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 56)];
        v.backgroundColor = [UIColor redColor];
        return v;
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 56)];
    v.backgroundColor = [UIColor blueColor];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cel = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"24234dsfad"];
    cel.textLabel.text = [NSString stringWithFormat:@"%i",indexPath.row];
    return cel;
}

- (void)NAStartRefreshLoad:(UITableView *)tableview{
    [tableview performSelector:@selector(reloadData) withObject:nil afterDelay:3];

}
- (void)NAStartLoadMore:(UITableView *)tableview{}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
