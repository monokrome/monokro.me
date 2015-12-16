var scene = new THREE.Scene(),
    renderer = new THREE.WebGLRenderer(), 
    camera = new THREE.PerspectiveCamera(
      75, window.innerWidth / window.innerHeight, 0.1, 1000
    ),

    monitorMaterial = new THREE.MeshBasicMaterial({
      color: 0x81c0f3,
    }),

    monitorGeometry = new THREE.BoxGeometry(1, 1, 1),
    monitor = new THREE.Mesh(monitorGeometry, monitorMaterial),

    keyboardMaterial = new THREE.MeshBasicMaterial({
      color: 0x60a0d1,
    }),

    keyboardGeometry = new THREE.BoxGeometry(0.8, 0.04, 0.4),
    keyboard = new THREE.Mesh(keyboardGeometry, keyboardMaterial),

    tabletopMaterial = new THREE.MeshBasicMaterial({
      color: 0xcecece,
    }),

    tabletopGeometry = new THREE.BoxGeometry(4, 0.08, 2),
    tabletop = new THREE.Mesh(tabletopGeometry, tabletopMaterial);



renderer.setSize(window.innerWidth, window.innerHeight);


scene.add(tabletop);
scene.add(keyboard);
scene.add(monitor);


camera.position.x = -1;
camera.position.y = .2;
camera.position.z = 2.4;
camera.rotation.x -= 0.1;
camera.rotation.y -= 0.3;

tabletop.position.x = 0.1;
tabletop.position.y = -0.5;
tabletop.position.z = 0.1;

monitor.rotation.y = -0.25;
monitor.position.x = 0.7;

keyboard.rotation.y += 0.16;
keyboard.position.x = 0.1;
keyboard.position.y = -0.4;
keyboard.position.z = 0.85;


function render() {
  requestAnimationFrame(render);
  renderer.render(scene, camera);
}


(function onDomLoaded() {
  if (document.readyState !== 'complete')
    return requestAnimationFrame(onDomLoaded);

  var bodyContents = document.body.innerHTML;
  document.body.innerHTML = '';
  document.body.appendChild(renderer.domElement);
  renderer.domElement.innerHTML = bodyContents;
  render();
})();
