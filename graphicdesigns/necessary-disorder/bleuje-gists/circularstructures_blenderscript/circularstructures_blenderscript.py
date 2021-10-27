# blender script by @etiennejcb

# There must be no object in the scene before running this
# Path to folder where the frames will be saved and beginning of filename for frames
PATH_TO_SAVED_IMAGES_FOLDER = r'path\to\folder\frame'
# Window > Toggle System Console to see the progress (and blender can't be used while it renders)
#####################################################################
# IMPORTS AND TEMPLATE
import bpy
from mathutils import Vector
from math import *
import math
import random
from opensimplex import OpenSimplex # from https://github.com/lmas/opensimplex

ns = OpenSimplex(123)
def hex2rgba(hexColor):
    h = hexColor.lstrip('#')
    return tuple(int(h[i:i+2], 16)/255.0 for i in (0, 2, 4))+(1.0,)
TWO_PI = radians(360)
def map_range(value, start1, stop1, start2, stop2):
    return (value - start1) / (stop1 - start1) * (stop2 - start2) + start2
def ease(p, g):
    if (p < 0.5):
        return 0.5 * pow(2*p, g)
    else:
        return 1 - 0.5 * pow(2*(1 - p), g)
def c01(v):
    return min(1,max(0,v))

#####################################################################
# RENDERING PARAMETERS

bpy.context.scene.render.engine = 'CYCLES'
bpy.context.view_layer.cycles.use_denois = True
bpy.context.scene.cycles.samples = 64
bpy.context.scene.cycles.max_bounces = 6
bpy.context.scene.render.tile_x = 16
bpy.context.scene.render.tile_y = 16

#####################################################################
# RENDERING RESOLUTION / CAMERA / LIGHT
bpy.context.scene.render.resolution_x = 600
bpy.context.scene.render.resolution_y = 600

camera = bpy.data.objects['Camera']
camera.data.clip_end = 300
camera.location[0] = 13
camera.location[1] = -13
camera.location[2] = 10
camera.rotation_euler[0] = math.radians(58)
camera.rotation_euler[1] = math.radians(0)
camera.rotation_euler[2] = math.radians(45)

light = bpy.data.objects['Light']
light.data.type = 'SUN'
light.data.energy = 7.5
light.location[0] = 100
light.location[1] = 100
light.location[2] = 70
light.rotation_euler[0] = math.radians(46)
light.rotation_euler[1] = math.radians(-49)
light.rotation_euler[2] = math.radians(161)

#####################################################################
# Rendered frames
numFrames = 55
renderedFrames = [i+1 for i in range(numFrames)]

#####################################################################
# Color palette
palette = ["eeeeee","eeeeee","eeeeee","050505","0755ee"]

#####################################################################
# MESH GENERATION CODE
N = 4
K = 9

RATIO = 2.3

class Mesh:
    def __init__(self, verts, faces, matIndices):
        self.v = verts
        self.f = faces
        self.mi = matIndices
    
    def appendOtherData(self, verts, faces, matIndices):
        numberOfVerticesToAdd = len(self.v)
        self.v.extend(verts)
        for face in faces:
            face2 = [x+numberOfVerticesToAdd for x in face]
            self.f.append(face2)
        self.mi.extend(matIndices)
    
    def appendMesh(self, mesh):
        self.appendOtherData(mesh.v, mesh.f, mesh.mi)
        
    def changeScaleWithFactor(self, scl):
        new_v = []
        for vert in self.v:
            new_v.append(Vector((vert.x*scl, vert.y*scl, vert.z*scl)))
        self.v = new_v
    
    def appendMesh(self, mesh):
        self.appendOtherData(mesh.v, mesh.f, mesh.mi)
        
    def changeScaleWithFactor(self, scl):
        new_v = []
        for vert in self.v:
            new_v.append(Vector((vert.x*scl, vert.y*scl, vert.z*scl)))
        self.v = new_v


class Block:
    def __init__(self):
        self.seed = random.uniform(10,1000)
        self.matIndex = random.randint(0,len(palette)-1)
        self.dz = 300
        self.m = 10
    
    def blockMesh(self, r1, r2, theta1, theta2, p):
        res = Mesh([],[],[])
        
        f = ease(c01(2*p),2.0)
        tz = pow(map_range(ns.noise2d(self.seed+3.8*p,0),-1,1,0,1),6.0)*180*pow(RATIO,p)*f - 0*100*pow(1-p,5.0)
    
        tz *= 0.8
    
        z1 = tz
        z2 = tz-self.dz
    
        verts = [Vector((r1*cos(theta1),r1*sin(theta1),z1)),Vector((r1*cos(theta1),r1*sin(theta1),z2)),Vector((r2*cos(theta1),r2*sin(theta1),z2)),Vector((r2*cos(theta1),r2*sin(theta1),z1))]
        faces = [[i for i in range(4)]]
        matInd = [self.matIndex]*len(faces)
        res.appendOtherData(verts,faces,matInd)
    
        verts = [Vector((r1*cos(theta2),r1*sin(theta2),z1)),Vector((r1*cos(theta2),r1*sin(theta2),z2)),Vector((r2*cos(theta2),r2*sin(theta2),z2)),Vector((r2*cos(theta2),r2*sin(theta2),z1))]
        faces = [[i for i in range(4)]]
        matInd = [self.matIndex]*len(faces)
        res.appendOtherData(verts,faces,matInd)
        
        faces = [[2*i,2*i+1,2*i+3,2*i+2] for i in range(self.m)]
        matInd = [self.matIndex]*len(faces)
        verts = []
        for i in range(self.m+1):
            theta = map_range(i,0,self.m,theta1,theta2)
            verts.append(Vector((r1*cos(theta),r1*sin(theta),z1)))
            verts.append(Vector((r1*cos(theta),r1*sin(theta),z2)))
        res.appendOtherData(verts,faces,matInd)
        
        faces = [[2*i,2*i+1,2*i+3,2*i+2] for i in range(self.m)]
        matInd = [self.matIndex]*len(faces)
        verts = []
        for i in range(self.m+1):
            theta = map_range(i,0,self.m,theta1,theta2)
            verts.append(Vector((r2*cos(theta),r2*sin(theta),z1)))
            verts.append(Vector((r2*cos(theta),r2*sin(theta),z2)))
        res.appendOtherData(verts,faces,matInd)
        
        faces = [[2*i,2*i+1,2*i+3,2*i+2] for i in range(self.m)]
        matInd = [self.matIndex]*len(faces)
        verts = []
        for i in range(self.m+1):
            theta = map_range(i,0,self.m,theta1,theta2)
            verts.append(Vector((r1*cos(theta),r1*sin(theta),z1)))
            verts.append(Vector((r2*cos(theta),r2*sin(theta),z1)))
        res.appendOtherData(verts,faces,matInd)
        
        faces = [[2*i,2*i+1,2*i+3,2*i+2] for i in range(self.m)]
        matInd = [self.matIndex]*len(faces)
        verts = []
        for i in range(self.m+1):
            theta = map_range(i,0,self.m,theta1,theta2)
            verts.append(Vector((r1*cos(theta),r1*sin(theta),z2)))
            verts.append(Vector((r2*cos(theta),r2*sin(theta),z2)))
        res.appendOtherData(verts,faces,matInd)
    
        return res
    
    def value(self, p):
        change = 5.0*pow(p+.3,0.4)
        return pow(map_range(sin(TWO_PI*p/2.0)*ns.noise2d(10*self.seed+change,0),-1,1,0,1),5.0)*30
        

class Circle:
    def __init__(self, j_):
        self.theta0 = random.uniform(0,TWO_PI)
        self.numberOfBlocks = floor(random.uniform(10,42)*3)
        self.blocks = []
        for i in range(self.numberOfBlocks):
          self.blocks.append(Block())
        self.j = j_

    def createMesh(self, time):
        mesh = Mesh([],[],[])
        for k in range(-2, K):
                  
            ind = self.j+(k+time)*N
          
            p = map_range(ind+0.5,0,K*N,0,1)
            p1 = map_range(ind,0,K*N,0,1)
            p2 = map_range(ind+1,0,K*N,0,1)
          
            sumValues = 0
            partialSums = []
            partialSums.append(0)
            for i in range(self.numberOfBlocks):
                sumValues += self.blocks[i].value(p)
                partialSums.append(sumValues)
          
            r1 = pow(RATIO,p1*K)*5
            r2 = pow(RATIO,p2*K)*5
          
            for i in range(self.numberOfBlocks):
                part1 = partialSums[i]/sumValues
                part2 = partialSums[i+1]/sumValues

                theta1 = map_range(part1,0,1,0,TWO_PI)+self.theta0
                theta2 = map_range(part2,0,1,0,TWO_PI)+self.theta0

                mesh.appendMesh(self.blocks[i].blockMesh(r1,r2,theta1,theta2,p))
        return mesh
        

def clearNewObject():
    bpy.data.objects.remove(bpy.context.scene.objects[0], do_unlink = True)

    for material in bpy.data.materials:
        bpy.data.materials.remove(material)
        
    for mesh in bpy.data.meshes:
        bpy.data.meshes.remove(mesh)

# Mesh parts initialization
print("Initializing...")
circlesArray = []
random.seed(8734)
for i in range(N):
    circlesArray.append(Circle(i))
print("Initialized")

#####################################################################
# FOR LOOP TO RENDER EACH FRAME

for it in renderedFrames:
    print("Making stuff for frame",it,"...")
    
    time = 1.0*(it-1)/numFrames
    
    globalMesh = Mesh([],[],[])
    
    for c in circlesArray:
        globalMesh.appendMesh(c.createMesh(time))
    
    globalMesh.changeScaleWithFactor(0.01)
    
    mesh_data = bpy.data.meshes.new("collapse_mesh_data " + str(it))
    mesh_data.from_pydata(globalMesh.v, [], globalMesh.f)
    mesh_data.update()

    obj = bpy.data.objects.new("Collapse " + str(it), mesh_data)
    
    materialIndexList = globalMesh.mi
    
    for ind in range(len(palette)):
        matname = "Material "+ str(ind+1)
        mat = bpy.data.materials.new(name=matname)
        mat.diffuse_color = hex2rgba(palette[ind])

        obj.data.materials.append(mat)

    for idx, face in enumerate(obj.data.polygons):
        face.material_index = materialIndexList[idx]

    scene = bpy.context.scene
    scene.collection.objects.link(obj)
    
    print("Starting rendering")
    
    bpy.context.scene.render.filepath = PATH_TO_SAVED_IMAGES_FOLDER + str(it).zfill(3)
    bpy.ops.render.render(write_still=True)
    
    clearNewObject()

    print("Mesh "+str(it)+" rendered")
    