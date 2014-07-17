import QtQuick 2.0
import QtQuick.Controls 1.0
import "qrc:///"

ApplicationWindow {
	id: world
    visible: true
	width: 800
	height: 600
    title: "Collider Detector in Pocket"
    property real magneticField: 0.05

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
		z:0
		id: muonChamber
		startRadius: 370
		stopRadius: 630
		anchors.centerIn: parent
		intersections: 3
	}

	Detector{
		z:1
		id: calorimeters
		startRadius: 200
		stopRadius: 350
		anchors.centerIn: parent
	}

	Detector{
		z:2
		id: siliconDetector
		startRadius: 110
		stopRadius: 180
		anchors.centerIn: parent
	}

	BeamTube{
		z:3
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
        var id = Math.floor(Math.random() * 1000)
        p.launch(Math.random() * 2 *Math.PI, 2 + Math.random() * 10, determineParticle(id))
		particles.unshift(p)
	}

	function launchPair(){
		var p = particles.pop()
		var q = particles.pop()
        var angle = Math.random() * 2 *Math.PI
        var velocity = 2 + Math.random() * 10
        var id1 = Math.floor(Math.random() * 1000)
        var id2 = Math.floor(Math.random() * 1000)
        p.launch(angle, velocity, determineParticle(id1));
        q.launch(angle - Math.PI, velocity, determineParticle(id2));
		particles.unshift(p)
		particles.unshift(q)
	}

    function determineParticle(id){
        if (id % 5 == 0) { return "Electron"; }
        if (id % 5 == 1) { return "Positron"; }
        if (id % 5 == 2) { return "Proton"; }
        if (id % 5 == 3) { return "Antiproton"; }
        if (id % 5 == 4) { return "Neutron"; }
    }
}
