//
//  composeViewController.m
//  Instagram
//
//  Created by gfloresv on 7/8/20.
//  Copyright © 2020 gfloresv. All rights reserved.
//

#import "composeViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
@interface composeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@end

@implementation composeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.captionTextView.text = @"Type your caption here";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePictureAction:(id)sender {
        UIImagePickerController *imagePickerVC = [UIImagePickerController new];
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = YES;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;

        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            NSLog(@"Camera 🚫 available so we will use photo library instead");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        
        
    }
- (IBAction)choosePictureAction:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
        
        // Get the image captured by the UIImagePickerController
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        CGSize c=CGSizeMake(150, 150);
        [self resizeImage:editedImage withSize:(c)];
        // Do something with the images (based on your use case)
        [Post postUserImage:editedImage withCaption:@"Hello WOrld!" withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded)
            {
                NSLog(@"image successfully posted!");
            }
            else
            {
                NSLog(@"Error: %@", error.localizedDescription);
            }
        }];
        // Dismiss UIImagePickerController to go back to your original view controller
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    - (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
        UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
        resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
        resizeImageView.image = image;
        
        UIGraphicsBeginImageContext(size);
        [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }


@end
