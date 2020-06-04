//
//  ODAEventDetailCell.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/21.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAEventDetailCell.h"

@interface ODAEventDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *propertNamelbl;
@property (weak, nonatomic) IBOutlet UILabel *propertyDesc;
@property (weak, nonatomic) IBOutlet UILabel *isWritelbl;
@property (weak, nonatomic) IBOutlet UILabel *dataTypelbl;
@end

@implementation ODAEventDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.propertNamelbl.text = dataDic[@"name"];
    self.propertyDesc.text = dataDic[@"desc"];
    self.isWritelbl.text = dataDic[@"wirte"];
    self.dataTypelbl.text = dataDic[@"dataType"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
