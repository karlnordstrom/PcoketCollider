import QtQuick 2.0

Item{
	width: childrenRect.width
	height: childrenRect.height

	Rectangle{
		id: beamTubeCircle
        width:50
        height:50
        radius:50
		color:"green"

		MouseArea{
			anchors.fill: parent
			onClicked: {parent.color="red"; world.collisionEvent()}
		}
		Behavior on color{ColorAnimation{from: "red"; to: "green"; duration: 600}}
	}
}
