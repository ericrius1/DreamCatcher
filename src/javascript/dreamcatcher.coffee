
map= (value, min1, max1, min2, max2)->
  min2 + (max2 - min2) * ((value - min1) / (max1 - min1))


_ = require 'underscore'
TWEEN = require 'tween.js'

rf = THREE.Math.randFloat
class DreamCatcher
  constructor: (position, @scene, @audioController)->
    @containerObj = new THREE.Object3D()
    @containerObj.position.set position.x, position.y, position.z
    @scene.add @containerObj
    @numLines = 22
    @numPoints = 111
    @outerRadius = 50
    @innerRadius = 1
    colors = []
    @oldVertex


    @curVertexIndex = 0
    @rippleDir = 1

    @hue =  0.496
    @light = 0.5

    createPoints = (x1, y1, x2, y2, numPoints)->
      jumpX = 0.3
      jumpY = 0.1
      points = []
      points.push(new THREE.Vector3(x1, y1, 0))
      prevX = x1
      prevY = y1

      for i in [0...numPoints]
        newX = rf( prevX, prevX + jumpX)
        newY = rf(-jumpY, jumpY)
        points.push(new THREE.Vector3(newX, newY, 0))
        prevX = newX


      vertex = new THREE.Vector3(x2, y2, 0)
      points.push(vertex)
      points


    @strandGeometry = new THREE.Geometry()
    @strandGeometry.vertices.push(new THREE.Vector3(0, 0, 0))
    colors.push  new THREE.Color(0x000000)
    points = createPoints(0, 0, @outerRadius, 0, @numPoints)
    for i in [0...points.length]
      @strandGeometry.vertices.push points[i]
      @strandGeometry.vertices[i].originalVertex = points[i].clone()
      color = new THREE.Color(0x000000)
      light = map(i, 0, points.length-1, 0.5, 0.9)
      color.setHSL(0.469, .9, light)
      colors.push color

    @strandGeometry.colors = colors
    @sampleVertices = @strandGeometry.vertices.slice(1, @strandGeometry.vertices.length-2)

    material = new THREE.LineBasicMaterial
      vertexColors: THREE.VertexColors
      linewidth: 2

    angleBunch = rf(0, 0.5)
    for i in [0..@numLines]
      line = new THREE.Line(@strandGeometry, material)
      theta = (i/@numLines) * (Math.PI * 2)
      if i % 2 is 0
        line.rotation.z = i/@numLines * Math.PI * 2
      else
        line.rotation.z = -i/@numLines * Math.PI * 2 + (Math.PI) * angleBunch
      @containerObj.add(line)

    # ringGeo = new THREE.TorusGeometry(@outerRadius, 1, 10, 50)
    # ringMat = new THREE.MeshBasicMaterial
    #   # wireframe: true
    # ring = new THREE.Mesh ringGeo, ringMat
    # @containerObj.add ring

    @ripple()



  ripple: ()->
    vertex = @sampleVertices[@curVertexIndex]
    vertex.x += 20

    #set previous vertex back to 0
    @prevVertex?.set @prevVertex.originalVertex.x, @prevVertex.originalVertex.y, @prevVertex.originalVertex.z

    @curVertexIndex += @rippleDir
    if @curVertexIndex is @sampleVertices.length-1 or @curVertexIndex is 0
      # @rippleDir *= -1 
      @curVertexIndex = 0

    @prevVertex = vertex

    @strandGeometry.verticesNeedUpdate = true
    @strandGeometry.colorsNeedUpdate = true

    setTimeout ()=>
      @ripple()
    , 20
    

  
    

  update: ()->



module.exports = DreamCatcher