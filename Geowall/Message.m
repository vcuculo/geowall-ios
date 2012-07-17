//
//  Noticeboard.m
//  Geowall
//
//  Created by Vittorio Cuculo on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize idM, testo, nick, data, image, video;

-(Message*) initWithId: (NSInteger) idMess text: (NSString*) testoMess nick: (NSString*) nickMess data: (NSString*) dataMess image:(NSString*) imageMess video:(NSString*) videoMess{
    
    self = [super init];
    idM = idMess;
    testo = testoMess;
    nick = nickMess;
    data = dataMess;
    image = imageMess;
    video = videoMess;
    return self;
}

-(Message*) initWithText: (NSString*) testoMess image:(NSString*) imageMess video:(NSString*) videoMess{
    
    self = [super init];
    testo = testoMess;
    image = imageMess;
    video = videoMess;
    return self;
}

@end
