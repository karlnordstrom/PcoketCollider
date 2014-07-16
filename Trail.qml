import QtQuick 2.0

Item{
	property variant parentParticle: parent
	property var rects: []
	property int maximumLength: 10
	Component.onCompleted:{
		while (rects.length < maximumLength){
			var t = Qt.createQmlObject('import QtQuick 2.2; Rectangle{width:3; height:15; color:"red"; anchors.centerIn: parent}',parentParticle, "TrailCreation");
			rects.push(t)
		}
		console.log(rects[0])
	}
}
