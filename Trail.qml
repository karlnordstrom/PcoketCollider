import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var rects: []
    property int maximumLength: parent.timeAlive
	onOpacityChanged: {rects.forEach(function(r){r.opacity = opacity})}
	function leaveTrail(x,y){
		if (rects.length < maximumLength){
			var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{width:2; height:2; radius:2; color:"red"; x:'+x+'; y:'+y+'}',world, "TrailCreation");
			rects.push(t)
		}
	}

	function clearPath(){
		while(rects.length)
			var r = rects.pop()
			r.destroy();
	}
}
