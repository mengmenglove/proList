//
//  GFCalendarView.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarView.h"
#import "GFCalendarScrollView.h"
#import "NSDate+GFCalendar.h"

@interface GFCalendarView()

@property (nonatomic, strong) UIButton *calendarHeaderButton;
@property (nonatomic, strong) UIView *weekHeaderView;
@property (nonatomic, strong) GFCalendarScrollView *calendarScrollView;

@end


@implementation GFCalendarView


#pragma mark - Initialization

- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width {
    
    // 根据宽度计算 calender 主体部分的高度
    CGFloat weekLineHight = 0.85 * (width / 7.0);
    CGFloat monthHeight = 6 * weekLineHight;
    
    // 星期头部栏高度
    CGFloat weekHeaderHeight = 0.6 * weekLineHight;
    
    // calendar 头部栏高度
    CGFloat calendarHeaderHeight = 0.8 * weekLineHight;
    
    // 最后得到整个 calender 控件的高度
    _calendarHeight = calendarHeaderHeight + weekHeaderHeight + monthHeight;
    
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, _calendarHeight)]) {
        
        self.layer.masksToBounds = YES;
        self.layer.borderColor = kCalendarBasicColor.CGColor;
        self.layer.borderWidth = 2.0 / [UIScreen mainScreen].scale;
        self.layer.cornerRadius = 8.0;
        
        _calendarHeaderButton = [self setupCalendarHeaderButtonWithFrame:CGRectMake(0.0, 0.0, width, calendarHeaderHeight)];
        _weekHeaderView = [self setupWeekHeadViewWithFrame:CGRectMake(0.0, calendarHeaderHeight, width, weekHeaderHeight)];
        _calendarScrollView = [self setupCalendarScrollViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + weekHeaderHeight, width, monthHeight)];
        
        [self addSubview:_calendarHeaderButton];
        [self addSubview:_weekHeaderView];
        [self addSubview:_calendarScrollView];
        
        // 注册 Notification 监听
        [self addNotificationObserver];
        
    }
    
    return self;
    
}

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIButton *)setupCalendarHeaderButtonWithFrame:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
//    button.backgroundColor = kCalendarBasicColor;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button addTarget:self action:@selector(refreshToCurrentMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIView *)setupWeekHeadViewWithFrame:(CGRect)frame {
    
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width / 7.0;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = kCalendarBasicColor;
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < 7; ++i) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0.0, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = weekArray[i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13.5];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat separatorLineHeight = 1.0 / scale;
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, height - separatorLineHeight, frame.size.width, separatorLineHeight)];
    separatorLine.backgroundColor = kCalendarBasicColor;
    [view addSubview:separatorLine];
    
    return view;
    
}

- (GFCalendarScrollView *)setupCalendarScrollViewWithFrame:(CGRect)frame {
    GFCalendarScrollView *scrollView = [[GFCalendarScrollView alloc] initWithFrame:frame];
    return scrollView;
}

- (void)setDidSelectDayHandler:(DidSelectDayHandler)didSelectDayHandler {
    _didSelectDayHandler = didSelectDayHandler;
    if (_calendarScrollView != nil) {
        _calendarScrollView.didSelectDayHandler = _didSelectDayHandler; // 传递 block
    }
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"ChangeCalendarHeaderNotification" object:nil];
}


#pragma mark - Actions

- (void)refreshToCurrentMonthAction:(UIButton *)sender {
    
    NSInteger year = [[NSDate date] dateYear];
    NSInteger month = [[NSDate date] dateMonth];
    
    NSString *title = [NSString stringWithFormat:@"%ld年%ld月", year, month];
    
    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
    
    [_calendarScrollView refreshToCurrentMonth];
    
}

- (void)changeCalendarHeaderAction:(NSNotification *)sender {
    
    NSDictionary *dic = sender.userInfo;
    
    NSNumber *year = dic[@"year"];
    NSNumber *month = dic[@"month"];
    
    NSString *title = [NSString stringWithFormat:@"%@年%@月", year, month];
    
    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
}

@end
