import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var points: []
	property int maximumLength: parent.timeAlive
	property int oldestPoint: 0

	onOpacityChanged: {points.forEach(function(r){r.opacity = opacity})}

	//small helperfunction
	function distanceOf(x1,y1,x2,y2){return Math.sqrt(Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2));}

	function leaveTrail(x,y){
		//calculate current track-beam distance
		var distance = distanceOf(x, y, beamTube.center.x, beamTube.center.y)

		//no traces outside the detectors!
		if ( distance > muonChamber.stopRadius / 2) return;

		//no traces in the calorimeters!
		if (   distance < calorimeters.stopRadius / 2
			&& distance > calorimeters.startRadius / 2) return;

		//create or reuse existing tracepoints
        if (points.length < maximumLength){
			var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{width:2; height:2; radius:2; color:"red"; x:'+x+'; y:'+y+'}',world, "TrailCreation");
			points.push(t)
		} else {
			points[oldestPoint].x = x
			points[oldestPoint].y = y
			oldestPoint = (oldestPoint + 1) % maximumLength
		}
	}
	function clearPath(){ while(points.length) points.pop().destroy();}
}
