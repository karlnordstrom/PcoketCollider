import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var points: []

	onOpacityChanged: {points.forEach(function(r){r.opacity = opacity})}

    function leaveTrail(x,y, lostEnergy, tracks, EMCals, hadCals, radius){
		//traces in differentDetectors
        if ( world.isInEmCals(radius) && EMCals != 1.0 ) {
            emCalorimeters.deposit(lostEnergy, Math.atan2((beamTube.center.y -y),(beamTube.center.x - x)))
		}
        if ( world.isInHdCals(radius) && hadCals != 1.0 ) {
            hdCalorimeters.deposit(lostEnergy, Math.atan2((beamTube.center.y -y),(beamTube.center.x - x)))
		}
        if ( (world.isInTrackers(radius) || world.isInMuonChambers(radius)) && tracks){
            var t = Qt.createQmlObject('import QtQuick 2.0; Rectangle{z:0; width:1; height:1; radius:1; color:"red";
                x:'+x+'; y:'+y+'}', world, "TrailCreation");
			points.push(t)
		}
	}
    function clearPath(){ while(points.length) points.pop().destroy(); }
}
