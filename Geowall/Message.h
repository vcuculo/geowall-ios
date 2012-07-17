//
//  Noticeboard.h
//  Geowall
//
//  Created by Vittorio Cuculo on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject{
    NSInteger idM;
    NSString *testo;
    NSString *nick;
    NSString *data;
    NSString *image;
    NSString *video;
}

-(Message*) initWithId: (NSInteger) idMess text: (NSString*) testoMess nick: (NSString*) nickMess data: (NSString*) dataMess image:(NSString*) imageMess video:(NSString*) videoMess;
-(Message*) initWithText: (NSString*) testoMess image:(NSString*) imageMess video:(NSString*) videoMess;

@property (nonatomic) NSInteger idM;
@property (nonatomic, retain) NSString *testo;
@property (nonatomic, retain) NSString *nick;
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *video;

@end
