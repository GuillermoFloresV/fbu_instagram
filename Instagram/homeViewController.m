//
//  homeViewController.m
//  Instagram
//
//  Created by gfloresv on 7/6/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "homeViewController.h"
#import <Parse/Parse.h>
@interface homeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameCheckLabel;

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *curr_user = PFUser.currentUser.username;
    self.usernameCheckLabel.text = curr_user;
    // Do any additional setup after loading the view.
    
}
- (IBAction)logoutAction:(id)sender {
    NSLog(@"Attempting to logout user: %@", PFUser.currentUser.username);
    NSString *userLoggedOut = PFUser.currentUser.username;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    [self performSegueWithIdentifier:@"goToLoginSegue" sender:self];
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
