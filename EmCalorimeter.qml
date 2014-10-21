import QtQuick 2.0

Rectangle {
	property int startRadius;
	property int stopRadius;
    property int spatialStart;
    property int spatialStop;
	property int intersections: 0
	property var energyDeposits : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	width: stopRadius
	height: stopRadius
	radius: stopRadius
	color: Qt.rgba(1,1,1,0)

	Repeater{
		id: cells
		anchors.centerIn: parent
		model: 20
		Image{	z: 4
                source: "emColliderSector.png";
				x:  parent.stopRadius/2 + (parent.startRadius/2) * Math.cos((Math.PI*2/20) * index)
				y:  -height + parent.stopRadius/2 + (parent.startRadius/2)* Math.sin((Math.PI*2/20) * index)
				transformOrigin: Item.BottomLeft
				rotation: ((360/20.0) * index) + 90}
	}

	function deposit( energy, angle ){
        var index = Math.floor(((angle+Math.PI)/(Math.PI*2)) * 20)
		// else create a new deposit
		var xPos = stopRadius/2 + (startRadius/2) * Math.cos((Math.PI*2/20) * index);
		var yPos = stopRadius/2 + (startRadius/2)* Math.sin((Math.PI*2/20) * index);
		var rot = ((360/20.0) * index) + 90
        var d = Qt.createQmlObject('import QtQuick 2.0; Image{z: 5; source:"emColliderSectorDeposit.png"; opacity:'+energy/10+'; x:'+ xPos +'; y: - height +'+ yPos +'; transformOrigin: Item.BottomLeft; rotation:'+rot+'; NumberAnimation on opacity{id: fadeAnimation; to: 0; duration:2000; easing.type: Easing.InCubic; running:true; onStopped:{parent.deleteDeposit('+index+')}}}', emCalorimeters, "Deposits")
        energyDeposits[index] = d
	}

	function deleteDeposit(index){
        //energyDeposits[index].destroy()
		energyDeposits[index] = 0
	}
}
