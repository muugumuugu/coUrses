
import THREE from 'three';
import Grid from './grid';

let time = 0.0;

const OrbitControls = require('three-orbit-controls')(THREE);

let scene;
let camera;
let renderer;
let lastRender = new Date();
let uniforms;

const makeGrids = (num, width, numGrids) => {
  const allGrids = [];
  uniforms = {
    time: {
      type: 'f',
      value: time
    },
    scale: {
      type: 'f',
      value: 1.0 / numGrids / width
    }
  };

  for (let i = 0; i < numGrids; i++){
    for (let j = 0; j < numGrids; j++){
      const x0 = (0.5 + i) * width;
      const y0 = (0.5 + j) * width;

      const g = new Grid(num, width, x0, y0, uniforms);

      g.makeGrid();
      g.makeMesh();
      camera.add(g.mesh);
      scene.add(g.mesh);
      allGrids.push(g);
    }
  }
  return allGrids;
};


const init = () => {
  const num = 100;
  const width = 600;
  const numGrids = 7;

  scene = new THREE.Scene();

  camera = new THREE.PerspectiveCamera(
    120,
    window.innerWidth / window.innerHeight,
    1, 100000
  );
  const mid = width * numGrids * 0.5;

  // eslint-disable-next-line
  const controls = new OrbitControls(camera);
  controls.target = new THREE.Vector3(mid, mid, 0);

  camera.position.set(mid, mid, 1000);
  //camera.lookAt(new THREE.Vector3(0, 0, 0)); // not working with controller
  //camera.up = new THREE.Vector3(0, 0, 1);

  renderer = new THREE.WebGLRenderer();
  renderer.setSize(window.innerWidth, window.innerHeight);
  renderer.setClearColor(0xffffff, 1);

  const allGrids = makeGrids(num, width, numGrids);
  document.body.appendChild(renderer.domElement);
  //document.getElementById('box').appendChild(renderer.domElement);
};


const animate = () => {
  requestAnimationFrame(animate);

  time += 1.0;
  uniforms.time.value = time;

  const c = Date.now();
  const tickTime = c - lastRender;

  lastRender = c;
  renderer.render(scene, camera);
};

init();
animate();

