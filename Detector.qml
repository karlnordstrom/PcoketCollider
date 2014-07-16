import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
	property int startRadius;
	property int stopRadius;

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

	Path {
		startX: 100; startY: 0

		PathArc {
			x: 0; y: 100
			radiusX: 100; radiusY: 100
			useLargeArc: true
		}
	}

}
