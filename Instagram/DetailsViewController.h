//
//  DetailsViewController.h
//  Instagram
//
//  Created by gfloresv on 7/10/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
@protocol DetailsViewController
NS_ASSUME_NONNULL_BEGIN

@end
@interface DetailsViewController : UIViewController
@property (nonatomic, weak) id<DetailsViewController> delegate;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;

@property (nonatomic, strong)Post *post;
@end

NS_ASSUME_NONNULL_END
