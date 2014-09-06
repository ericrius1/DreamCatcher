THREE = require 'three'
require 'OrbitControls'
AudioController = require './vendor/AudioController'
AudioTexture= require './vendor/AudioTexture'
Stream = require './vendor/Stream'
TWEEN = require 'tween.js'


time = null
WIDTH = window.innerWidth
HEIGHT = window.innerHeight
clock = new THREE.Clock()
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(50, WIDTH/HEIGHT, 0.001, 20000)
camera.position.z = 50
renderer = new THREE.WebGLRenderer({antialias: true})
renderer.setSize WIDTH, HEIGHT
document.body.appendChild renderer.domElement
controls = new THREE.OrbitControls(camera)

#color, intensity, distance
# pointLight  = new THREE.PointLight(new THREE.Color(0xffffff), 2.0)
# pointLight.position.set -20, 0, 30
# scene.add pointLight

audioController = new AudioController()



# fire = new Fire(scene, audioController)

# stream = new Stream('/audio/fire.mp3', audioController)

# stream.play()




animate = ()->
  requestAnimationFrame(animate)
  renderer.render scene, camera
  audioController.update()
  controls.update()
  time = clock.getElapsedTime()
  TWEEN.update()
  # fire.update()



window.onload = ()->
  window.addEventListener('resize', onWindowResize, false)

onWindowResize = ()-> 
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

animate()