import QtQuick 2.0
import "qrc:///"

Item{
    property real mass: 1
    property real lifetime: 10000
    property real yVelocity: -3
    property real xVelocity: 3
    property real t: 0
    x: beamTube.x + beamTube.width/2
    y: beamTube.y + beamTube.height/2

    NumberAnimation on t{
        id: particleAnimationT
        running: false
        from: 0
        to: lifetime
        duration: lifetime
        onStarted: {
            particle.color = "blue"
        }
        onStopped: {
            particle.visible = false
        }
    }

    onTChanged: {

        var norm = Math.sqrt(Math.pow(xVelocity,2) + Math.pow(yVelocity,2))
        var forceDirection = Math.atan2(yVelocity,xVelocity) + Math.PI/2
        xVelocity = xVelocity + world.magneticField * Math.cos(forceDirection)
        yVelocity = yVelocity + world.magneticField * Math.sin(forceDirection)
        var normalisationFactor = Math.sqrt(Math.pow(xVelocity,2) + Math.pow(yVelocity,2))
        xVelocity = (xVelocity / normalisationFactor) * norm
        yVelocity = (yVelocity / normalisationFactor) * norm

        x = x + xVelocity
        y = y + yVelocity
    }

    function launch(phi,velocityNorm){
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
}
