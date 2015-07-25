import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

GridView    {
    id: puzzleListView
    property var puzzleModel
    signal initPuzzle(var v_puzzleModel)
    cellWidth: width / 2
    cellHeight: height / 2
    clip: true
    delegate:   Rectangle   {
        id: puzzleRect
        width: puzzleListView.cellWidth - 5
        height: puzzleListView.cellHeight - 5
        color: "#ffffff"
        Image   {
            id: puzzleImg
            source: image
            width: parent.width
            height: parent.height
            anchors {
                centerIn: parent
            }
            fillMode: Qt.KeepAspectRatio
            MouseArea   {
                anchors {
                    fill: parent
                }
                onClicked: initPuzzle(elements)
            }
        }
        DropShadow {
            anchors.fill: puzzleRect
            horizontalOffset: 3
            verticalOffset: 3
            radius: 3.0
            samples: 16
            color: "#80000000"
            source: puzzleImg
        }
        Rectangle   {
            id: puzzleTextRect
            width: puzzleImg.paintedWidth
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
                text: title
                wrapMode: Text.WrapAnywhere
            }
        }


        Image    {
            id: deletePuzzleBox
            width: parent.height * 0.1
            height: parent.height * 0.1
            visible: id != 0
            source: "qrc:/icons/editdelete.svg"
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 10
            }
            MouseArea   {
                anchors.fill: parent
                onClicked: showConfirmationDialog(id)
            }
        }

    }
    model: puzzleModel
}
