//
//  SiteCell.h
//  W9Table2
//
//

#import <UIKit/UIKit.h>

@interface SiteCell : UITableViewCell
{
    UILabel *primaryLabel;
    UILabel *secondaryLabel;
    UIImageView *myImageView;
}

@property (nonatomic, strong) UILabel *primaryLabel;
@property (nonatomic, strong) UILabel *secondaryLabel;
@property (nonatomic, strong) UIImageView *myImageView;
@end
