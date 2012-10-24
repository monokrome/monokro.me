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

	constructor: ($container) ->
		@viewportRatio = window.innerWidth / window.innerHeight
		@pixelRatio = window.devicePixelRatio or 1

		@scene = new THREE.Scene

		if Modernizr.webgl
			@renderer = new THREE.WebGLRenderer
		else
			@renderer = new THREE.CanvasRenderer

		@camera = new THREE.PerspectiveCamera 75, @viewportRatio, 1, 10000
		@camera.position.z = 400

		@geometry = new THREE.TextGeometry 'MK',
			size: 72
			height: 5
			curveSegments: 6
			font: 'source sans pro'
			weight: 'normal'
			style: 'normal'

		console.dir @geometry

		@material = new THREE.MeshBasicMaterial
			color: 0xff0000

		@mesh = new THREE.Mesh @geometry, @material
		@scene.add @mesh

		@resize()

		$container.append @renderer.domElement

		@animate()

	resize: ->
		@renderer.setSize window.innerWidth * @pixelRatio, window.innerHeight * @pixelRatio

jQuery ->
	$container = jQuery '#viewport-container'
	world = new World $container
