//
//  PostModel.h
//  Potes au Feu
//
//  Created by Thomas Robin on 14/04/2016.
//  Copyright © 2016 Thomas Robin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PostModel : JSONModel

@property(assign, nonatomic) int ID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString<Optional> *featuredImage;
@property (strong, nonatomic) NSString<Optional> *coordinates;
@property (strong, nonatomic) NSString<Optional> *subtitle;
@property (strong, nonatomic) NSArray *metadata;

@property (strong, nonatomic) NSString<Optional> *clearTitle;

@end
