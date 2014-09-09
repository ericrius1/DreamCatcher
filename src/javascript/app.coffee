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
DreamCatcher = require './dreamcatcher'



time = null
WIDTH = window.innerWidth
HEIGHT = window.innerHeight
clock = new THREE.Clock()
scene = new THREE.Scene()
rf = THREE.Math.randFloat

camera = new THREE.PerspectiveCamera(50, WIDTH/HEIGHT, 1, 20000)
camera.position.z = 100


renderer = new THREE.WebGLRenderer({antialias: true})
renderer.setSize WIDTH, HEIGHT
document.body.appendChild renderer.domElement
controls = new THREE.OrbitControls(camera)



audioController = new AudioController()




stream = new Stream('/audio/hang.mp3', audioController)

# stream.play()

# vis = new Vis(scene, audioController)

dreamcatcher = new DreamCatcher(scene, audioController)

onBeat = ()->
  console.log 'yar'
  dreamcatcher.update()
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





