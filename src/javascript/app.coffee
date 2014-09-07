THREE = require 'three'
require 'OrbitControls'
AudioController = require './vendor/AudioController'
AudioTexture= require './vendor/AudioTexture'
Stream = require './vendor/Stream'
TWEEN = require 'tween.js'
Vis = require './vis'
_ = require 'underscore'


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




stream = new Stream('/audio/hang.mp3', audioController)

stream.play()

# vis = new Vis(scene, audioController)


class Circles
  constructor: (@scene, @audioController)->
    @circles = []


    for i in [0..10]
      circle = new THREE.Mesh(new THREE.SphereGeometry(5, 5), new THREE.MeshBasicMaterial())
      circle.position.set _.random(-50, 50), _.random(-50, 50), _.random(-50, 50)

      scene.add(circle)
      @circles.push(circle)

    @flash()

  flash: ->
    circle = _.sample(@circles)
    console.log circle.material.color.getHex()
    if circle.material.color.getHex() is 0xffffff then circle.material.color.set 0x000000
    else circle.material.color .set 0xffffff
    setTimeout =>
      @flash()
    ,440

circles = new Circles(scene, audioController)






animate = ()->
  requestAnimationFrame(animate)
  renderer.render scene, camera
  audioController.update()
  controls.update()
  time = clock.getElapsedTime()
  TWEEN.update()
  # vis.update()
  # fire.update()



window.onload = ()->
  window.addEventListener('resize', onWindowResize, false)

onWindowResize = ()-> 
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

animate()





