#784800
#440ms for beat
THREE = require 'three'
require 'OrbitControls'
require 'FlyControls'
AudioController = require './vendor/AudioController'
AudioTexture= require './vendor/AudioTexture'
Stream = require './vendor/Stream'
TWEEN = require 'tween.js'
_ = require 'underscore'
Vis = require './vis'



time = null
WIDTH = window.innerWidth
HEIGHT = window.innerHeight
clock = new THREE.Clock()
scene = new THREE.Scene()
rf = THREE.Math.randFloat

camera = new THREE.PerspectiveCamera(50, WIDTH/HEIGHT, 1, 20000)
camera.position.z = 50
camera.position.y = 100
camSpeed = 10

renderer = new THREE.WebGLRenderer({antialias: true})
renderer.setSize WIDTH, HEIGHT
document.body.appendChild renderer.domElement
controls = new THREE.OrbitControls(camera)



audioController = new AudioController()




stream = new Stream('/audio/hang.mp3', audioController)

# stream.play()

# vis = new Vis(scene, audioController)

ringGeo = new THREE.TorusGeometry 20, 2, 10, 50
ringMat = new THREE.MeshBasicMaterial
  wireframe: true
ringMesh = new THREE.Mesh ringGeo, ringMat
# scene.add ringMesh


colors = []
geometry = new THREE.Geometry()
geometry.vertices.push(new THREE.Vector3(0, 0, 0))
prevVertex = geometry.vertices[0]
for i in [0..10]
  vertex = new THREE.Vector3 prevVertex.x + rf(1, 10), prevVertex.y + rf(1, 10), 0
  geometry.vertices.push vertex
  colors[i] = new THREE.Color(0x000000)
  prevVertex = vertex


geometry.colors = colors
curVertexIndex = 0

material = new THREE.LineBasicMaterial
  vertexColors: THREE.VertexColors

line = new THREE.Line(geometry, material)
scene.add line

onBeat = ()->
  console.log 'yar'
  geometry.colors[curVertexIndex++]?.setHSL(0.4, 0.7, 0.7)
  geometry.colorsNeedUpdate = true
  setTimeout ()->
    onBeat()
  , 440


animate = ()->
  requestAnimationFrame(animate)
  renderer.render scene, camera
  audioController.update()
  controls.update()
  time = clock.getElapsedTime()

  TWEEN.update()
  # vis.update()




window.onload = ()->
  window.addEventListener('resize', onWindowResize, false)

onWindowResize = ()-> 
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();


onBeat()
animate()





