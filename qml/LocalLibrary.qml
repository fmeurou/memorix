import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    anchors {
        fill: parent
    }
    Rectangle   {
        id: modelListView
        anchors.fill: parent
        color: "#ffffff"
        TextInput   {
            id: libraryName
            height: 80
            width:Math.min(parent.width, 200)
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
        }
        GridView    {
            id: modelList
            width: parent.width
            height: parent.height - 160
            clip: true
            visible: false
            cacheBuffer:500
            cellWidth: 100
            cellHeight: 100
            delegate :Rectangle {
                width: modelList.cellWidth
                height: modelList.cellHeight
                border  {
                    width: 1
                    color: '#e7e7e7'
                }
                Image {
                    anchors.fill:parent
                    source: path
                    fillMode: Qt.KeepAspectRatio
                }

            }
            model: pictures
        }
    }
}
