#include "settings.hpp"

settings::settings()
{
    mCreditsPerGame = false; // false = Freeplay

    mEnableGlow = true;

    mGridSmoothing = false;
    mParticleSmoothing = false;
    mEnemySmoothing = false;
    mPlayerSmoothing = true;
    mStarSmoothing = true;

    mAttractors = 50;
    mParticles = 3000;

    mGridPasses = 4;

    displayWidth = 800;
    displayHeight = 600;
}

settings::~settings()
{
}
