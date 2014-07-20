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
            if ( PDG.Particles[type].leavesTrack || PDG.Particles[type].leavesEnergy )
                trailFade.start()
        }
    }

    onTChanged: {
        var radius = distanceToMiddle(x, y)
        var norm = PHYSICS.vectorMag(xVelocity, yVelocity)
                   * getEnergyLoss(radius, PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEnergy, type)
        var forceDirection = Math.atan2(yVelocity,xVelocity) + charge * Math.PI/2
        xVelocity = xVelocity + world.getMagneticField(radius) * Math.cos(forceDirection)
		yVelocity = yVelocity + world.getMagneticField(radius) * Math.sin(forceDirection)
        var normalisationFactor = PHYSICS.vectorMag(xVelocity, yVelocity)

		xVelocity = (xVelocity / normalisationFactor) * norm
        yVelocity = (yVelocity / normalisationFactor) * norm

        x = x + xVelocity
        y = y + yVelocity

        if (PDG.Particles[type].leavesTrack || PDG.Particles[type].leavesEnergy){
//            if (type == "Muon" || type == "Antimuon"){
//                if ( t % 2 == 0 )
//                    trail.leaveTrail(x + particle.size / 3, y + particle.size / 3,
//                         PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEnergy, radius);
//            }
//            else
                trail.leaveTrail(x + particle.size / 3, y + particle.size / 3,
                     PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEnergy, radius);
        }
    }

    function launch(phi, energy, particleType){
        type = particleType
        timeAlive = lifetime * Math.exp(2 * Math.random() - 1)
		x = beamTube.center.x - particle.size / 2
		y = beamTube.center.y - particle.size / 2
        xVelocity = world.c * Math.cos(phi) * PHYSICS.betaFromEMass(energy, mass)
        yVelocity = world.c * Math.sin(phi) * PHYSICS.betaFromEMass(energy, mass)
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
			id:trailFade; from: 1; to:0; duration: 2000;
			easing.type: Easing.InCubic; running:false; onStopped:{trail.clearPath()}
		}
	}

    function distanceToMiddle(x, y){
        return PHYSICS.distanceOf(beamTube.center.x, beamTube.center.y, x, y)
    }

}
