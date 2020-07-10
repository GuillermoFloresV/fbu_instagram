//
//  homeViewController.m
//  Instagram
//
//  Created by gfloresv on 7/6/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "homeViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Post.h"
#import "PostCell.h"
@interface homeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usernameCheckLabel;
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;
@property (nonatomic, strong) NSMutableArray *postsArray;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.postsTableView.rowHeight = 500;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.postsTableView insertSubview:self.refreshControl atIndex:0];
    
    // Do any additional setup after loading the view.
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"caption"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.postsArray = (NSMutableArray *) posts;
            [self.postsTableView reloadData];
        }
        else {
            NSLog(@"Error loading timeline: %@", error.localizedDescription);
        }
    }];
    
}
- (void)beginRefresh:(UIRefreshControl *)refreshFeed {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"caption"];
    postQuery.limit = 20;
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.postsArray = (NSMutableArray *) posts;
            [self.postsTableView reloadData];
        }
        else {
            NSLog(@"Error loading timeline: %@", error.localizedDescription);
        }
        [self.postsTableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)logoutAction:(id)sender {
    NSLog(@"Attempting to logout user: %@", PFUser.currentUser.username);
    NSString *userLoggedOut = PFUser.currentUser.username;
    
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *LoginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = LoginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
            NSLog(@"User: %@ logged out successfully",userLoggedOut);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" ];
    Post *post = self.postsArray[indexPath.row];
    NSLog(@"%@",post.caption);
    postCell.post = post;
    
    postCell.userLabel.text = post.author.username;
    postCell.captionLabel.text = post.caption;
    
    
    //postCell.numLikesLabel.text = post.likeCount;
    postCell.photoImageView.file = post.image;
    [postCell.photoImageView loadInBackground];
    
    return postCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}


@end
