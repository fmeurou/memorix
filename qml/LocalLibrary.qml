import QtQuick 2.0
import QtQuick.Controls 1.2

Item {    
    id: localLibrary
    property var selectedItems: []
    property var gridSize: [2, 8, 18, 32, 50, 72, 98, 128]
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
        Rectangle   {
            id: navBar
            width: parent.width
            height: 50
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
                            if(localLibrary.selectedItems.indexOf(path) < 0) {
                                localLibrary.selectedItems.push(path)
                            }   else    {
                                localLibrary.selectedItems.pop(selectedItems.indexOf(path))
                            }
                            console.log(localLibrary.selectedItems, localLibrary.selectedItems.length,getNextCount(localLibrary.selectedItems.length))
                            addButton.enabled = localLibrary.selectedItems.length == getNextCount(localLibrary.selectedItems.length)
                            addButton.text = addButton.enabled ? qsTr("add library") : localLibrary.selectedItems.length + " / " + getNextCount(localLibrary.selectedItems.length)

                        }   else    {
                            pictures.setPath(path);
                        }
                    }
                }
            }
            model: pictures
        }
        TextField   {
            id: puzzleName
            width: parent.width * 0.6
            height: 50
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            placeholderText: qsTr("enter puzzle name")
        }

        Button  {
            id: addButton
            text: qsTr("select pictures")
            width: parent.width * 0.4
            enabled: false
            height: 50
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
            onClicked: {
                var newPuzzle = {
                    id: guid(),
                    title: puzzleName.text,
                    elements: []
                }

                for(var i=0; i < selectedItems.length; i++)  {
                    var itemName = selectedItems[i].split('/');
                    itemName = itemName[itemName.length - 1].split('.')
                    itemName = itemName[0]
                    if(i == 0)  {
                        newPuzzle.image = selectedItems[i]
                    }
                    newPuzzle.elements.push({"name": itemName,
                                             "src": selectedItems[i]})
                }
                console.log(newPuzzle)
                storePuzzle(newPuzzle)
            }
        }
    }
    function getNextCount(currentCount) {
        var nextCount = 0;
        for(var i = 0; i < gridSize.length; i++)    {
            if(currentCount <= gridSize[i])  {
                return gridSize[i]
            }
        }
        return 999;
    }

    function guid() {
      function s4() {
        return Math.floor((1 + Math.random()) * 0x10000)
          .toString(16)
          .substring(1);
      }
      return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
        s4() + '-' + s4() + s4() + s4();
    }
}
