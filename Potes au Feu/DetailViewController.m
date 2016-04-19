//
//  DetailViewController.m
//  Potes au Feu
//
//  Created by Thomas Robin on 07/04/2016.
//  Copyright © 2016 Thomas Robin. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-paf.png"]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Infos" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [_featuredImageView sd_setImageWithURL:[NSURL URLWithString:_post.featuredImage]
                          placeholderImage:[UIImage imageNamed:@"logo_rond.png"]];
    _featuredImageView.contentMode = UIViewContentModeScaleAspectFill;
    _featuredImageView.clipsToBounds = YES;
    
    _postTitle.text           = [_post.clearTitle uppercaseString];
    _postSubtitle.text        = _post.subtitle;
    _postAuthorAndDAte.text   = [NSString stringWithFormat:@"Ecris par %@", _post.author];
    
    NSString *head = @"<html><head><style>body { font-family: 'Josefin Slab';font-size:18.5px;line-height: 22px;text-align: justify; }</style></head><body>";
    NSString *end = @"</body>";
    NSString *html = [NSString stringWithFormat:@"%@%@%@", head, _post.content, end];
    
    [_postContent loadHTMLString:html baseURL:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *cssString = @"body { font-family: 'Josefin Slab'; font-size: 24px }"; // 1
    NSString *javascriptString = @"var style = document.createElement('style'); style.innerHTML = '%@'; document.head.appendChild(style)"; // 2
    NSString *javascriptWithCSSString = [NSString stringWithFormat:javascriptString, cssString]; // 3
    [webView stringByEvaluatingJavaScriptFromString:javascriptWithCSSString]; // 4
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
