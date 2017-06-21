//
//  SearchResultController.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/17.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "SearchResultController.h"
#import "UITableView+ZJRegisterCellExtension.h"
#import "NSString+AutoCountLabelSize.h"
@interface SearchResultController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tableFooterView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    //[tableView registerCellWithCellClassNameArray:@[NSStringFromClass([UITableViewCell class])]];
    _tableView = tableView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_showType) {
        case SearchResultViewControllerTypeShowTips:
            return _tips.count;
            break;
        case SearchResultViewControllerTypeShowPOIInfo:
            return _poiSearchResults.count;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (_showType) {
        case SearchResultViewControllerTypeShowTips:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
            if (cell==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
            }
            cell.textLabel.text = _tips[indexPath.row].getName;
            cell.detailTextLabel.text = _tips[indexPath.row].getAddress;
            if (![_tips[indexPath.row].getPoiId isEmptyString]) {
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
            }
            else{
                cell.accessoryView = nil;
            }
            
            break;
        }
            
        case SearchResultViewControllerTypeShowPOIInfo:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
            if (cell==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
            }
            cell.textLabel.text = _poiSearchResults[indexPath.row].getName;
            cell.detailTextLabel.text = _poiSearchResults[indexPath.row].getAddress;
            if (![_poiSearchResults[indexPath.row].getPoiId isEmptyString]) {
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
            }
            else{
                cell.accessoryView = nil;
            }

            break;
        }
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (_showType) {
        case SearchResultViewControllerTypeShowTips:
        {
            id<ISearchTip>tip = _tips[indexPath.row];
            [_delegate searchResultController:self didSelectedSearchResult:tip showType:SearchResultViewControllerTypeShowTips];
            break;
        }
        case SearchResultViewControllerTypeShowPOIInfo:
        {
            id<IPOISearchResult>result = _poiSearchResults[indexPath.row];
            [_delegate searchResultController:self didSelectedSearchResult:result showType:SearchResultViewControllerTypeShowPOIInfo];
            break;
        }
            
        default:
            break;
    }
}

- (void)reloadData
{
    [_tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(searchResultControllerDidScroll:)]) {
        [_delegate searchResultControllerDidScroll:self];
    }
}

@end
