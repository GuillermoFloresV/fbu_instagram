//
//  PostCell.m
//  Instagram
//
//  Created by gfloresv on 7/9/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "PostCell.h"
#import <Parse/Parse.h>
#import "Post.h"
@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}
@end
