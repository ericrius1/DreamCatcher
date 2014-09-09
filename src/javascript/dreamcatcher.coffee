rf = THREE.Math.randFloat
class DreamCatcher
  constructor: (@scene, @audioController)->
    @numLines = 11
    @radius = 50
    colors = []

    createPoints = (x1, y1, y2, x2, numPoints)->
      points = []
      points.push(new THREE.Vector3(x1, y1, 0))

      for i in [0...numPoints]
        points.push(new THREE.Vector3(rf(0, 40), rf(0, 40), 0))

      points.push(new THREE.Vector3(x2, y2, 0))
      points


    @strandGeometry = new THREE.Geometry()
    @strandGeometry.vertices.push(new THREE.Vector3(0, 0, 0))
    points = createPoints(0, 0, 50, 0, 10)
    for i in [0...points.length]
      
      @strandGeometry.vertices.push points[i]
      colors[i] = new THREE.Color(0x000000)
      colors[i].setHSL(0.4, 0.7, 0.7)


    @strandGeometry.colors = colors

    material = new THREE.LineBasicMaterial
      vertexColors: THREE.VertexColors

    for i in [0..@numLines]
      line = new THREE.Line(@strandGeometry, material)
      line.rotation.z = i/@numLines * Math.PI * 2
      @scene.add(line)

    ringGeo = new THREE.TorusGeometry(@radius, 1, 10, 50)
    ringMat = new THREE.MeshBasicMaterial
      # wireframe: true
    ring = new THREE.Mesh ringGeo, ringMat
    scene.add ring



  update: ()->



module.exports = DreamCatcher