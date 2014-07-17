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
        var numberOfSingleEvents = 1 + Math.floor(Math.random() * 4)
        var numberOfPairEvents = Math.floor( Math.random() * 2)
        for (var i = numberOfSingleEvents; i>0; i--)
            launchSingle();
        for (var i = numberOfPairEvents; i>0; i--)
            launchPair();
	}

	function launchSingle(){
		var p = particles.pop()
        var id = Math.pow(-1, Math.floor(Math.random() * 1000)) * Math.floor(Math.random() * 1000)
        p.launch(Math.random() * 2 *Math.PI, 4 + Math.random() * 10, determineParticle(id))
		particles.unshift(p)
	}

	function launchPair(){
		var p = particles.pop()
		var q = particles.pop()
        var angle = Math.random() * 2 *Math.PI
        var velocity = 4 + Math.random() * 10
        var id1 = Math.pow(-1, Math.floor(Math.random() * 1000)) * Math.floor(Math.random() * 1000)
        var id2 = - id1
        p.launch(angle, velocity, determineParticle(id1));
        q.launch(angle - Math.PI, velocity, determineParticle(id2));
		particles.unshift(p)
		particles.unshift(q)
	}

    function determineParticle(id){
        var size = PDG.Particles["index"].cardinality
		if (id % size == 0)  { return "Photon"; }
        if (id % size == 1)  { return "Electron"; }
        if (id % size == -1) { return "Positron"; }
        if (id % size == 2)  { return "Proton"; }
        if (id % size == -2) { return "Antiproton"; }
        if (id % size == 3)  { return "Neutron"; }
        if (id % size == -3) { return "Antineutron"; }
        if (id % size == 4)  { return "Neutrino"; }
        if (id % size == -4) { return "Antineutrino"; }
    }

    function getMagneticField(radius){
        if(radius < muonChamber.stopRadius/2){
            return magneticField;
        }
		else return 0;
    }

    // Function for making particles lose energy as function
    // of which detector they are "in"
    function getEnergyLoss(radius, tracks, cals){
		if (!tracks && !cals)
			return 1.;
		else if (radius < siliconDetector.startRadius/2)
			return 1.;
		else if (radius > siliconDetector.startRadius/2 && radius < siliconDetector.stopRadius/2 && tracks)
            return 0.999;
		else if (radius > siliconDetector.stopRadius/2 && radius < calorimeters.stopRadius/2 && cals)
            return 0.9;
		else if (radius < calorimeters.stopRadius/2 && radius < muonChamber.stopRadius/2 && tracks)
            return 0.999;
		else
            return 1.;
    }

}
