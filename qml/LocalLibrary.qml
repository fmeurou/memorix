import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    property var selectedItems: []
    anchors {
        fill: parent
    }
    Rectangle   {
        id: modelListView
        anchors {
            centerIn: parent
        }
        width: parent.width - 4
        height: parent.height - 4

        color: "#ffffff"
        TextField   {
            id: libraryName
            height: 80
            width:parent.width
            placeholderText: qsTr("library name")
            anchors {
                bottom: addButton.top
                bottomMargin: 1
                horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle   {
            id: navBar
            width: parent.width
            height: 80
            anchors {
                top: parent.top
                left: parent.left
            }
            Image   {
                id: upImage
                width: parent.height
                height: parent.height
                anchors {
                    left: parent.left
                    leftMargin: 2
                    verticalCenter: parent.verticalCenter
                }
                source: "qrc:/icons/up.svg"
                MouseArea   {
                    anchors.fill: parent
                    onClicked: pictures.setParentPath();
                }
            }
            Text    {
                id: pathText
                height: parent.height
                anchors {
                    right: parent.right
                    rightMargin: 2
                    left: upImage.right
                    leftMargin: 2
                }
                verticalAlignment: Text.AlignVCenter
                text: pictures.path
                fontSizeMode: Text.Fit
            }
        }
        GridView    {
            id: modelList
            width: parent.width
            height: parent.height
            anchors {
                top: navBar.bottom
                left: parent.left
                bottom: addButton.top
                right: parent.right
            }
            clip: true
            cacheBuffer:500
            cellWidth: width / 5
            cellHeight: width / 5
            delegate :Rectangle {
                id: imageItem
                property bool checked: false
                width: modelList.cellWidth
                height: modelList.cellHeight
                border  {
                    width: 1
                    color: '#e7e7e7'
                }
                Image {
                    anchors.fill:parent
                    source: isDir ? "qrc:/icons/folder.png" : path
                    fillMode: Qt.KeepAspectRatio
                }
                CheckBox    {
                    width: 10
                    height: 10
                    visible: !isDir
                    anchors {
                        top: parent.top
                        topMargin: 15
                        right: parent.right
                        rightMargin: 20
                    }
                    checked: imageItem.checked

                }

                Rectangle   {
                    color: "#ffffff"
                    opacity: 0.9
                    width: parent.width - 4
                    height: imgText.contentHeight
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 2
                        horizontalCenter: parent.horizontalCenter
                    }
                    Text    {
                        id: imgText
                        width: parent.width
                        anchors {
                            top: parent.top
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: name
                        elide: Text.ElideRight
                    }
                }
                MouseArea   {
                    anchors.fill: parent
                    onClicked: {
                        if(!isDir)   {
                            imageItem.checked = !imageItem.checked
                            if(selectedItems.indexOf(path) < 0) {
                                selectedItems.push(path)
                            }   else    {
                                selectedItems.pop(selectedItems.indexOf(path))
                            }
                        }   else    {
                            pictures.setPath(path);
                        }
                    }
                }
            }
            model: pictures
        }
        Button  {
            id: addButton
            text: qsTr("add library")
            width: parent.width
            enabled: (Math.floor(Math.pow((selectedItems.lengh * 2), 2) / 2) - Math.pow((selectedItems.lengh * 2), 2) / 2) == 0
            height: 80
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            onClicked: {
                for(var i=0; i < selectedItems.length; i++)  {
                    console.log(selectedItems[i])
                }
            }
        }
    }
}
