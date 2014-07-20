import QtQuick 2.0
import QtQuick.Controls 1.0
import "qrc:///"
import "pdg.js" as PDG

ApplicationWindow {
	id: world
    visible: true
    width: 1200
    height: 900
    title: "Collider Detector in Pocket"
    property real magneticField: 0.5
    property real c: 10

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

	Detector{
		z:1
		id: calorimeters
        startRadius: 270
        stopRadius: 480
		anchors.centerIn: parent
	}

	Detector{
		z:2
		id: siliconDetector
		startRadius: 110
        stopRadius: 250
		anchors.centerIn: parent
	}

	BeamTube{
		z:3
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
        var velocity = 40 + Math.random() * 40
        var id1 = Math.pow(-1, Math.floor(Math.random() * 1000)) * Math.floor(Math.random() * 1000)
        var id2 = - id1
        p.launch(angle, velocity, PDG.determineParticle(id1));
        q.launch(angle - Math.PI, velocity, PDG.determineParticle(id2));

		particles.unshift(p)
		particles.unshift(q)
	}

    function getMagneticField(radius){
        if (isInTrackers(radius))
			return magneticField;
        else if (isInCals(radius))
            return 0;
        else if (isInMuonChambers(radius))
            return -magneticField/2;
        else return 0;
	}

    function getEnergyLoss(radius, tracks, cals, type){
        var EMStopper = 1.0
        if ( type == "Photon" ) EMStopper = 0.8
        if (!tracks && !cals) return 1.;
        else if (isInTrackers(radius) && tracks)
            return 0.999;
        else if (isInCals(radius) && cals)
            return 0.9 * EMStopper;
        else if (isInMuonChambers(radius) && tracks)
            return 0.999;
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

	function isInCals(radius){
        if (radius < calorimeters.startRadius/2)
            return false;
        else if (radius > calorimeters.startRadius/2 && radius < calorimeters.stopRadius/2)
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
