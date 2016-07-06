//
//  Site.m
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import "Site.h"

@implementation Site
@synthesize primaryLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = NSTextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:18];
        primaryLabel.textColor =[UIColor blackColor];
        primaryLabel.backgroundColor = [UIColor clearColor];
    
        [self.contentView addSubview:primaryLabel];
    }
    
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame;
    
    frame = CGRectMake(55, 5, 260, 20);
    primaryLabel.frame = frame;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
