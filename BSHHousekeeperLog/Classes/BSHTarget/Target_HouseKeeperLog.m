//
//  Target_HouseKeeperLog.m
//  BSHHousekeeperLog
//
//  Created by 符敏锋 on 2021/8/11.
//

#import "Target_HouseKeeperLog.h"
#import "BSHHouseKeeperLogVCViewController.h"
@implementation Target_HouseKeeperLog
- (id)Action_showHouseKeeperLog:(NSDictionary *)params
{
    BSHHouseKeeperLogVCViewController *HouseKeeperLogVC = [[BSHHouseKeeperLogVCViewController alloc] init];
    return HouseKeeperLogVC;
    return nil;
}

@end
