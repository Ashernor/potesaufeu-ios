//
//  DetailViewController.h
//  Potes au Feu
//
//  Created by Thomas Robin on 07/04/2016.
//  Copyright © 2016 Thomas Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) PostModel *post;
@property (weak, nonatomic) IBOutlet UIWebView *postContent;
@property (weak, nonatomic) IBOutlet UIImageView *featuredImageView;
@property (weak, nonatomic) IBOutlet UILabel *postTitle;
@property (weak, nonatomic) IBOutlet UILabel *postSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *postAuthorAndDAte;


@end
