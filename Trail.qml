import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var points: []

	onOpacityChanged: {points.forEach(function(r){r.opacity = opacity})}

	//small helperfunction
	function distanceOf(x1,y1,x2,y2){return Math.sqrt(Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2));}

    function leaveTrail(x,y, tracks, cals, radius){
		//calculate current track-beam distance
        var distance = distanceOf(x, y, beamTube.center.x, beamTube.center.y)

		//traces in differentDetectors
		if ( world.isInCals(radius) && cals ) {
            var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{z:0; width:5; height:5; radius:5; color:"red";
                 x:'+x+ parentParticle.width/2+'; y:'+y+ parentParticle.width/2+'}',world, "TrailCreation");
            points.push(t);
		}
        if ( (world.isInTrackers(radius) || world.isInMuonChambers(radius)) && tracks){
            var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{z:0; width:2; height:2; radius:2; color:"red";
                x:'+x+ parentParticle.width/2+'; y:'+y+ parentParticle.width/2+'}',world, "TrailCreation");
			points.push(t)
		}
	}
    function clearPath(){ while(points.length) points.pop().destroy(); }
}
