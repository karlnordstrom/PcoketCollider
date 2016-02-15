import QtQuick 2.0
import "qrc:///"
import "pdg.js" as PDG
import "Physics.js" as PHYSICS

Item{
	property string type: "Electron"
	property real mass: PDG.Particles[type].mass
	property real lifetime: PDG.Particles[type].lifetime
    property real timeAlive: 1
    property real yVelocity: 0
    property real xVelocity: 0
    property real energy: 0
    property int t: 0
	property real charge: PDG.Particles[type].charge

    NumberAnimation on t{
        id: particleAnimationT
        running: false
        from: 0
        to: timeAlive
        duration: timeAlive
		onStarted: {particle.color = PDG.Particles[type].color}
        onStopped: {
            particle.visible = false
            trailFade.start()
        }
    }

    onTChanged: {
        var radius = distanceToMiddle(x, y)
        var newEnergy = energy * getEnergyLoss(radius, PDG.Particles[type].leavesTrack,
                            PDG.Particles[type].leavesEMEnergy, PDG.Particles[type].leavesHadEnergy, type)
        var lostEnergy = energy - newEnergy
        energy = newEnergy
        var normalisationFactor = PHYSICS.vectorMag(xVelocity, yVelocity)
        var norm = PHYSICS.c
        if (!fuzzyEquals(mass, 0))
            var norm = PHYSICS.betaFromEMass(energy, mass) * PHYSICS.c
        var forceDirection = Math.atan2(yVelocity,xVelocity) + charge * Math.PI/2
        xVelocity = xVelocity + world.getMagneticField(radius) * Math.cos(forceDirection)
        yVelocity = yVelocity + world.getMagneticField(radius) * Math.sin(forceDirection)

		xVelocity = (xVelocity / normalisationFactor) * norm
        yVelocity = (yVelocity / normalisationFactor) * norm

        x = x + xVelocity
        y = y + yVelocity

        trail.leaveTrail(x, y, lostEnergy,
             PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEMEnergy, PDG.Particles[type].leavesHadEnergy, radius);
        if (energy < 0.1){
            particle.visible = false
            trailFade.start()
        }
    }

    function launch(phi, launchEnergy, particleType){
        type = particleType
        energy = launchEnergy
        timeAlive = lifetime
        x = beamTube.center.x
        y = beamTube.center.y
        if(fuzzyEquals(mass, 0)){
            xVelocity = world.c * Math.cos(phi)
            yVelocity = world.c * Math.sin(phi)
        }
        else {
            xVelocity = world.c * Math.cos(phi) * PHYSICS.betaFromEMass(energy, mass)
            yVelocity = world.c * Math.sin(phi) * PHYSICS.betaFromEMass(energy, mass)
        }
        particle.visible = true;
        particleAnimationT.restart()
    }

	Rectangle{
		id: particle
		z:2
		property int size: PDG.Particles[type].size
		visible: false
		width:size
		height:size
		radius:size
		color: PDG.Particles[type].color
	}

	Trail{
		id: trail
		z:1
		visible: particle.visible
		NumberAnimation on opacity{
            id:trailFade; from: 1; to:0; duration: 50;
			easing.type: Easing.InCubic; running:false; onStopped:{trail.clearPath()}
		}
	}

    function distanceToMiddle(x, y){
        return PHYSICS.distanceOf(beamTube.center.x, beamTube.center.y, x, y)
    }

    function fuzzyEquals(x, y){
        if (x - y < 0.0001) return true;
        else return false;
    }

}
