//
//  FirstViewController.m
//  Potes au Feu
//
//  Created by Thomas Robin on 06/04/2016.
//  Copyright © 2016 Thomas Robin. All rights reserved.
//
#import "DetailViewController.h"
#import "FirstViewController.h"
#import "JSONModelLib.h"


@interface FirstViewController () <MGLMapViewDelegate>

@property int post_id;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-paf.png"]];
    [self.mapBox setUserTrackingMode:MGLUserTrackingModeFollow];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadPosts];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPosts {
    [JSONHTTPClient setCachingPolicy:NSURLRequestReturnCacheDataElseLoad];
    
    [JSONHTTPClient getJSONFromURLWithString:@"https://public-api.wordpress.com/rest/v1.1/sites/www.potesaufeu.com/posts/"
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      //got JSON back
                                      NSError *error = nil;
                                      NSArray* models = [PostModel arrayOfModelsFromDictionaries: [json objectForKey:@"posts"] error:&error];
                                      
                                      if ([models count] > 0){
                                          _posts = models;
                                          [self loadMapWithPosts:models];
                                      }
                                      
                                  }];

    
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id<MGLAnnotation>)annotation {
    return true;
}

- (void)loadMapWithPosts:(NSArray *)posts {
    for (PostModel *post in posts){
       MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
        NSString *finalStr = [[[post coordinates] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSArray *stringArray = [finalStr componentsSeparatedByString: @","];
        double lat = [[stringArray objectAtIndex:0] doubleValue];
        double lng = [[stringArray objectAtIndex:1] doubleValue];
        point.coordinate = CLLocationCoordinate2DMake(lat, lng);
        
        point.title = [post clearTitle];
        point.subtitle = [post subtitle];
        
        [self.mapBox addAnnotation:point];
        [self.mapBox selectAnnotation:point animated:YES];
    }
}

- (UIView *)mapView:(MGLMapView *)mapView rightCalloutAccessoryViewForAnnotation:(id<MGLAnnotation>)annotation
{
    return [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}

- (void)mapView:(MGLMapView *)mapView annotation:(id<MGLAnnotation>)annotation calloutAccessoryControlTapped:(UIControl *)control {
    int i = 0;
    
    for (PostModel *post in _posts){
        if (([post.clearTitle isEqualToString:[annotation title]])){
            _post_id = i;
            break;
        }
        i++;
    }
    
    [self.mapBox deselectAnnotation:annotation animated:NO];
    [self performSegueWithIdentifier:@"pushDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"pushDetail"]) {
        DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
        controller.post = [_posts objectAtIndex:_post_id];
    }
}

@end
