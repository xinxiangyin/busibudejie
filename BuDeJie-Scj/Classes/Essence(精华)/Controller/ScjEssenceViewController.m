//
//  ScjEssenceViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/7/14.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjEssenceViewController.h"
#import "UIBarButtonItem+Scj__item.h"
#import "UIView+ScjFrame.h"
#import "ScjTitleBtn.h"
#import "ScjConst.h"
#import "ScjAllViewController.h"
#import "ScjVideoViewController.h"
#import "ScjVoiceViewController.h"
#import "ScjPictureViewController.h"
#import "ScjWordViewController.h"

@interface ScjEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *titlesView;

@property (nonatomic, weak) UIView *titleUnderline;

@property (nonatomic, weak) ScjTitleBtn *preClickedTitleBtn;

@property (nonatomic, weak) UIScrollView *preIsScrollToTopView;

@end

@implementation ScjEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
    
    [self setupChildVC];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    [self addChildVCViewIntoScrollV];
    
}

#pragma mark - 初始化

- (void)setupNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"]  addTarget:self action:@selector(game)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:nil action:nil];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

- (void)setupChildVC{
    [self addChildViewController:[[ScjAllViewController alloc] init]];
    
    [self addChildViewController:[[ScjVideoViewController alloc] init]];
    
    [self addChildViewController:[[ScjVoiceViewController alloc] init]];
    
    [self addChildViewController:[[ScjPictureViewController alloc] init]];
    
    [self addChildViewController:[[ScjWordViewController alloc] init]];
     
}

- (void)setupScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
    self.scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.scj_width;
//    CGFloat scrollViewH = scrollView.scj_height;
//    
//    for (NSUInteger i = 0; i < count; i ++) {
//        UIView *childV = self.childViewControllers[i].view;
//        childV.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        [scrollView addSubview:childV];
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
    UIViewController *childVC = self.childViewControllers.firstObject;
    UIScrollView *scrollToTopV = (UIScrollView *)childVC.view;
    scrollToTopV.scrollsToTop = YES;
    self.preIsScrollToTopView = scrollToTopV;
}

- (void)setupTitlesView{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, ScjNavMaxY, self.view.scj_width, ScjTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
    
    
}

- (void)setupTitleButtons{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.scj_width / count;
    CGFloat titleButtonH = self.titlesView.scj_height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        ScjTitleBtn *titleButton = [[ScjTitleBtn alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

- (void)setupTitleUnderline{
    // 标题按钮
    ScjTitleBtn *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.scj_height = 2;
    titleUnderline.scj_y = self.titlesView.scj_height - titleUnderline.scj_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.preClickedTitleBtn = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.scj_width = firstTitleButton.titleLabel.scj_width + 10;
    self.titleUnderline.scj_centerX = firstTitleButton.scj_centerX;
}




#pragma mark - 监听
- (void)game{
    
}

- (void)titleButtonClick:(ScjTitleBtn *)titleButton{
    
    if (self.preClickedTitleBtn == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ScjTitleButtonDidRepeatClickNotification object:nil];
    }
    
    [self dealTitleButtonClick:titleButton];
}

- (void)dealTitleButtonClick:(ScjTitleBtn *)titleButton{
    // 切换按钮状态
    self.preClickedTitleBtn.selected = NO;
    titleButton.selected = YES;
    self.preClickedTitleBtn = titleButton;
    
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        //        XMGLog(@"%@", [titleButton titleForState:UIControlStateNormal])
        //        self.titleUnderline.xmg_width = [titleButton.currentTitle sizeWithFont:titleButton.titleLabel.font].width;
        
        //        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        //        attributes[NSFontAttributeName] = titleButton.titleLabel.font;
        //        self.titleUnderline.xmg_width = [titleButton.currentTitle sizeWithAttributes:attributes].width;
        
        self.titleUnderline.scj_width = titleButton.titleLabel.scj_width + 10;
        self.titleUnderline.scj_centerX = titleButton.scj_centerX;
        
        CGFloat offsetX = self.scrollView.scj_width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVCViewIntoScrollV];
    }];
    UIViewController *childVC = self.childViewControllers[index];
    UIScrollView *scrollV = (UIScrollView *)childVC.view;
    if (scrollV.scrollsToTop == NO) {
        self.preIsScrollToTopView.scrollsToTop = NO;
        scrollV.scrollsToTop = YES;
        self.preIsScrollToTopView = scrollV;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger i = scrollView.contentOffset.x / scrollView.scj_width;
    ScjTitleBtn *titleButton = self.titlesView.subviews[i];
    [self titleButtonClick:titleButton];
}

#pragma mark - 其他

- (void)addChildVCViewIntoScrollV{
    CGFloat scrollViewW = self.scrollView.scj_width;
    NSUInteger i = self.scrollView.contentOffset.x / scrollViewW;
    UIView *childVCView = self.childViewControllers[i].view;
    childVCView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVCView];
    
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

@end
