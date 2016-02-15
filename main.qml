import QtQuick 2.0
import QtQuick.Controls 1.0
import "qrc:///"
import "pdg.js" as PDG
import "Physics.js" as PHYSICS
import "Dijet.js" as DIJET
import "Higgs.js" as HIGGS

ApplicationWindow {
	id: world
    visible: true
    width: 1200
    height: 900
    title: "Collider Detector in Pocket"
    property real magneticField: 0.07
    property real c: PHYSICS.c

	//Filling of the Particle Array
	property var particles: []

	Component.onCompleted:{
        for (var i=0; i<1000; i++){
			var p = Qt.createQmlObject('import QtQuick 2.0; Particle{}',world, "ParticleCreation");
			particles.push(p);
		}
	}

	//Detectors in reversed order (because of drawing)
    //Need two different radii since animation is not 1-to-1 with spatial coordinates
	Detector{
		z:0
		id: muonChamber
        startRadius: 490
        stopRadius: 800
        spatialStart: 480
        spatialStop: 780
		anchors.centerIn: parent
	}

	HdCalorimeter{
		z:2
		id: hdCalorimeters
        startRadius: 280
		stopRadius: 480
        spatialStart: 300
        spatialStop: 480
		anchors.centerIn: parent
	}

	EmCalorimeter{
		z:1
		id: emCalorimeters
		startRadius: 270
		stopRadius: 320
        spatialStart: 260
        spatialStop: 300
		anchors.centerIn: parent
	}

	Detector{
		z:3
		id: siliconDetector
        startRadius: 50
        stopRadius: 280
        spatialStart: 40
        spatialStop: 270
		anchors.centerIn: parent
	}

	BeamTube{
		z: 4
		id: beamTube
		anchors.centerIn: parent
		property point center: Qt.point(x + width/2, y + height/2)
	}

    function collisionEvent(){
        var typeOfEvent = selectEventType.currentText
        if (typeOfEvent == "Dijet") {
            var evNo = Math.floor(Math.random() * DIJET.Events["numberOfEvents"].numEv)
            var noOfParts = DIJET.Events["Event"+evNo]["numberOfParticles"].numPart
            var randPhi = Math.random() * 2 * Math.PI
            for (var i = 0; i < noOfParts; i++)
                launchSingle(DIJET.Events["Event"+evNo]["particle"+i].pdgId, DIJET.Events["Event"+evNo]["particle"+i].energy, DIJET.Events["Event"+evNo]["particle"+i].azimuthalAngle + randPhi,
                             DIJET.Events["Event"+evNo]["particle"+i].charge)
        }
        else if (typeOfEvent == "Higgs") {
            var evNo = Math.floor(Math.random() * HIGGS.Events["numberOfEvents"].numEv)
            var noOfParts = HIGGS.Events["Event"+evNo]["numberOfParticles"].numPart
            var randPhi = Math.random() * 2 * Math.PI
            for (var i = 0; i < noOfParts; i++)
                launchSingle(HIGGS.Events["Event"+evNo]["particle"+i].pdgId, HIGGS.Events["Event"+evNo]["particle"+i].energy, HIGGS.Events["Event"+evNo]["particle"+i].azimuthalAngle + randPhi,
                             HIGGS.Events["Event"+evNo]["particle"+i].charge)
        }
        else {
            var numberOfSingleEvents = 1 + Math.floor(Math.random() * 5)
            var numberOfPairEvents = Math.floor( Math.random() * 5)
            for (var i = numberOfSingleEvents; i>0; i--)
                launchSingle();
            for (var i = numberOfPairEvents; i>0; i--)
                launchPair();
        }
    }

    function launchSingle(id, energy, phi, charge){

        id = typeof id !== 'undefined' ? id : -1;
        energy = typeof energy !== 'undefined' ? energy : -1.0;
        phi = typeof phi !== 'undefined' ? phi : Math.random() * 2 *Math.PI;
		var p = particles.pop()

        if (id == -1) var type = PDG.determineParticle(Math.pow(-1, Math.floor(Math.random() * 1000)) * Math.floor(Math.random() * 1000))
        else var type = PDG.determinePdgId(id, charge)
        if (energy == -1.0) energy = 1 + Math.random() * 10
        if (energy > 2.) p.launch(phi, energy, type)

		particles.unshift(p)
	}

	function launchPair(){
		var p = particles.pop()
		var q = particles.pop()

		var angle = Math.random() * 2 *Math.PI
        var energy = 1 + Math.random() * 10
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
            return 1.;
        else if (isInEmCals(radius))
            return EMCals;
        else if (isInHdCals(radius))
            return hadCals;
        else if (isInMuonChambers(radius) && tracks)
            return 1.;
        else return 1.;
    }

    function isInTrackers(radius){
        if (radius < siliconDetector.spatialStart/2.)
            return false;
        else if (radius > siliconDetector.spatialStart/2. && radius < siliconDetector.spatialStop/2.)
            return true;
        else
            return false;
    }

	function isInEmCals(radius){
        if (radius < emCalorimeters.spatialStart/2.)
            return false;
        else if (radius > emCalorimeters.spatialStart/2. && radius < emCalorimeters.spatialStop/2.)
            return true;
        else
            return false;
    }

	function isInHdCals(radius){
        if (radius < hdCalorimeters.spatialStart/2.)
			return false;
        else if (radius > hdCalorimeters.spatialStart/2. && radius < hdCalorimeters.spatialStop/2.)
			return true;
		else
			return false;
	}

    function isInMuonChambers(radius){
        if (radius < muonChamber.spatialStart/2)
            return false;
        else if (radius > muonChamber.spatialStart/2 && radius < muonChamber.spatialStop/2)
            return true;
        else
            return false;
    }

    ComboBox {
      id: selectEventType
      editable: false
      model: ListModel {
       id: eventType
       ListElement { text: "Dijet"; color: "Yellow" }
       ListElement { text: "Higgs"; color: "Green" }
       ListElement { text: "Random (note: unphysical)"; color: "Brown" }
     }
     onAccepted: {
      if (combo.find(currentText) === -1) {
         model.append({text: editText})
         currentIndex = combo.find(editText)
       }
     }
   }

}
