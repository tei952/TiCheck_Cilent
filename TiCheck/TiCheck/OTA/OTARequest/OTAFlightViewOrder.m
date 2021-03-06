//
//  OTAFlightViewOrder.m
//  Test
//
//  Created by Boyi on 3/11/14.
//  Copyright (c) 2014 boyi. All rights reserved.
//

#import "OTAFlightViewOrder.h"
#import "ConfigurationHelper.h"

@implementation OTAFlightViewOrder

- (id)initWithUserUniqueUID:(NSString *)uniqueID
                 orderLists:(NSArray *)orders
{
    if (self = [super init]) {
        _uniqueUID = uniqueID;
        _orderIDs = orders;
    }
    
    return self;
}

- (NSString *)generateOTAFlightViewOrderXMLRequest
{
    NSString *header = [[ConfigurationHelper sharedConfigurationHelper] getHeaderStringWithRequestType:FlightViewOrderRequest];
    NSString *requestXML = [NSString stringWithFormat:
                            @"&lt;Request&gt;\n"
                            "%@"
                            "&lt;/Request&gt;", [header stringByAppendingString:[self generateViewOrderListRequestXML]]];
    
    return requestXML;
}

- (NSString *)generateViewOrderListRequestXML
{
    NSString *userID = _uniqueUID;
    
    // 初始化order列表
    NSString *orderIDs = @"";
    if (_orderIDs != nil && [_orderIDs count] != 0) {
        for (NSString *order in _orderIDs) {
            [orderIDs stringByAppendingFormat:@"&lt;int&gt;%@&lt;/int&gt;\n", order];
        }
    }
    NSString *orderIDList = [NSString stringWithFormat:
                             @"&lt;FltViewOrderRequest&gt;\n"
                             "&lt;UserID&gt;%@&lt;/UserID&gt;\n"
                             "&lt;OrderID&gt;\n"
                             "%@"
                             "&lt;/OrderID&gt;\n"
                             "&lt;/FltViewOrderRequest&gt;\n", userID, orderIDs];
    return orderIDList;
}

@end
