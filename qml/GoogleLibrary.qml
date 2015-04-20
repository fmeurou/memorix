import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    anchors {
        fill: parent
    }
    property var searchResults
    Rectangle   {
        id: modelListView
        anchors.fill: parent
        color: "#ffffff"
        TextInput   {
            id: pictureSearch
            height: 80
            width:parent.width - searchButton.width
            anchors {
                left: parent.left
                top: parent.top
            }
        }
        Button  {
            id: searchButton
            text: qsTr("search")
            anchors {
                right: parent.right
                top: parent.top
            }
            onClicked: search()
        }
        GridView    {
            id: searchResult
            cellWidth: 100
            cellHeight: 100
            delegate: Image {
                width: parent.width
                height: parent.height
                fillMode: Qt.KeepAspectRatio
                source: imgSource
            }
            model: searchResults
        }
    }
    function showRequestInfo(text) {
            console.log(text)
        }
    function search()   {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            console.log(doc.readyState, doc.responseText)
            if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                showRequestInfo("Headers -->");
                showRequestInfo(doc.getAllResponseHeaders ());
                showRequestInfo("Last modified -->");
                showRequestInfo(doc.getResponseHeader ("Last-Modified"));

            } else if (doc.readyState == XMLHttpRequest.DONE) {
                var a = doc.responseText;
                showRequestInfo(a);
                showRequestInfo("Headers -->");
                showRequestInfo(doc.getAllResponseHeaders ());
                showRequestInfo("Last modified -->");
                showRequestInfo(doc.getResponseHeader ("Last-Modified"));
            }
        }

        doc.open("GET", "https://www.googleapis.com/customsearch/v1?q=" + pictureSearch.text + "&fileType=jpg&key=AIzaSyBYl-y8n1yAp6halxRPC5mu5e7C1HCx_aU&cx=007188189272169326121:0jzz7yqxi8c");
        doc.send();
    }
}
