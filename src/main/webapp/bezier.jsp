<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Example</title>
	<meta charset="UTF-8">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/three.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/dat.gui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/OrbitControls.js"></script>
	<style>
		body {
			margin: 50px;
			overflow: hidden;
		}
		.dg{
			margin-top: 20px;
		}

	</style>
</head>
<jsp:include page="/header_nlogout.jsp"/>
<body>
<div id="WebGL-output">

	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			var scene = new THREE.Scene();
			var camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
			var cameraControls = new THREE.OrbitControls(camera);
			var renderer = new THREE.WebGLRenderer({antialias: true});
			renderer.setClearColor(0xEEEEEE);
			renderer.setSize(window.innerWidth, window.innerHeight);
			var axisHelper = new THREE.AxisHelper(20);

			$(window).on("resize", function() {
				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();
				renderer.setSize(window.innerWidth, window.innerHeight);
				renderScene();
			});

			camera.position.x = -60;
			camera.position.y = 50;
			camera.position.z = -40;
			camera.lookAt(new THREE.Vector3(20,0,15));
			camera.updateProjectionMatrix();
			$(cameraControls).on("change", renderScene);
			cameraControls.target = new THREE.Vector3(20,0,15);




			// interactive controls
			var controls = new function() {
				this.color = 0x17a6ff;
				this.x = 0.0;
				this.y = 0.0;
				this.z = 0.0;
				this.showControlPoints = false;
				this.wireframe = false;
				this.bezierCurves = 51;
				this.interactiveCamera = true;
				this.axisHelper = false;
			}

			var gui = new dat.GUI({width:370});

			gui.addColor(controls, "color").name("Color").onChange(function(c) {
				bezierSurfaceMaterial.color.setHex(c);
				setControlPointsColor(c);
				renderScene();
			});

			gui.add(controls, "wireframe").name("Wireframe").onChange(function(v) {
				bezierSurfaceMaterial.wireframe = v;
				renderScene();
			});

			gui.add(controls, "bezierCurves").min(10).max(100).step(1).name("Bezier Curves").onFinishChange(function(n) {
					bezierCurveDivisions = n-1;  // interpolation will give additional 1 bezier curve
					redrawBezierSurface();
					renderScene();
			});

			gui.add(controls, "interactiveCamera").name("Interactive Camera").onChange(function(v) {
				cameraControls.enabled = v;
			});

			gui.add(controls, "axisHelper").name("Axis Helper").onChange(function() {
				if(v) scene.add(axisHelper);
				else scene.remove(axisHelper);
				renderScene();
			});

			var controlx, controly, controlz;
			gui.add(controls, "showControlPoints").name("Show Control Points").onChange(function(visibility) {
				if (visibility) {
					controlx = gui.add(controls, "x").listen();
					controly = gui.add(controls, "y").listen();
					controlz = gui.add(controls, "z").listen();
				} else {
					gui.remove(controlx);
					gui.remove(controly);
					gui.remove(controlz);
				}

				updateActivePointControls();
				setControlPointsVisibility(visibility);
				renderScene();
			});
			
			function updateActivePointControls() {
				controls.x = activeControlPoint.position.x;
				controls.y = activeControlPoint.position.y;
				controls.z = activeControlPoint.position.z;
				controls.x.toFixed(2);
			}





			// working with bezier curves and surface
			var bezierCurveDivisions = 50;
			var bezierSurface, bezierSurfaceGeometry, bezierSurfaceMaterial;

			var bezierControlPoints = [
				[new THREE.Vector3(-10, 10, 0),
				new THREE.Vector3(0, 7, 0),
				new THREE.Vector3(15, 3, 0),
				new THREE.Vector3(30, 8, 0)],
				[new THREE.Vector3(-10, 0, 10),
				new THREE.Vector3(-5, 15, 10),
				new THREE.Vector3(20, 10, 10),
				new THREE.Vector3(30, 5, 10)],
				[new THREE.Vector3(-10, 5, 20),
				new THREE.Vector3(-5,-10, 20),
				new THREE.Vector3(10, 10, 20),
				new THREE.Vector3(30, 0, 20)],
				[new THREE.Vector3(-10, 4, 30),
				new THREE.Vector3(-5, 8, 30),
				new THREE.Vector3(20, 6, 30),
				new THREE.Vector3(30, 4, 30)]
			]

			function redrawBezierSurface() {
				scene.remove(bezierSurface);

				var basicBezierModel = [];  // 4 bezier curves calculated from bezier control points

				// calculating basic bezier model (main 4 bezier curves)
				for (var i=0; i < bezierControlPoints.length; i++) {
					var bezier = new THREE.CubicBezierCurve3(
						bezierControlPoints[i][0],
						bezierControlPoints[i][1],
						bezierControlPoints[i][2],
						bezierControlPoints[i][3]
					)
					basicBezierModel.push( bezier.getPoints(bezierCurveDivisions) );
				}


				var bezierCurvesVertices = [];

				// calculating full bezier model (50 bezier curves in one direction, each containing 50 vertices)
				for (var i=0; i <= bezierCurveDivisions; i++) {
					var bezier = new THREE.CubicBezierCurve3(
						basicBezierModel[0][i],
						basicBezierModel[1][i],
						basicBezierModel[2][i],
						basicBezierModel[3][i]
					)

					bezierCurvesVertices = bezierCurvesVertices.concat( bezier.getPoints(bezierCurveDivisions) );
				}


				// now we've got full bezier model, it's time to create bezier surface and add it to the scene
				var bezierSurfaceVertices = bezierCurvesVertices;
				var bezierSurfaceFaces = [];

				// creating faces from vertices
				var v1, v2, v2;  // vertex indices in bezierSurfaceVertices array
				for (var i=0; i < bezierCurveDivisions; i++) {
					for (var j=0; j < bezierCurveDivisions; j++) {
						v1 = i * (bezierCurveDivisions + 1) + j;
						v2 = (i+1) * (bezierCurveDivisions + 1) + j;
						v3 = i * (bezierCurveDivisions + 1) + (j+1);
						bezierSurfaceFaces.push( new THREE.Face3(v1, v2, v3) );
						
						v1 = (i+1) * (bezierCurveDivisions + 1) + j;
						v2 = (i+1) * (bezierCurveDivisions + 1) + (j+1);
						v3 = i * (bezierCurveDivisions + 1) + (j+1);
						bezierSurfaceFaces.push( new THREE.Face3(v1, v2, v3) );
					}
				}

				bezierSurfaceGeometry = new THREE.Geometry();
				bezierSurfaceGeometry.vertices = bezierSurfaceVertices;
				bezierSurfaceGeometry.faces = bezierSurfaceFaces;
				bezierSurfaceGeometry.computeFaceNormals();
				bezierSurfaceGeometry.computeVertexNormals();
				bezierSurfaceMaterial = new THREE.MeshLambertMaterial({color: controls.color, wireframe: controls.wireframe});
				bezierSurface = new THREE.Mesh(bezierSurfaceGeometry, bezierSurfaceMaterial);
				bezierSurface.material.side = THREE.DoubleSide;
				scene.add(bezierSurface);
			}

			redrawBezierSurface();





			// drawing control points (spheres)
			var activeControlPoint;
			var controlPoints = [];

			(function() {
				for (var i=0; i < 4; i++) {  // 4 control points in one direction
					for (var j=0; j < 4; j++) {  // 4 control points in another direction
						if (i == 0 && j == 0) {  // first control point becomes active control point
							var controlPointGeometry = new THREE.SphereGeometry(0.7,10,10);
						} else {
							var controlPointGeometry = new THREE.SphereGeometry(0.7,10,10);
						}
						var controlPointMaterial = new THREE.MeshLambertMaterial({color: 0xffffff - controls.color});
						var controlPoint = new THREE.Mesh(controlPointGeometry, controlPointMaterial);
						controlPoint.name = + i.toString() + "-" + j.toString();
						controlPoint.position.x = bezierControlPoints[i][j].x;
						controlPoint.position.y = bezierControlPoints[i][j].y;
						controlPoint.position.z = bezierControlPoints[i][j].z;
						controlPoint.visible = false;
						if (i==0 && j==0) {
							controlPoint.scale.set(1.5, 1.5, 1.5);
							activeControlPoint = controlPoint;
						}

						controlPoints.push(controlPoint);
						scene.add(controlPoint);
					}
				}
			}) ();

			// set control points visible or invisible
			function setControlPointsVisibility(visibility) {
				$.each(controlPoints, function(k, v) {
					v.visible = visibility;
				});
			}


			// set color of control points
			function setControlPointsColor(color) {
				$.each(controlPoints, function(k, v) {
					v.material.color.setHex(0xffffff - controls.color);
				});
			}


			function updateActiveControlPointPosition(x, y, z) {
				activeControlPoint.position.set(x, y, z);
				var i = activeControlPoint.name.split("-");  // active control point index
				bezierControlPoints[ i[0] ][ i[1] ] = new THREE.Vector3(x, y, z);
				updateActivePointControls();
				redrawBezierSurface();
				renderScene();
			}


			document.addEventListener("mousedown", onControlPointClick, true);  // done with pure javascript (without jquery because jquery doesn't support event capturing, which is essential if we want to avoid bugs with mousedown event, which is used for both rotation and placement of control points)

			function onControlPointClick(e) {
				var mouse = new THREE.Vector2();
				var raycaster = new THREE.Raycaster();

				mouse.x = (e.clientX / renderer.domElement.width) * 2 - 1;
				mouse.y = - (e.clientY / renderer.domElement.height) * 2 + 1;
				raycaster.setFromCamera(mouse, camera);

				var intersectedObjects = raycaster.intersectObjects(controlPoints);

				if (intersectedObjects.length > 0) {
					cameraControls.enabled = false;  // disabling camera rotation

					var newActiveControlPoint = intersectedObjects[0].object;

					if (newActiveControlPoint.visible) {
						var oldActiveControlPoint = activeControlPoint;

						oldActiveControlPoint.scale.set(1, 1, 1);
						newActiveControlPoint.scale.set(1.5, 1.5, 1.5);

						activeControlPoint = newActiveControlPoint;

						updateActivePointControls();
						renderScene();

						var planeNormal = activeControlPoint.position.clone().sub(camera.position);
						var plane = new THREE.Plane();
						plane.setFromNormalAndCoplanarPoint(planeNormal, activeControlPoint.position);

						$(document).on("mousemove", function(e) {
							var mouseMove = new THREE.Vector3();
							mouseMove.x = (e.clientX / renderer.domElement.width) * 2 - 1;
							mouseMove.y = - (e.clientY / renderer.domElement.height) * 2 + 1;
							mouseMove.z = 1;

							mouseMove.unproject(camera);
							var ray = new THREE.Ray(camera.position, mouseMove.sub(camera.position).normalize());
							var intersection = ray.intersectPlane(plane);

							updateActiveControlPointPosition(intersection.x, intersection.y, intersection.z);
						});

						$(document).on("mouseup", function(e) {
							$(document).off("mousemove");
							$(document).off("mouseup");
							cameraControls.enabled = true;  // enabling camera controls again
						});
					}
				}
			}

				     






			// all kinds of lights
			var ambientLight = new THREE.AmbientLight(0x0c0c0c);
			scene.add(ambientLight);

			var spotLightBelow = new THREE.SpotLight(0xffffff);
			spotLightBelow.position.set(20, -40, 20);
			spotLightBelow.target = bezierSurface;
			spotLightBelow.exponent = 5;
			scene.add(spotLightBelow);

			var spotLightAbove = new THREE.SpotLight(0xffffff);
			spotLightAbove.position.set(20,40,20);
			spotLightAbove.target = bezierSurface;
			spotLightAbove.exponent = 3;
			scene.add(spotLightAbove);   






			// functions for rendering and updating scene
			function renderScene() {
				renderer.render(scene, camera);
			}
			
			function update() {
				cameraControls.update();
				requestAnimationFrame(update);
			}
			update();

			$("#WebGL-output").append(renderer.domElement);
			renderScene();
		});
	</script>
</body>
</html> 
