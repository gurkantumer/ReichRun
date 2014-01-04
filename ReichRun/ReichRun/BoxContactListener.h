//
//  BoxContactListener.h
//  CupidRun
//
//  Created by Gurkan Tumer on 12/26/12.
//  Copyright Studio Nord 2012. All rights reserved.
//
#import "Box2D.h"
#import <vector>
#import <algorithm>

struct BoxContact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator==(const BoxContact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
    };
    
    class BoxContactListener : public b2ContactListener {
        
    public:
        std::vector<BoxContact>_contacts;
        
        BoxContactListener();
        ~BoxContactListener();
        
        virtual void BeginContact(b2Contact* contact);
        virtual void EndContact(b2Contact* contact);
        virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
        virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
        
    };