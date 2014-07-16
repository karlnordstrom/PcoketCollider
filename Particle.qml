import QtQuick 2.0
import "qrc:///"

Item{
	//Particle Interface
	function launch(){particle.launch()}
	function launchDirection(x,y){particle.launchDirection(x,y)}

	Trail{

	}

	Rectangle{
		id: particle
		width:10
		height:10
		radius:10
		x:world.width
		y:world.height
		color: "blue"
		visible: false

		NumberAnimation on x{
			id: particleAnimationX
			from: beamTube.x + beamTube.width / 2
			to: Math.random() * world.width
			duration: 1000
			easing.type: Easing.OutCubic
		}

		NumberAnimation on y{
			id: particleAnimationY
			from: beamTube.y + beamTube.height / 2
			to: Math.random() * world.height
			duration: 1000
			easing.type: Easing.Linear
		}

		NumberAnimation on opacity{
			id: fadingAnimation
			from: 1
			to: 0
			duration: 1000
			easing.type: Easing.InCubic
		}

		function launch(){
			visible = true
			particleAnimationX.to = Math.random() * world.width
			particleAnimationX.restart()
			particleAnimationY.to = Math.random() * world.height
			particleAnimationY.restart()
			fadingAnimation.restart()
		}

		function launchDirection(x,y){
			visible = true;
			particleAnimationX.to = x;
			particleAnimationY.to = y;

			particleAnimationX.restart();
			particleAnimationY.restart();
			fadingAnimation.restart();
		}
	}
}
