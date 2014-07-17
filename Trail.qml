import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var points: []
	property int maximumLength: parent.timeAlive
	//put in a ring-buffer-like pointer to the oldest particle
	//After creating all particle that is index 0
	property int oldestPoint: 0
	onOpacityChanged: {points.forEach(function(r){r.opacity = opacity})}

	function squaredDistance(x1,y1,x2,y2){
		return Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2)
	}

	function leaveTrail(x,y){
		//no trace outside the detectors!
		if (squaredDistance(x, y,(beamTube.x+beamTube.width/2), (beamTube.y+beamTube.height/2)) > Math.pow(muonChamber.stopRadius/2,2))
			return;
		if (points.length < maximumLength){
			var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{width:2; height:2; radius:2; color:"red"; x:'+x+'; y:'+y+'}',world, "TrailCreation");
			points.push(t)
		} else {
			points[oldestPoint].x = x
			points[oldestPoint].y = y
			oldestPoint = (oldestPoint + 1) % maximumLength
		}
	}

	function clearPath(){
		while(points.length)
			var r = points.pop()
			r.destroy();
	}
}
