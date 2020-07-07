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
@interface homeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameCheckLabel;

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *currUser = PFUser.currentUser.username;
    self.usernameCheckLabel.text = [@"Welcome, " stringByAppendingFormat:@"%@", currUser];
    // Do any additional setup after loading the view.
    
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

@end
