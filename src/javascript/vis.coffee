THREE = require 'three'
_ = require 'underscore'

class Vis
  constructor: (@scene, @audioController)->
    @flames = []


    for i in [0..@audioController.analyzer.array.length/2]
      flame = new THREE.Mesh(new THREE.BoxGeometry(5, 5, 5))
      flame.position.x += (i * 5) - 1000

      scene.add(flame)
      @flames.push(flame)

  update: (time)->
    for i in [0...@audioController.analyzer.array.length/2]
      scale = Math.max(.01, @audioController.analyzer.array[i] * .1)
      if(scale > 10)
        @flames[i].scale.y =  scale
      else 
        @flames[i].scale.y = 1



module.exports = Vis