//
//  ODAResultCell.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/21.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAResultCell.h"

@interface ODAResultCell()
@property (weak, nonatomic) IBOutlet UILabel *namelbl;
@property (weak, nonatomic) IBOutlet UILabel *valuelbl;
@end

@implementation ODAResultCell

- (void)setData:(NSDictionary *)data{
    _data = data;
    self.namelbl.text = data[@"name"];
    self.valuelbl.text = data[@"value"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
