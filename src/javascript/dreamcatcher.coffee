_ = require 'underscore'
TWEEN = require 'tween.js'

rf = THREE.Math.randFloat
class DreamCatcher
  constructor: (@scene, @audioController)->
    @numLines = 22
    @outerRadius = 50
    @innerRadius = 1
    colors = []
    @curColIndex = 0
    @hue =  0.1
    @oldVertex
    @curVertexIndex = 0

    createPoints = (x1, y1, y2, x2, numPoints)->
      jumpX = 5
      jumpY = 5
      points = []
      points.push(new THREE.Vector3(x1, y1, 0))
      prevX = x1
      prevY = y1

      for i in [0...numPoints]
        newX = rf(prevX, prevX + jumpX)
        newY = rf(prevY, prevY + jumpY)
        points.push(new THREE.Vector3(newX, newY, 0))
        prevX = newX
        prevY = newY

      vertex = new THREE.Vector3(x2, y2, 0)
      points.push(vertex)
      points


    @strandGeometry = new THREE.Geometry()
    @strandGeometry.vertices.push(new THREE.Vector3(0, 0, 0))
    colors.push  new THREE.Color(0x000000)
    points = createPoints(0, 0, @outerRadius, 0, 11)
    for i in [0...points.length]
      points[i].originalX = points[i].x
      points[i].originalY = points[i].y
      @strandGeometry.vertices.push points[i]

      colors.push new THREE.Color(0x000000)


    @strandGeometry.colors = colors
    @sampleVertices = @strandGeometry.vertices.slice(1, @strandGeometry.vertices.length)

    material = new THREE.LineBasicMaterial
      vertexColors: THREE.VertexColors
      linewidth: 2

    angleBunch = rf(.01, .2)
    for i in [0..@numLines]
      line = new THREE.Line(@strandGeometry, material)
      theta = (i/@numLines) * (Math.PI * 2)
      if i % 2 is 0
        line.rotation.z = i/@numLines * Math.PI * 2
      else
        line.rotation.z = -i/@numLines * Math.PI * 2 + Math.PI * angleBunch
      @scene.add(line)

    ringGeo = new THREE.TorusGeometry(@outerRadius, 1, 10, 50)
    ringMat = new THREE.MeshBasicMaterial
      # wireframe: true
    ring = new THREE.Mesh ringGeo, ringMat
    scene.add ring



  updateBeat: ()->
    if @curColIndex < @strandGeometry.vertices.length
      @strandGeometry.colors[@curColIndex++].setHSL(@hue+=.1, 0.7, 0.7)

    if @oldVertex?
      @oldVertex.x = @oldVertex.originalX
  
    vertex = @sampleVertices[@curVertexIndex++]
    if @curVertexIndex is @sampleVertices.length then @curVertexIndex = 0
    vertex.x += 10
    @oldVertex = vertex

  
    
    @strandGeometry.verticesNeedUpdate = true

    @strandGeometry.colorsNeedUpdate = true

  update: ()->



module.exports = DreamCatcher