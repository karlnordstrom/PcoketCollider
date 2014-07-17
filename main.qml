import QtQuick 2.0
import QtQuick.Controls 1.0
import "qrc:///"

ApplicationWindow {
	id: world
    visible: true
	width: 800
	height: 600
    // Let's not call it CMS!!
    title: "Collider Detector in Pocket"
    property real magneticField: 0.2

	//Filling of the Particle Array
	property var particles: []

	Component.onCompleted:{
		for (var i=0; i<100; i++){
			var p = Qt.createQmlObject('import QtQuick 2.0; Particle{}',world, "ParticleCreation");
			particles.push(p);
		}
	}

	//Detectors in reversed order (because of drawing)
    Detector{
		id: muonChamber
		startRadius: 370
		stopRadius: 630
		anchors.centerIn: parent
	}

	Detector{
		id: calorimeters
		startRadius: 200
		stopRadius: 350
		anchors.centerIn: parent
	}

	Detector{
		id: siliconDetector
		startRadius: 110
		stopRadius: 180
		anchors.centerIn: parent
	}

	BeamTube{
		id: beamTube
		anchors.centerIn: parent
	}

	function collisionEvent()
	{
        var numberOfSingleEvents = 1 + Math.floor(Math.random() * 4)
        var numberOfPairEvents = Math.floor( Math.random() * 2)
        for (var i = numberOfSingleEvents; i>0; i--)
			launchSingle();
        for (var i = numberOfPairEvents; i>0; i--)
            launchPair();
	}

	function launchSingle(){
		var p = particles.pop()
        p.launch(Math.random() * 2 *Math.PI, 2 + Math.random() * 10)
		particles.unshift(p)
	}

	function launchPair(){
		var p = particles.pop()
		var q = particles.pop()
		var x = Math.random() * world.width
		var y = Math.random() * world.height
        var angle = Math.random() * 2 *Math.PI
        var velocity = 2 + Math.random() * 10
        p.launch(angle, velocity);
        q.launch(angle - Math.PI, velocity);
		particles.unshift(p)
		particles.unshift(q)
	}
}
