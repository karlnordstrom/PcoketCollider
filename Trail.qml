import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var points: []

	onOpacityChanged: {points.forEach(function(r){r.opacity = opacity})}

    function leaveTrail(x,y, tracks, cals, radius){
		//traces in differentDetectors
		if ( world.isInCals(radius) && cals ) {
            var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{z:0; width:5; height:5; radius:5; color:"red";
                 x:'+x+'; y:'+y+'}',world, "TrailCreation");
            points.push(t);
		}
        if ( (world.isInTrackers(radius) || world.isInMuonChambers(radius)) && tracks){
            var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{z:0; width:2; height:2; radius:2; color:"red";
                x:'+x+'; y:'+y+'}',world, "TrailCreation");
			points.push(t)
		}
	}
    function clearPath(){ while(points.length) points.pop().destroy(); }
}
