import QtQuick 2.0
import QtQuick.Controls 1.0
import "qrc:///"
import "pdg.js" as PDG
import "Physics.js" as PHYSICS

ApplicationWindow {
	id: world
    visible: true
    width: 1200
    height: 900
    title: "Collider Detector in Pocket"
    property real magneticField: 0.5
    property real c: PHYSICS.c

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
        startRadius: 500
        stopRadius: 800
		anchors.centerIn: parent
		intersections: 3
	}

	HdCalorimeter{
		z:2
		id: hdCalorimeters
		startRadius: 280
		stopRadius: 480
		anchors.centerIn: parent
	}

	EmCalorimeter{
		z:1
		id: emCalorimeters
		startRadius: 270
		stopRadius: 320
		anchors.centerIn: parent
	}

	Detector{
		z:3
		id: siliconDetector
		startRadius: 110
		stopRadius: 270
		anchors.centerIn: parent
	}

	BeamTube{
		z: 4
		id: beamTube
		anchors.centerIn: parent
		property point center: Qt.point(x + width/2, y + height/2)
	}

	function collisionEvent(){
        var numberOfSingleEvents = 1 + Math.floor(Math.random() * 5)
        var numberOfPairEvents = Math.floor( Math.random() * 5)
        for (var i = numberOfSingleEvents; i>0; i--)
            launchSingle();
        for (var i = numberOfPairEvents; i>0; i--)
            launchPair();
	}

	function launchSingle(){
		var p = particles.pop()

        var id = Math.pow(-1, Math.floor(Math.random() * 1000)) * Math.floor(Math.random() * 1000)
        p.launch(Math.random() * 2 *Math.PI, 40 + Math.random() * 40, PDG.determineParticle(id))

		particles.unshift(p)
	}

	function launchPair(){
		var p = particles.pop()
		var q = particles.pop()

		var angle = Math.random() * 2 *Math.PI
        var energy = 40 + Math.random() * 40
        var id1 = Math.pow(-1, Math.floor(Math.random() * 1000)) * Math.floor(Math.random() * 1000)
        var id2 = - id1
        p.launch(angle, energy, PDG.determineParticle(id1));
        q.launch(angle - Math.PI, energy, PDG.determineParticle(id2));

		particles.unshift(p)
		particles.unshift(q)
	}

    function getMagneticField(radius){
        if (isInTrackers(radius))
			return magneticField;
		else if (isInEmCals(radius)||isInHdCals(radius))
            return 0;
        else if (isInMuonChambers(radius))
            return -magneticField/2;
        else return 0;
	}

    function getEnergyLoss(radius, tracks, EMCals, hadCals, type){
        if (!tracks && EMCals == 1. && hadCals== 1.) return 1.;
        else if (isInTrackers(radius) && tracks)
            return 0.95;
        else if (isInEmCals(radius))
            return EMCals;
        else if (isInHdCals(radius))
            return hadCals;
        else if (isInMuonChambers(radius) && tracks)
            return 0.95;
        else return 1.;
    }

    function isInTrackers(radius){
        if (radius < siliconDetector.startRadius/2)
            return false;
        else if (radius > siliconDetector.startRadius/2 && radius < siliconDetector.stopRadius/2)
            return true;
        else
            return false;
    }

	function isInEmCals(radius){
		if (radius < emCalorimeters.startRadius/2)
            return false;
		else if (radius > emCalorimeters.startRadius/2 && radius < emCalorimeters.stopRadius/2)
            return true;
        else
            return false;
    }

	function isInHdCals(radius){
		if (radius < hdCalorimeters.startRadius/2)
			return false;
		else if (radius > hdCalorimeters.startRadius/2 && radius < hdCalorimeters.stopRadius/2)
			return true;
		else
			return false;
	}

    function isInMuonChambers(radius){
        if (radius < muonChamber.startRadius/2)
            return false;
        else if (radius > muonChamber.startRadius/2 && radius < muonChamber.stopRadius/2)
            return true;
        else
            return false;
    }
}
