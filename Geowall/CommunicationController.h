//
//  CommunicationController.h
//  Geowall
//
//  Created by Vittorio Cuculo on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "User.h"
#import "Message.h"

@interface CommunicationController : NSObject

+(NSString*) loginWithUsername: (NSString*) user andPassword: (NSString*) pass;
+(NSString*) loginWithEmail: (NSString*) email andPassword: (NSString*) pass;
+(NSString*) registerWithUser: (User *) user;
+(NSMutableArray*) getNoticeboardWithPosX:(int) posx andPosY:(int) posy since:(NSString*) lastUpdate;
+(NSString*) insertMessage:(Message*) message atPosX:(int) posx andPosY:(int) posy;
@end
