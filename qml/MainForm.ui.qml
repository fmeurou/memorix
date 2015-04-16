import QtQuick 2.3

Rectangle {
    property alias mouseArea: mouseArea

    width: 720
    height: 720

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
