//
//  PostCell.h
//  Instagram
//
//  Created by gfloresv on 7/9/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postPictureView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;

@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
