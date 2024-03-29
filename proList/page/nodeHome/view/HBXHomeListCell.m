//
//  HBXHomeListCell.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXHomeListCell.h"

@interface HBXHomeListCell ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation HBXHomeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellHeightWithItem:(ZJHomdeListModel *)model {
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.image];
//    NSLog(@"model.content: %@  %@", model.image, image);
//    self.headView.image = image;
    [ToolHelper setImageWithImageView:self.headView url:model.image];
    self.contentLabel.text = model.title;
    self.dateLabel.text = model.date;
}

- (void)creatSubView {
    [self.contentView addSubview:self.container];
    
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.contentView);
    }];
    
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.headView];
    [self.container addSubview:self.dateLabel];
 
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.leading.equalTo(self.container).offset(15);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.container).offset(-10);
       make.leading.equalTo(self.headView.mas_trailing).offset(15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container).offset(10);
        make.leading.equalTo(self.headView.mas_trailing).offset(15);
    }];
    
    UIView *seplineView = [[UIView alloc] init];
    seplineView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [self.container addSubview:seplineView];
    [seplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.container);
        make.height.mas_equalTo(1);
    }];
    
}

    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
//        _headView.contentMode = UIViewContentModeScaleAspectFit;
        _headView.contentMode = UIViewContentModeScaleAspectFill;
        _headView.autoresizingMask = UIViewAutoresizingNone;
        _headView.layer.masksToBounds = YES;
    }
    return _headView;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:14.0];
        _dateLabel.textColor = UIColorFromRGB(0x999999);
    }
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.textColor = UIColorFromRGB(0x333333);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

@end
