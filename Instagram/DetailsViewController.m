//
//  DetailsViewController.m
//  Instagram
//
//  Created by gfloresv on 7/10/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
@import Parse;
@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.captionLabel.text = _post.caption;
    self.userLabel.text = _post.author.username;
    
    NSNumber *numLikes = self.post.likeCount;
    self.numLikesLabel.text = [numLikes stringValue];
    self.imageView.file =self.post.image;
    [self.imageView loadInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
