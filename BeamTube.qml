import QtQuick 2.0

Item{
	width: childrenRect.width
	height: childrenRect.height

	Rectangle{
		id: beamTubeCircle
		width:100
		height:100
		radius:100
		color:"green"

		MouseArea{
			anchors.fill: parent
			onClicked: {parent.color="red"; world.collisionEvent()}
		}
		Behavior on color{ColorAnimation{from: "red"; to: "green"; duration: 600}}
	}
}
