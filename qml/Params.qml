import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    id: menuView
    anchors {
        fill: parent
    }
    state: "menu"
    Flow   {
        id: options
        anchors.fill: parent
        Button  {
            height: 80
            width: parent.width
            iconName: "qrc:/icons/filenew.svg"
            text: qsTr("create local album")
            onClicked: menuView.state = 'local'
        }
        Button  {
            height: 80
            width: parent.width
            iconName: "qrc:/icons/filenew.svg"
            text: qsTr("create google search album")
            onClicked: menuView.state = 'google'
        }
    }
    LocalLibrary    {
        id: localLibrary
        anchors.fill: parent
    }
    GoogleLibrary    {
        id: googleLibrary
        anchors.fill: parent
    }

    states: [
        State   {
            name: "menu"
            PropertyChanges {
                target: options
                visible: true
            }
            PropertyChanges {
                target: localLibrary
                visible: false
            }
            PropertyChanges {
                target: googleLibrary
                visible: false
            }
        },
        State   {
            name: "local"
            PropertyChanges {
                target: options
                visible: false
            }
            PropertyChanges {
                target: localLibrary
                visible: true
            }
            PropertyChanges {
                target: googleLibrary
                visible: false
            }
        },
        State   {
            name: "google"
            PropertyChanges {
                target: options
                visible: false
            }
            PropertyChanges {
                target: googleLibrary
                visible: true
            }
            PropertyChanges {
                target: localLibrary
                visible: false
            }
        }
    ]


}
