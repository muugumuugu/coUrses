import THREE from 'three';
import ndarray from 'ndarray';

const vertexShader = `
attribute vec3 color;
varying vec3 vPosition;
varying vec3 vColor;
varying vec3 vNormal;
varying vec3 vView;
varying vec3 vLight;
uniform float scale;
uniform float time;
uniform vec4 light;


/* ASHIMA
functions below are from:
  https://github.com/ashima/webgl-noise/blob/master/src/noise2D.glsl
They are under a separate licence from the rest of this file.
*/
vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
  return mod289(((x*34.0)+1.0)*x);
}

float snoise(vec2 v)
  {
  const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                     -0.577350269189626,  // -1.0 + 2.0 * C.x
                      0.024390243902439); // 1.0 / 41.0
// First corner
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);

// Other corners
  vec2 i1;
  //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
  //i1.y = 1.0 - i1.x;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  // x0 = x0 - 0.0 + 0.0 * C.xx ;
  // x1 = x0 - i1 + 1.0 * C.xx ;
  // x2 = x0 - 1.0 + 2.0 * C.xx ;
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;

// Permutations
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
    + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;

// Gradients: 41 points uniformly over a line, mapped onto a diamond.
// The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;

// Normalise gradients implicitly by scaling m
// Approximation of: m *= inversesqrt( a0*a0 + h*h );
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

// Compute final noise value at P
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}
/*ASHIMA END*/


void main(){

  vec3 pos = position;

  vPosition = vec3(modelMatrix * vec4(pos,1.));
  vNormal = vec3(modelMatrix * vec4(normal,1.));
  vView = vPosition - cameraPosition;
  vLight = vPosition - light.xyz;

  if (vPosition.z>0.1){
    vPosition.z = (abs(snoise(vec2(0.0,time/50.0)+vPosition.xy/2000.0)))*500.0 +
        abs(1.0+snoise(vec2(0.0,time/10.0)+vPosition.xy/500.0))*100.0 +
        (snoise(vPosition.xy/100.0) * clamp(0.5+snoise(vPosition.xy/10.0), 0.0, 1.0))*20.0+
        snoise(vPosition.xy/1.0)*20.0;
  }

  gl_Position = projectionMatrix * modelViewMatrix * vec4(vPosition,1.0);
}
`;

const fragmentShader = `
//#extension GL_OES_standard_derivatives: enable

uniform float itt;
uniform float mode;
uniform vec2 window;
uniform float pixelRatio;
uniform vec2 mouse;

varying vec3 vColor;
varying vec3 vPosition;
varying vec3 vNormal;
varying vec3 vView;
varying vec3 vLight;

/* ASHIMA
functions below are from:
  https://github.com/ashima/webgl-noise/blob/master/src/noise2D.glsl
They are under a separate licence from the rest of this file.
*/
vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
  return mod289(((x*34.0)+1.0)*x);
}

float snoise(vec2 v)
  {
  const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                     -0.577350269189626,  // -1.0 + 2.0 * C.x
                      0.024390243902439); // 1.0 / 41.0
// First corner
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);

// Other corners
  vec2 i1;
  //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
  //i1.y = 1.0 - i1.x;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  // x0 = x0 - 0.0 + 0.0 * C.xx ;
  // x1 = x0 - i1 + 1.0 * C.xx ;
  // x2 = x0 - 1.0 + 2.0 * C.xx ;
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;

// Permutations
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
    + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;

// Gradients: 41 points uniformly over a line, mapped onto a diamond.
// The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;

// Normalise gradients implicitly by scaling m
// Approximation of: m *= inversesqrt( a0*a0 + h*h );
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

// Compute final noise value at P
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}
/*ASHIMA END*/


vec3 fog(float vdist, vec3 I){
  vec3 fogColor = vec3(1.0);
  float b = 0.001;
  float dens = 1.0-exp(-(vdist*b));
  return mix(I,fogColor,dens);
}

vec3 effect(vec3 I, vec3 Nn, vec3 Ln, vec3 Vn){
  vec3 index = vec3(2.0,0.5,0.0)/50.0;
  vec3 ref = clamp(abs(refract(Vn,Nn,1.0)),0.0,1.0);
  vec3 x = I*ref*index*5.0;
  return clamp(I-x,0.0,1.0);
}

void main(){

  float opacity = 1.0;
  vec3 I = vec3(0.0,0.0,1.0);
  float vdist = length(vView);

  vec3 Nn = normalize(vNormal);
  vec3 Ln = normalize(vLight);
  vec3 Vn = normalize(vView);

  I = vec3(0.0);
  vec3 c = vec3(0.69, 0.32, 0.46);
  I = mix(I, c, clamp(snoise(vPosition.xy),0.0,1.0));

  //I.xy = vColor.xy;
  I = fog(vdist, I);
  I = effect(I, Nn, Ln, Vn);

  gl_FragColor = vec4(
    pow(I, vec3(2.0)),
    opacity
  );
}
`;

export default class Grid {
  constructor(numPillars, width, x0, y0, uniforms) {
    const sqr = numPillars * numPillars;
    const tnum = sqr * 6;
    const vnum = sqr * 6;

    this.width = width;
    this.uniforms = uniforms;
    this.x0 = x0;
    this.y0 = y0;
    this.numPillars = numPillars;
    this.tnum = tnum;
    this.vnum = vnum;

    this.nvert = 0;
    this.ntri = 0;

    this.index = new Uint16Array(tnum * 3);
    this.position = new Float32Array(vnum * 3);
    this.color = new Float32Array(vnum * 3);
    this.normal = new Float32Array(vnum * 3);

    this.ndindex = ndarray(this.index, [tnum, 3]);
    this.ndposition = ndarray(this.position, [vnum, 3]);
    this.ndcolor = ndarray(this.color, [vnum, 3]);
    this.ndnormal = ndarray(this.normal, [vnum, 3]);

    this.geometry = new THREE.BufferGeometry();

    this.geometry.setIndex(new THREE.BufferAttribute(this.index, 1));
    this.geometry.addAttribute('position', new THREE.BufferAttribute(this.position, 3));
    this.geometry.addAttribute('normal', new THREE.BufferAttribute(this.normal, 3));
    this.geometry.addAttribute('color', new THREE.BufferAttribute(this.color, 3));

    for (let t = 0; t < this.tnum; t++){
      this.ndindex.set(t, 0, 0);
      this.ndindex.set(t, 1, 0);
      this.ndindex.set(t, 2, 0);
    }

    for (let v = 0; v < this.vnum; v++){
      this.ndposition.set(v, 0, 0);
      this.ndposition.set(v, 1, 0);
      this.ndposition.set(v, 2, 0);

      this.ndcolor.set(v, 0, 0);
      this.ndcolor.set(v, 1, 0);
      this.ndcolor.set(v, 2, 0);

      this.ndnormal.set(v, 0, 0);
      this.ndnormal.set(v, 1, 0);
      this.ndnormal.set(v, 2, 0);
    }

    this.geometry.index.needsUpdate = true;
    this.geometry.attributes.position.needsUpdate = true;
    this.geometry.attributes.normal.needsUpdate = true;
    this.geometry.attributes.color.needsUpdate = true;

    this.ntri = 0;
    this.nvert = 0;
  }

  addPillar(x, y, w, h, b) {
    let nvert = this.nvert;
    let ntri = this.ntri;
    const shift = Math.random() * Math.PI * 2;

    for (let i = 0; i < 3; i++){
      const theta = shift + i * Math.PI / 3.0 * 2.0;
      const xx = x + Math.cos(theta) * w;
      const yy = y + Math.sin(theta) * w;
      this.ndposition.set(nvert, 0, xx);
      this.ndposition.set(nvert, 1, yy);
      this.ndposition.set(nvert, 2, b);
      nvert++;
    }

    for (let i = 0; i < 3; i++){
      const theta = shift + i * Math.PI / 3.0 * 2.0;
      const xx = x + Math.cos(theta) * w;
      const yy = y + Math.sin(theta) * w;
      this.ndposition.set(nvert, 0, xx);
      this.ndposition.set(nvert, 1, yy);
      this.ndposition.set(nvert, 2, h);
      nvert++;
    }

    this.geometry.attributes.position.needsUpdate = true;

    this.ndindex.set(ntri, 0, nvert - 3);
    this.ndindex.set(ntri, 1, nvert - 2);
    this.ndindex.set(ntri, 2, nvert - 6);
    ntri++;

    this.ndindex.set(ntri, 0, nvert - 2);
    this.ndindex.set(ntri, 1, nvert - 5);
    this.ndindex.set(ntri, 2, nvert - 6);
    ntri++;

    this.ndindex.set(ntri, 0, nvert - 2);
    this.ndindex.set(ntri, 1, nvert - 1);
    this.ndindex.set(ntri, 2, nvert - 4);
    ntri++;

    this.ndindex.set(ntri, 0, nvert - 2);
    this.ndindex.set(ntri, 1, nvert - 5);
    this.ndindex.set(ntri, 2, nvert - 4);
    ntri++;

    this.ndindex.set(ntri, 0, nvert - 1);
    this.ndindex.set(ntri, 1, nvert - 3);
    this.ndindex.set(ntri, 2, nvert - 4);
    ntri++;

    this.ndindex.set(ntri, 0, nvert - 3);
    this.ndindex.set(ntri, 1, nvert - 6);
    this.ndindex.set(ntri, 2, nvert - 4);
    ntri++;

    this.geometry.index.needsUpdate = true;

    this.nvert = nvert;
    this.ntri = ntri;
  }

  makeGrid() {
    const w = this.width;
    const h = 10;
    const b = 0;
    for (let i = 0; i < this.numPillars; i++){
      for (let j = 0; j < this.numPillars; j++){
        const x = this.x0 + w * (0.5 - i / this.numPillars);
        const y = this.y0 + w * (0.5 - j / this.numPillars);
        this.addPillar(x, y, 4, h, b);
      }
    }
  }

  makeMesh(){
    const material = new THREE.ShaderMaterial({
      uniforms: this.uniforms,
      vertexShader,
      fragmentShader
    });

    material.side = THREE.DoubleSide;

    this.geometry.computeFaceNormals();
    this.geometry.computeVertexNormals();
    this.mesh = new THREE.Mesh(this.geometry, material);
    this.mesh.frustumCulled = false;
  }
}

