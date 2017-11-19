//
//  ScjTopicTableViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/5.
//  Copyright © 2017年 施仓健. Topic rights reserved.
//

#import "ScjTopicTableViewController.h"
#import "ScjTopic.h"
#import "ScjTopicCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface ScjTopicTableViewController ()

/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, strong) NSMutableArray<ScjTopic *> *topics;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

//头部下拉
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@property (nonatomic, weak) UIView *header;

@property (nonatomic, weak) UILabel *headerL;

//尾部上拉
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

@property (nonatomic, weak) UIView *footer;

@property (nonatomic, weak) UILabel *footerL;

// 有了方法声明，点语法才会有智能提示
//- (ScjTopicType)type;
@end

static NSString * const ScjTopicCellID = @"ScjTopicCellID";

@implementation ScjTopicTableViewController

- (ScjTopicType)type{ return 0; };

- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ScjColor(206, 206, 206);
    
    self.tableView.contentInset = UIEdgeInsetsMake(ScjNavMaxY + ScjTitlesViewH, 0, ScjTabBarH, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.scrollsToTop = NO;
    
    //    self.tableView.rowHeight = 200;
    //    self.tableView.estimatedRowHeight = 200;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ScjTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:ScjTopicCellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnRepeatClick) name:ScjTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleViewBtnRepeatClick) name:ScjTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupRefresh{
    
    // 广告条
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.textColor = [UIColor whiteColor];
    label.text = @"广告";
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    
    //头部下拉
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, - 50, self.tableView.scj_width, 50);
    self.header = header;
    [self.tableView addSubview:header];
    
    UILabel *headerL = [[UILabel alloc] init];
    headerL.frame = header.bounds;
    headerL.backgroundColor = [UIColor redColor];
    headerL.text = @"下拉可以刷新";
    headerL.textColor = [UIColor whiteColor];
    headerL.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headerL];
    self.headerL = headerL;
    
    
    [self headerBeginRefreshing];
    
    //尾部上拉
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.scj_width, 35);
    self.footer = footer;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    self.footerL = footerLabel;
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - 监听

- (void)tabBarBtnRepeatClick{
    
    if (self.view.window == nil) return;
    
    if (self.tableView.scrollsToTop == NO) return;
    
    //    ScjLog(@"%@ - 刷新数据", self.class)
    
    [self headerBeginRefreshing];
    
}

- (void)titleViewBtnRepeatClick{
    
    [self tabBarBtnRepeatClick];
    
}

#pragma mark - 数据处理

- (void)loadNewData{
    
    //    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type); // 这里发送@1或者字符串也是可行的/** 帖子的类型 1为全部 10为图片 29为段子 31为音频 41为视频 */
    
    [self.manager GET:ScjCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //        [responseObject writeToFile:@"/Users/shicangjian/Desktop/OC项目/topics1.plist" atomicTopicy:YES];
        self.topics = [ScjTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /*
         取消任务
         Error Domain=NSURLErrorDomain Code=-999 "cancelled" UserInfo={NSErrorFailingURLKey=http://api.budejie.com/api/api_open.php?a=list&c=data&mintime=5345345&type=31, NSLocalizedDescription=cancelled, NSErrorFailingURLStringKey=http://api.budejie.com/api/api_open.php?a=list&c=data&mintime=5345345&type=31}
         
         请求路径有问题（找不到对应的服务器）
         Error Domain=NSURLErrorDomain Code=-1003 "A server with the specified hostname could not be found." UserInfo={NSUnderlyingError=0x7fbc71fd02a0 {Error Domain=kCFErrorDomainCFNetwork Code=-1003 "(null)" UserInfo={_kCFStreamErrorCodeKey=8, _kCFStreamErrorDomainKey=12}}, NSErrorFailingURLStringKey=http://api.budejie.c/?a=list&c=data&mintime=5345345&type=31, NSErrorFailingURLKey=http://api.budejie.c/?a=list&c=data&mintime=5345345&type=31, _kCFStreamErrorDomainKey=12, _kCFStreamErrorCodeKey=8, NSLocalizedDescription=A server with the specified hostname could not be found.}
         */
        if (error.code != NSURLErrorCancelled) {
            
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        }
        
        [self headerEndRefreshing];
        
    }];
    
    //    ScjLog(@"发送请求给服务器 - 刷新数据")
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 服务器请求回来了
    //        self.datacount = 20;
    //        [self.tableView reloadData];
    //
    //        [self headerEndRefreshing];
    //    });
}

- (void)loadMoreData{
    
    //    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type); // 这里发送@1也是可行的
    parameters[@"maxtime"] = self.maxtime;
    
    [self.manager GET:ScjCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //        [responseObject writeToFile:@"/Users/shicangjian/Desktop/OC项目" atomicTopicy:YES];
        NSArray *topicArr = [ScjTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //把数组中的内容累加到已有数组后面
        [self.topics addObjectsFromArray:topicArr];
        
        [self.tableView reloadData];
        
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {
            
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        }
        
        [self footerEndRefreshing];
        
    }];
    
    //    ScjLog(@"发送请求给服务器 - 加载更多数据")
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 服务器请求回来了
    //        self.datacount += 5;
    //        [self.tableView reloadData];
    //
    //        [self footerEndRefreshing];
    //    });
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *ID = @"cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    //        cell.backgroundColor = [UIColor clearColor];
    //    }
    //    ScjTopic *topic = self.topics[indexPath.row];
    //    cell.detailTextLabel.text = topic.text;
    //    cell.textLabel.text = topic.name;
    
    // control + command + 空格 -> 弹出emoji表情键盘
    //    cell.textLabel.text = @"⚠️哈哈";
    
    ScjTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ScjTopicCellID forIndexPath:indexPath];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理
// 所有cell的高度 -> contentSize.height -> 滚动条长度
// 1000 * 20 -> contentSize.height -> 滚动条长度
// contentSize.height -> 200 * 20 -> 16800
/*
 使用estimatedRowHeight的优缺点
 1.优点
 1> 可以降低tableView:heightForRowAtIndexPath:方法的调用频率
 2> 将【计算cell高度的操作】延迟执行了（相当于cell高度的计算是懒加载的）
 
 2.缺点
 1> 滚动条长度不准确、不稳定，甚至有卡顿效果（如果不使用estimatedRowHeight，滚动条的长度就是准确的）
 */

/**
 这个方法的特点：
 1.默认情况下(没有设置estimatedRowHeight的情况下)
 1> 每次刷新表格时，有多少数据，这个方法就一次性调用多少次（比如有100条数据，每次reloadData时，这个方法就会一次性调用100次）
 2> 每当有cell进入屏幕范围内，就会调用一次这个方法
 
 2.设置estimatedRowHeight的情况下
 1> 用到了（显示了）哪个cell，才会调用这个方法计算那个cell的高度（方法调用频率降低了）
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.topics[indexPath.row].cellHeight;
}

//结束拖拽，松开手指
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.scj_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        [self headerBeginRefreshing];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self dealHeader];
    
    [self dealFooter];
    
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 设置缓存时长为1个月
    //    [SDImageCache sharedImageCache].maxCacheAge = 30 * 24 * 60 * 60;
    
    // 清除沙盒中所有使用SD缓存的过期图片（缓存时长 > 一个星期）
    //    [[SDImageCache sharedImageCache] cleanDisk];
    
    // 清除沙盒中所有使用SD缓存的图片
    //    [[SDImageCache sharedImageCache] clearDisk];
    
}

- (void)dealHeader{
    if (self.isHeaderRefreshing) return;
    
    // 当scrollView的偏移量y值 <= offsetY时，代表header已经完全出现
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.scj_height);
    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
        self.headerL.text = @"松开立即刷新";
        self.headerL.backgroundColor = [UIColor grayColor];
    } else {
        self.headerL.text = @"下拉可以刷新";
        self.headerL.backgroundColor = [UIColor redColor];
    }
    
}

- (void)dealFooter{
    if (self.tableView.contentSize.height == 0) return;
    if (self.isFooterRefreshing) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.scj_height;
    
    if (self.tableView.contentOffset.y >= offsetY
        && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        
        [self footerBeginRefreshing];
    }
}

#pragma mark - header

- (void)headerBeginRefreshing{
    if (self.isHeaderRefreshing) return;
    
    self.headerRefreshing = YES;
    self.headerL.text = @"正在刷新数据...";
    self.headerL.backgroundColor = [UIColor blueColor];
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        
        inset.top += self.header.scj_height;
        
        self.tableView.contentInset = inset;
        
        //注意，改变conten位置，修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - (inset.top));
    }];
    
    [self loadNewData];
}


- (void)headerEndRefreshing{
    // 结束刷新
    self.headerRefreshing = NO;
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.scj_height;
        self.tableView.contentInset = inset;
        
    }];
}

#pragma mark - footer

- (void)footerBeginRefreshing{
    
    if (self.isFooterRefreshing) return;
    
    self.footerRefreshing = YES;
    self.footerL.text = @"正在加载更多数据...";
    self.footerL.backgroundColor = [UIColor blueColor];
    
    [self loadMoreData];
}


- (void)footerEndRefreshing{
    // 结束刷新
    self.footerRefreshing = NO;
    self.footerL.text = @"上拉可以加载更多";
    self.footerL.backgroundColor = [UIColor redColor];
    
}






@end
