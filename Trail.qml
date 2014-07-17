import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var points: []
	property int maximumLength: parent.timeAlive
	//put in a ring-buffer-like pointer to the oldest particle
	//After creating all particle that is index 0
	property int oldestPoint: 0
	onOpacityChanged: {points.forEach(function(r){r.opacity = opacity})}

    function leaveTrail(x,y, tracks, cals, radius){
        if (radius > muonChamber.stopRadius/2){
			return;
        }
        if ( world.getCals(radius) && cals ){
            var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{width:5; height:5; radius:5; color:"red"; x:'+x+'; y:'+y+'}',world, "TrailCreation");
            points.push(t)
        }
        if ( world.getTracks(radius) && tracks){
			var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{width:2; height:2; radius:2; color:"red"; x:'+x+'; y:'+y+'}',world, "TrailCreation");
            points.push(t)
        }

        points[oldestPoint].x = x
        points[oldestPoint].y = y
        oldestPoint = (oldestPoint + 1) % maximumLength
	}

	function clearPath(){
		while(points.length)
			var r = points.pop()
			r.destroy();
	}
}
