import QtQuick 2.0

ListView    {
    id: libraryView
    delegate:    Rectangle {
        id: libraryItem
        property string itemType: "file"

    }

}
