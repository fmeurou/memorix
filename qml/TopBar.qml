import QtQuick 2.0

Rectangle   {
    id: topBar
    property bool upVisible: false
    signal paramsClicked()
    signal upClicked()
    color: "#656565"
    height:parent.height * 0.1
    width: parent.width
    Image   {
        width: parent.height
        height: parent.height
        visible: upVisible
        anchors {
            left: parent.left
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/icons/up.svg"
        MouseArea   {
            anchors.fill: parent
            onClicked: upClicked()
        }
    }
    Image   {
        width: parent.height
        height: parent.height
        anchors {
            right: parent.right
            rightMargin: 5
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/icons/filenew.svg"
        MouseArea   {
            anchors.fill: parent
            onClicked: paramsClicked()
        }
    }
}
