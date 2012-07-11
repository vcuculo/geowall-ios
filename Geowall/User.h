//
//  User.h
//  Geowall
//
//  Created by Vittorio Cuculo on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSString *username;
    NSString *email;
    NSString *pass;
    NSString *avatar;
    NSString *city;
    NSString *country;
    NSString *birthday;
}

-(User*) initWithUsername: (NSString*) username email: (NSString*) email password: (NSString*) pass avatar: (NSString*) avatar city:(NSString*) city country:(NSString*) country birthday:(NSString*) birthday;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *pass;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *birthday;

@end
