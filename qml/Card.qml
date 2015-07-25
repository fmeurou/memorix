import QtQuick 2.0
import QtGraphicalEffects 1.0

Flipable  {
    id: flipCard
    property bool flipped: false
    property bool found: false
    property string cardName: name
    signal cardClicked()
    front: Image    {
        anchors {
            fill: parent
        }
        fillMode: Qt.KeepAspectRatio
        source: "qrc:/icons/ip.jpg"
    }
    back: Rectangle {
        id: cardBack
        width: parent.width
        height: parent.height
        Image   {
            id: cardImg
            width: parent.width - 2
            height: parent.height - 2
            anchors {
                centerIn: parent
            }
            fillMode: Qt.KeepAspectRatio
            source: src
        }
        DropShadow {
            anchors.fill: cardBack
            horizontalOffset: 3
            verticalOffset: 3
            radius: 3.0
            samples: 16
            color: "#80000000"
            source: cardImg
        }
        Rectangle   {
            id: cardTextRect
            width: cardImg.paintedWidth
            height: nameText.contentHeight
            color: "#656565"
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            opacity: 0.8
            Text    {
                id: nameText
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                color: '#ffffff'
                text: name
                wrapMode: Text.WrapAnywhere
            }
        }
    }
    transform: Rotation {
        id: rotation
        origin.x: flipCard.width/2
        origin.y: flipCard.height/2
        axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 0    // the default angle
    }

    states: State {
        name: "back"
        PropertyChanges { target: rotation; angle: 180 }
        when: flipCard.flipped
    }

    transitions: Transition {
        NumberAnimation { target: rotation; property: "angle"; duration: 200 }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: cardClicked()
    }
}
