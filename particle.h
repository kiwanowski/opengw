#ifndef PARTICLE_H
#define PARTICLE_H

#include "point3d.h"
#include "vector.h"
#include "mathutils.h"

#define NUM_POS_STREAM_ITEMS 6

class particle
{
public:
    typedef struct
    {
        Point3d posStream[NUM_POS_STREAM_ITEMS];

        float speedX;
        float speedY;
        float speedZ;

        vector::pen color;

        int timeToLive;
        float fadeStep;

        bool gravity;
        bool gridBound;
        float drag;

        bool hitGrid;

        bool glowPass;

    }PARTICLE;

    particle();
    ~particle();

    void draw();
    void run();

    void emitter(Point3d* position, Point3d* angle, float speed, float spread, int num, vector::pen* color, int timeToLive,
        bool gravity=true, bool gridBound=true, float drag=.93, bool glowPass=true);

    void killAll();

    static PARTICLE* mParticles;
    static int mNumParticles;
    static int mIndex;

private:

    void assignParticle(Point3d* position,
                                  float aSpeedX, float aSpeedY, float aSpeedZ,
                                  int aTime, vector::pen* aColor, bool gravity, bool gridBound, float drag, bool glowPass);

};

#endif // PARTICLE_H
