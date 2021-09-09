#ifndef SCENESHADOWVOLUME_H
#define SCENESHADOWVOLUME_H

#include "scene.h"
#include "glslprogram.h"
#include "plane.h"
#include "objmesh.h"

#include "cookbookogl.h"

#include <glm/glm.hpp>

class SceneShadowVolume : public Scene
{
private:
    GLSLProgram volumeProg, renderProg, compProg;
    GLuint colorDepthFBO, fsQuad;
    GLuint spotTex, brickTex;

    Plane plane;
    std::unique_ptr<ObjMesh> spot;

    glm::vec4 lightPos;
    float angle, tPrev, rotSpeed;

    void setMatrices(GLSLProgram &);
    void compileAndLinkShader();
    void setupFBO();
    void drawScene(GLSLProgram &, bool);
    void pass1();
    void pass2();
    void pass3();
    void updateLight();

public:
    SceneShadowVolume();

    void initScene();
    void update( float t );
    void render();
    void resize(int, int);
};

#endif // SCENESHADOWVOLUME_H
