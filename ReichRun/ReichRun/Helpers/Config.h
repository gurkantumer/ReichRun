//
//  Config.h
//  ReichRun
//
//  Created by Gurkan Tumer on 29/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#ifndef ReichRun_Config_h
#define ReichRun_Config_h

#define kTOGGLE_DEBUG YES
#define kTOGGLE_FULLSCREEN YES

// colors
#define CC_WHITE ccc4(255, 255, 255, 255)
#define CC_GRAY ccc4(45, 45, 45, 255)

#define kCAPS_ON_UP 87
#define kCAPS_ON_DOWN 83
#define kCAPS_ON_LEFT 68
#define kCAPS_ON_RIGHT 65

#define kCAPS_OFF_UP 119
#define kCAPS_OFF_DOWN 115
#define kCAPS_OFF_LEFT 100
#define kCAPS_OFF_RIGHT 97

/// notifications

#define kHEALTH_ADD @"health_added"
#define kHEALTH_DROP @"health_dropped"
#define kHEALTH_ZERO @"player_died"
#define kNO_ENEMY_LEFT @"all_enemies_dead"
#define kGENERATE_DROP @"drop_generated"

#endif
