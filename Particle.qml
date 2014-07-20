import QtQuick 2.0
import "qrc:///"
import "pdg.js" as PDG

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
        var norm = Math.sqrt(Math.pow(xVelocity,2) + Math.pow(yVelocity,2))
                   * getEnergyLoss(radius, PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEnergy, type)
        var forceDirection = Math.atan2(yVelocity,xVelocity) + charge * Math.PI/2
        xVelocity = xVelocity + world.getMagneticField(radius) * Math.cos(forceDirection)
		yVelocity = yVelocity + world.getMagneticField(radius) * Math.sin(forceDirection)
		var normalisationFactor = Math.sqrt(Math.pow(xVelocity,2) + Math.pow(yVelocity,2))

		xVelocity = (xVelocity / normalisationFactor) * norm
        yVelocity = (yVelocity / normalisationFactor) * norm

        x = x + xVelocity
        y = y + yVelocity

        if (PDG.Particles[type].leavesTrack || PDG.Particles[type].leavesEnergy){
            if (type == "Muon" || type == "Antimuon"){
                if ( t % 2 == 0 )
                    trail.leaveTrail(x - particle.size / 2, y - particle.size / 2,
                         PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEnergy, radius);
            }
            else
                trail.leaveTrail(x - particle.size / 2, y - particle.size / 2,
                     PDG.Particles[type].leavesTrack, PDG.Particles[type].leavesEnergy, radius);
        }
    }

    function launch(phi,velocityNorm, particleType){
        type = particleType
        timeAlive = lifetime * Math.exp(2 * Math.random() - 1)
		x = beamTube.center.x - particle.size / 2
		y = beamTube.center.y - particle.size / 2
        xVelocity = velocityNorm * Math.cos(phi)
        yVelocity = velocityNorm * Math.sin(phi)
        particle.visible = true;
        particleAnimationT.restart()
    }

	function distanceToMiddle(x, y){
		return Math.sqrt(Math.pow(beamTube.center.x - x, 2) + Math.pow(beamTube.center.y - y, 2))}

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

}
