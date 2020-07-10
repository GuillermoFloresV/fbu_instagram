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
@property(strong, nonatomic) UIImage *editedImage;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end

@implementation composeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onTapDismiss:(id)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)postAction:(id)sender {
    NSString *captionText = self.captionTextView.text;
    
    if(captionText.length  ==0)
    {
        NSLog(@"Cannot have an empty caption. Posting failed");
    }
    else{
        [Post postUserImage:_editedImage withCaption:captionText withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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
        
    }
}

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
        self.editedImage = info[UIImagePickerControllerEditedImage];
        CGSize c=CGSizeMake(150, 150);
        [self resizeImage:self.editedImage withSize:(c)];
        self.previewImageView.image = [self resizeImage:_editedImage withSize:CGSizeMake(300,300)];

        // Do something with the images (based on your use case)
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
