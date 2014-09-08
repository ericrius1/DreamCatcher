rf = THREE.Math.randFloat
class DreamCatcher
  constructor: (@scene, @audioController)->
    
    colors = []
    @geometry = new THREE.Geometry()
    @geometry.vertices.push(new THREE.Vector3(0, 0, 0))
    prevVertex = @geometry.vertices[0]
    for i in [0..50]
      vertex = new THREE.Vector3 prevVertex.x + rf(1, 10), prevVertex.y + rf(1, 10), 0
      @geometry.vertices.push vertex
      colors[i] = new THREE.Color(0x000000)
      prevVertex = vertex


    @geometry.colors = colors
    @curVertexIndex = 0

    material = new THREE.LineBasicMaterial
      vertexColors: THREE.VertexColors

    line = new THREE.Line(@geometry, material)
    @scene.add line

  update: ()->
    @geometry.colors[@curVertexIndex++]?.setHSL(0.4, 0.7, 0.7)
    @geometry.colorsNeedUpdate = true



module.exports = DreamCatcher