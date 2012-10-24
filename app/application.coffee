animator = (world) ->
	# This function generates a function which calls world.animate, because
	# requestAnimationFrame doesn't allow you to pass a function inside of
	# an object.
	->
		world.animate()
		world.renderer.render world.scene, world.camera

class World
	animate: ->
		requestAnimationFrame animator @

		@mesh.rotation.x += 0.01
		@mesh.rotation.y += 0.01

	constructor: ($container) ->
		@viewportRatio = window.innerWidth / window.innerHeight
		@scene = new THREE.Scene

		if Modernizr.webgl
			@renderer = new THREE.WebGLRenderer
		else
			@renderer = new THREE.CanvasRenderer

		@camera = new THREE.PerspectiveCamera 75, @viewportRatio, 1, 10000
		@camera.position.z = 1000

		@geometry = new THREE.CubeGeometry 200, 200, 200
		@material = new THREE.MeshBasicMaterial
			color: 0xff0000

		@mesh = new THREE.Mesh @geometry, @material
		@scene.add @mesh

		@resize()

		$container.append @renderer.domElement

		@animate()

	resize: ->
		@renderer.setSize window.innerWidth, window.innerHeight

jQuery ->
	$container = jQuery '#viewport-container'
	world = new World $container
