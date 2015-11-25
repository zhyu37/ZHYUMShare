//
//  ZHYTableView.m
//  ZHYUMShare
//
//  Created by 张昊煜 on 15/11/23.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYTableView.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "UMSocialSnsService.h"

@interface ZHYTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ViewController *vc;

@end

@implementation ZHYTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ZHYTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //UMShare
        if ([self.zhyDelegate respondsToSelector:@selector(ZHYTableViewFirstRow:)]) {
            [self.zhyDelegate ZHYTableViewFirstRow:self];
        }
        
    } else {
        //系统自带
        if ([self.zhyDelegate respondsToSelector:@selector(ZHYTableViewSecondRow:)]) {
            [self.zhyDelegate ZHYTableViewSecondRow:self];
        }
    }
}

#pragma mark - setter

- (void)setArray:(NSMutableArray *)array
{
    _array = array;
    [self reloadData];
}

@end
