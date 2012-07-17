//
//  User.m
//  Geowall
//
//  Created by Vittorio Cuculo on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username, email, pass, avatar, birthday, city, country;

-(User*) initWithUsername: (NSString*) mUsername email: (NSString*) mEmail password: (NSString*) mPass avatar: (NSString*) mAvatar city:(NSString*) mCity country:(NSString*) mCountry birthday:(NSString*) mBirthday
{
    self = [super init];
    username = mUsername;
    email = mEmail;
    pass = mPass;
    avatar = mAvatar;
    city = mCity;
    country = mCountry;
    birthday = mBirthday;
    return self;
}

@end
