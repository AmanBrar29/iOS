//
//  SiteCell.m
//  W9Table2
//

#import "SiteCell.h"

@implementation SiteCell
@synthesize primaryLabel, secondaryLabel, myImageView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //styling the primary label component
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = NSTextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:18];
        primaryLabel.textColor =[UIColor blackColor];
        primaryLabel.backgroundColor = [UIColor clearColor];
        //styling the secondary label component
        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = NSTextAlignmentLeft;
        secondaryLabel.font = [UIFont systemFontOfSize:10];
        secondaryLabel.textColor =[UIColor blueColor];
        secondaryLabel.backgroundColor = [UIColor clearColor];
        //instantiating an imageView
        myImageView = [[UIImageView alloc] init];
        //adding the new stylesd subviews to the contentView
        [self.contentView addSubview:myImageView];
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        
        
        
    }
    return self;
}
//method setting up the layout for the table cell
-(void)layoutSubviews
{
    [super layoutSubviews];
    //the below code sets the x,y and the w,h propertis of all the components below
    CGRect frame;
    
    frame = CGRectMake(5, 5, 40, 40);
    myImageView.frame = frame;
    
    frame = CGRectMake(55, 20, 260, 20);
    primaryLabel.frame = frame;
    
    frame = CGRectMake(55, 30, 260, 12);
    secondaryLabel.frame = frame;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end





