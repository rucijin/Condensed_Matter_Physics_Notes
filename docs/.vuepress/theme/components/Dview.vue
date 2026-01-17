<script setup lang="ts">
    import { onMounted, onUnmounted } from 'vue';
    import { ref } from 'vue';
    import * as THREE from 'three';
    import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';
    import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader';

    const canvas = ref<HTMLCanvasElement>()
    onMounted(() => {
        if (!canvas.value) return;

        const renderer = new THREE.WebGLRenderer({ 
            canvas: canvas.value, 
            antialias: true,
            alpha: true
        });
        renderer.setPixelRatio(window.devicePixelRatio);

        const scene = new THREE.Scene();
        scene.background = new THREE.Color(0x202020);

        const camera = new THREE.PerspectiveCamera(
            45,
            canvas.value.clientWidth / canvas.value.clientHeight,
            0.1,
            100
        );
        camera.position.set(5, 5, 5);

        const controls = new OrbitControls(camera, canvas.value);
        controls.enableDamping = true;

        const grid = new THREE.GridHelper(10, 10);
        scene.add(grid);
        const boxGeo = new THREE.BoxGeometry(1, 1, 1);
        const boxMat = new THREE.MeshStandardMaterial({ color: 0x42b883 });
        const box = new THREE.Mesh(boxGeo, boxMat);
        box.position.y = 0.5;
        scene.add(box);

        const loader = new GLTFLoader();
        loader.load(
            '/models/test.glb',   // 把模型放 public/models 目录
            gltf => scene.add(gltf.scene),
            undefined,
            err => console.error(err)
        );

        const resizeObs = new ResizeObserver(() => {
        const { clientWidth, clientHeight } = canvas.value!;
        renderer.setSize(clientWidth, clientHeight, false);
        camera.aspect = clientWidth / clientHeight;
        camera.updateProjectionMatrix();
        });
        resizeObs.observe(canvas.value);

        let raf = 0
        const animate = () => {
            raf = requestAnimationFrame(animate)
            controls.update()
            renderer.render(scene, camera)
        };
        animate();

        onUnmounted(() => {
            resizeObs.disconnect()
            cancelAnimationFrame(raf)
            renderer.dispose()
            scene.traverse(obj => {
                if (obj instanceof THREE.Mesh) {
                    obj.geometry.dispose()
                    obj.material.dispose()
                }
            })
        });
});
</script>

<template>
  <div class="dview">
    <canvas ref="canvas" class="webgl"></canvas>
  </div>
</template>

<style scoped>
.dview {
  width: 100%;
  height: 100vh;
  position: hidden;
}
.webgl {
  width: 100%;
  height: 100%;
  display: block;
}
</style>