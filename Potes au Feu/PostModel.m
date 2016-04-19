//
//  PostModel.m
//  Potes au Feu
//
//  Created by Thomas Robin on 14/04/2016.
//  Copyright © 2016 Thomas Robin. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

+(JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"metadata": @"metadata", @"author.first_name": @"author", @"featured_image":@"featuredImage"}];
}

- (NSString *)coordinates {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    for (NSDictionary *metadata in _metadata) {
        if ([[metadata objectForKey:@"key"] isEqual: @"martygeocoderlatlng"]){
            string = [metadata objectForKey:@"value"];
        }
        
    }
    return string;
}

- (NSString *)subtitle {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    for (NSDictionary *metadata in _metadata) {
        if ([[metadata objectForKey:@"key"] isEqual: @"wps_subtitle"]){
            string = [metadata objectForKey:@"value"];
        }
        
    }
    return string;
}

- (NSString *)note {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    for (NSDictionary *metadata in _metadata) {
        if ([[metadata objectForKey:@"key"] isEqual: @"note"]){
            string = [metadata objectForKey:@"value"];
        }
        
    }
    return string;
}

- (NSString *)clearTitle {
    NSString *strToCorrect;
    
    static NSString * const codeMap[][2] = {
        {@"&iexcl;",    @"¡"},  {@"&laquo;",    @"«"},  {@"&raquo;",    @"»"},  {@"&lsaquo;",   @"‹"},
        {@"&rsaquo;",   @"›"},  {@"&sbquo;",    @"‚"},  {@"&bdquo;",    @"„"},  {@"&ldquo;",    @"“"},
        {@"&rdquo;",    @"”"},  {@"&lsquo;",    @"‘"},  {@"&rsquo;",    @"’"},  {@"&cent;",     @"¢"},
        {@"&pound;",    @"£"},  {@"&yen;",      @"¥"},  {@"&euro;",     @"€"},  {@"&curren;",   @"¤"},
        {@"&fnof;",     @"ƒ"},  {@"&gt;",       @">"},  {@"&lt;",       @"<"},  {@"&divide;",   @"÷"},
        {@"&deg;",      @"°"},  {@"&not;",      @"¬"},  {@"&plusmn;",   @"±"},  {@"&micro;",    @"µ"},
        {@"&amp;",      @"&"},  {@"&reg;",      @"®"},  {@"&copy;",     @"©"},  {@"&trade;",    @"™"},
        {@"&bull;",     @"•"},  {@"&middot;",   @"·"},  {@"&sect;",     @"§"},  {@"&ndash;",    @"–"},
        {@"&mdash;",    @"—"},  {@"&dagger;",   @"†"},  {@"&Dagger;",   @"‡"},  {@"&loz;",      @"◊"},
        {@"&uarr;",     @"↑"},  {@"&darr;",     @"↓"},  {@"&larr;",     @"←"},  {@"&rarr;",     @"→"},
        {@"&harr;",     @"↔"},  {@"&iquest;",   @"¿"},  {@"&nbsp;",     @" "},  {@"&quot;",     @"\""},
        {@"&rsquo;",   @"'"}
    };
    int count = sizeof(codeMap)/sizeof(codeMap[0]);
    for( int i=0; i<count; ++i ) {
        strToCorrect = [_title stringByReplacingOccurrencesOfString: codeMap[i][0]
                                                                withString: codeMap[i][1] ];
    }
    
    for( int i=33; i<126; ++i) {
        NSString* whotToReplace = [NSString stringWithFormat:@"&#%d;", i];
        NSString* replaceWith   = [NSString stringWithFormat:@"%c", (char*)i ];
        strToCorrect = [strToCorrect stringByReplacingOccurrencesOfString: whotToReplace
                                                               withString: replaceWith ];
    }
    return strToCorrect;
}

@end
