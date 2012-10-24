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
		# TODO: Retina.
		# @pixelRatio = window.devicePixelRatio or 1
		@pixelRatio = 1

		@scene = new THREE.Scene

		if Modernizr.webgl
			@renderer = new THREE.WebGLRenderer
		else
			@renderer = new THREE.CanvasRenderer

		@camera = new THREE.PerspectiveCamera 60, @viewportRatio, 1, 10000
		@camera.position.z = 180

		@textGeometry = new THREE.TextGeometry 'monokro.me',
			size: 16
			height: 5
			curveSegments: 20
			font: 'source sans pro'
			weight: 'normal'
			style: 'normal'

		@logoGeometry = new THREE.TextGeometry 'MK',
			size: 64
			height: 5
			curveSegments: 20
			font: 'source sans pro'
			weight: 'normal'
			style: 'normal'

		@material = new THREE.MeshBasicMaterial
			color: 0x000033

		@textMesh = new THREE.Mesh @textGeometry, @material
		@textMesh.scale.z = 0.05

		@logoMesh = new THREE.Mesh @logoGeometry, @material
		@logoMesh.scale.z = 0.05

		for mesh in [@logoMesh, @textMesh]
			@scene.add mesh

			mesh.position.x -= 68

			mesh.properties.initialPosition =
				x: mesh.position.x
				y: mesh.position.y
				z: mesh.position.z

			mesh.properties.initialRotation =
				x: mesh.rotation.x
				y: mesh.rotation.y
				z: mesh.rotation.z

		@textMesh.position.y -= 16
		@textMesh.rotation.x += 0.5

		@logoMesh.rotation.x -= 0.5

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
