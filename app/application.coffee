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
		@camera.position.z = 180

		@geometry = new THREE.TextGeometry 'monokro.me',
			size: 16
			height: 5
			curveSegments: 20
			font: 'source sans pro'
			weight: 'normal'
			style: 'normal'

		@material = new THREE.MeshBasicMaterial
			color: 0x000033

		@mesh = new THREE.Mesh @geometry, @material
		@mesh.scale.z = 0.05

		@scene.add @mesh

		@resize()

		$container.append @renderer.domElement

		@animate()

	resize: ->
		@renderer.setSize window.innerWidth * @pixelRatio, window.innerHeight * @pixelRatio

jQuery ->
	$container = jQuery '#viewport-container'
	world = new World $container

	$window = jQuery window
	$window.on 'resize', ->
		world.resize.apply world, []
