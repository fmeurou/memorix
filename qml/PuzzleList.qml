import QtQuick 2.0
import QtQuick.Controls 1.2

GridView    {
    id: puzzleListView
    property var puzzleModel
    signal initPuzzle(var v_puzzleModel)
    cellWidth: width / 2
    cellHeight: height / 2
    clip: true
    delegate:   Rectangle   {
        width: puzzleListView.cellWidth
        height: puzzleListView.cellHeight
        Image   {
            source: image
            width: puzzleListView.cellWidth - 10
            height: puzzleListView.cellHeight - 10
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
