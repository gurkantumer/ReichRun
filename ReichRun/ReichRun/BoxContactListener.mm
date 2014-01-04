//
//  BoxContactListener.m
//  CupidRun
//
//  Created by Gurkan Tumer on 12/26/12.
//  Copyright Studio Nord 2012. All rights reserved.
//
#import "BoxContactListener.h"

BoxContactListener::BoxContactListener() : _contacts() {
}

BoxContactListener::~BoxContactListener() {
}

void BoxContactListener::BeginContact(b2Contact* contact)
{
    BoxContact bxContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    _contacts.push_back(bxContact);
    
    //int fixAInt = (int)contact->GetFixtureA()->GetUserData();
    //int fixBInt = (int)contact->GetFixtureB()->GetUserData();
    
    /*if ( fixAInt == kCharacterFootTag ){
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        plyr.footContactCount++;
    }
    
    if ( fixBInt == kCharacterFootTag ){
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        plyr.footContactCount++;
    }
    
    if (fixAInt == kCharacterLeftSideTag ){
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        plyr.leftContactCount++;
    }
    
    if ( fixBInt == kCharacterLeftSideTag ){
        
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        plyr.leftContactCount++;
    }
    
    if ( fixAInt == kCharacterRightSideTag ){
        
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        plyr.rightContactCount++;
    }
    
    if ( fixBInt == kCharacterRightSideTag ){
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        plyr.rightContactCount++;
    }
    
    if (fixAInt == kDeadSensorTag ) {
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        WetFloor *floor = (WetFloor *) contact->GetFixtureA()->GetBody()->GetUserData();
        [floor splat:CGPointMake(plyr.position.x, FLOOR_HEIGHT-20)];
        [plyr updateWalkSpeed:@"slow"];
        return;
    }
    
    if (fixBInt == kDeadSensorTag ) {
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        WetFloor *floor = (WetFloor *) contact->GetFixtureB()->GetBody()->GetUserData();
        [floor splat:CGPointMake(plyr.position.x, FLOOR_HEIGHT-20)];
        [plyr updateWalkSpeed:@"slow"];
        return;
    }
    
    if (fixAInt == kLevelEndSensorTag){
        
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureB()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeLevelEnd];
        return;
    }
    
    
    if (fixBInt == kLevelEndSensorTag){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureB()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeLevelEnd];
        return;
    }
    
    if (fixAInt == kLevelTutorialSensorTag1){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureB()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeTutorial1];
    }
    
    if (fixBInt == kLevelTutorialSensorTag1){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureA()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeTutorial1];
    }
    
    if (fixAInt == kLevelTutorialSensorTag2){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureB()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeTutorial2];
    }
    
    if (fixBInt == kLevelTutorialSensorTag2){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureA()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeTutorial2];
    }
    
    if (fixAInt == kLevelTutorialSensorTag3){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureB()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeTutorial3];
    }
    
    if (fixBInt == kLevelTutorialSensorTag3){
        LevelBase *lyr = (LevelBase *) [(Character *) contact->GetFixtureA()->GetBody()->GetUserData() parent];
        [lyr pauseGame:kSensorTypeTutorial3];
    }*/
}

void BoxContactListener::EndContact(b2Contact* contact)
{
    BoxContact bxContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    std::vector<BoxContact>::iterator pos;
    pos = std::find(_contacts.begin(), _contacts.end(), bxContact);
    if (pos != _contacts.end()) {
        _contacts.erase(pos);
    }
        
    //int fixAInt = (int)contact->GetFixtureA()->GetUserData();
    //int fixBInt = (int)contact->GetFixtureB()->GetUserData();
    
    /*if (fixAInt == kCharacterFootTag ){
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        plyr.footContactCount--;
    }
    
    if ( fixBInt == kCharacterFootTag ){
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        plyr.footContactCount--;
    }
    
    if (fixAInt == kCharacterLeftSideTag ){
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        plyr.leftContactCount--;
    }
    
    if (fixBInt == kCharacterLeftSideTag ){
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        plyr.leftContactCount--;
    }
    
    if (fixAInt == kCharacterRightSideTag ){
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        plyr.rightContactCount--;
    }
    
    if (fixBInt == kCharacterRightSideTag ){
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        plyr.rightContactCount--;
    }
    
    if (fixAInt == kDeadSensorTag ) {
        Character *plyr = (Character *) contact->GetFixtureB()->GetBody()->GetUserData();
        [plyr updateWalkSpeed:@"fast"];
    }
    
    if (fixBInt == kDeadSensorTag ) {
        Character *plyr = (Character *) contact->GetFixtureA()->GetBody()->GetUserData();
        [plyr updateWalkSpeed:@"fast"];
    }*/
}

void BoxContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
    //
}

void BoxContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{
    //
}