import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
	property int startRadius;
	property int stopRadius;
	property int intersections: 0

	z:0
	height: stopRadius
	width: stopRadius
	radius: stopRadius
	color:Qt.lighter("gray")
	Rectangle{
		z:3
		height: startRadius
		width: startRadius
		radius: startRadius
		anchors.centerIn: parent
		color: world.color
	}

	Component.onCompleted: {
		for( var i = 0; i < intersections; i++){
			var angle = 90 + (360 / intersections) * i
			Qt.createQmlObject('import QtQuick 2.0; Rectangle{ anchors.centerIn: parent; width: 10; height: stopRadius; rotation:' + angle + '; color: world.color}', parent, "Intersection")
		}
	}

}
