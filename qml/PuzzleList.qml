import QtQuick 2.0

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
    }
    model: puzzleModel
}
