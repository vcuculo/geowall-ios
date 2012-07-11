//
//  CommunicationController.m
//  Geowall
//
//  Created by Vittorio Cuculo on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommunicationController.h"

static NSString *server = @"http://geo.wallo.be:8081/geowall";

@interface CommunicationController()
+ (NSMutableURLRequest*) prepareURL;
@end

@implementation CommunicationController

+ (NSMutableURLRequest*) prepareURLforAction: (NSString*) action{
    NSURL *serverURL = [NSURL URLWithString:[server stringByAppendingString: action]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:serverURL];
    [urlRequest setHTTPMethod: @"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setTimeoutInterval:10.0];
    return urlRequest;
}

+(NSString*)loginWithUsername:(NSString *)user andPassword:(NSString *)pass {
    NSMutableURLRequest *urlRequest = [self prepareURLforAction:@"/login"];
    
    NSString *jsonRequest;
    NSError *error;
    NSHTTPURLResponse *response;
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *command = [NSDictionary dictionaryWithObjectsAndKeys:user, @"nick", pass, @"pw",  nil];
    jsonRequest = [writer stringWithObject:command];
    [urlRequest setHTTPBody:[jsonRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSString *jsonResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *session = [parser objectWithString:jsonResponse error:nil];
    NSString* sid = [session objectForKey:@"sessionid"];
    
    if (sid == nil)
        return [@"error: " stringByAppendingString: jsonResponse];
    
    NSLog(@"sid - %@", sid);
    return sid;
}

+(NSString*) loginWithEmail:(NSString *)email andPassword:(NSString *)pass {
    NSMutableURLRequest *urlRequest = [self prepareURLforAction:@"/login"];
    
    NSString *jsonRequest;
    NSError *error;
    NSHTTPURLResponse *response;
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSDictionary *command = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", pass, @"pw",  nil];
    jsonRequest = [writer stringWithObject:command];
    [urlRequest setHTTPBody:[jsonRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSString *jsonResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *session = [parser objectWithString:jsonResponse error:nil];
    NSString* sid = [session objectForKey:@"sessionid"];
    
    if (sid == nil)
        return [@"error: " stringByAppendingString: jsonResponse];
    
    NSLog(@"sid - %@", sid);
    return sid;
}

+(NSString*) registerWithUser:(User *)user{
    NSMutableURLRequest *urlRequest = [self prepareURLforAction:@"/register"];
    
    NSString *jsonRequest;
    NSError *error;
    NSHTTPURLResponse *response;
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSDictionary *command = [NSDictionary dictionaryWithObjectsAndKeys:[user username], @"nick", [user pass], @"pw", [user email], @"email", [user avatar], @"image", [user birthday], @"date", [user country], @"country", [user city], @"city", nil];
    
    jsonRequest = [writer stringWithObject:command];
    
    NSLog(@"RegisterRequest - %@", jsonRequest);

    [urlRequest setHTTPBody:[jsonRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSString *jsonResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *session = [parser objectWithString:jsonResponse error:nil];
    NSString* sid = [session objectForKey:@"sessionid"];
    
    if (sid == nil)
        return [@"error: " stringByAppendingString: jsonResponse];
    
    NSLog(@"sid - %@", sid);
    return sid;
}

@end
