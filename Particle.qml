import QtQuick 2.0
import "qrc:///"
import "pdg.js" as PDG

Item{
	property string type: "Electron"
	property real mass: PDG.Particles[type].mass
    // Let's do more proper physics:
    // the 'lifetime' is the average time before
    // a particle decays, but the actual time varies
	property real lifetime: PDG.Particles[type].lifetime
    property real timeAlive: 1
    property real yVelocity: 0
    property real xVelocity: 0
    property real t: 0
	property real charge: PDG.Particles[type].charge
	//initial position of a particle at center of BeamTube
    x: beamTube.x + beamTube.width/2
    y: beamTube.y + beamTube.height/2

    NumberAnimation on t{
        id: particleAnimationT
        running: false
        from: 0
        to: timeAlive
        duration: timeAlive
        onStarted: {
            particle.color = "blue"
		}
        onStopped: {
            particle.visible = false
            trailFade.start()
        }
    }

    onTChanged: {
        var norm = Math.sqrt(Math.pow(xVelocity,2) + Math.pow(yVelocity,2))
        var forceDirection = Math.atan2(yVelocity,xVelocity) + charge * Math.PI/2
        xVelocity = xVelocity + world.magneticField * Math.cos(forceDirection)
        yVelocity = yVelocity + world.magneticField * Math.sin(forceDirection)
        var normalisationFactor = Math.sqrt(Math.pow(xVelocity,2) + Math.pow(yVelocity,2))
        xVelocity = (xVelocity / normalisationFactor) * norm
        yVelocity = (yVelocity / normalisationFactor) * norm

        x = x + xVelocity
        y = y + yVelocity

		trail.leaveTrail(x + particle.width / 2, y + particle.height / 2)
    }

    function launch(phi,velocityNorm){
        timeAlive = lifetime * Math.exp(2 * Math.random() - 1)
        x = beamTube.x + beamTube.width / 2 - 4  // Using - 4 gets things in the centre
        y = beamTube.y + beamTube.height / 2 - 4 // although it's dirty :D
        xVelocity = velocityNorm * Math.cos(phi) / mass
        yVelocity = velocityNorm * Math.sin(phi) / mass
        particle.visible = true;
        particleAnimationT.restart()
    }


	Rectangle{
		id: particle
        visible: false
		width:10
		height:10
		radius:10
		color: "blue"
	}
	Trail{
		id: trail
		visible: particle.visible
        NumberAnimation on opacity{id:trailFade; from: 1; to:0; duration: timeAlive;
            easing.type: Easing.OutCubic; running:false; onStopped:{trail.clearPath()}}
	}
}
