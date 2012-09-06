animation_factory = (renderer, scene, camera) ->
  animation_state =
    active: true
    renderer: renderer
    camera: camera
    scene: scene

  animate = ->
    if not animation_state.active
      jQuery(animation_state).trigger 'deactivate'
    else
      jQuery(animation_state).trigger 'animate'

      requestAnimationFrame animate
      animation_state.renderer.render animation_state.scene, animation_state.camera

      animation_state

initialize_gl = (callback) ->
  camera = new THREE.PerspectiveCamera 75, window.innerWidth / window.innerHeight, 1, 10000
  camera.position.z = 1000

  scene = new THREE.Scene

  renderer = new THREE.WebGLRenderer
    precision: 'highp'

  renderer.setSize window.innerWidth, window.innerHeight

  $canvas = jQuery(renderer.domElement)
  $canvas.attr 'id', 'canvas'

  $canvas.appendTo '#canvas-container'

  callback renderer, scene, camera

jQuery ->

