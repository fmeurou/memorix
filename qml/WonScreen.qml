import QtQuick 2.0


Rectangle   {
    id: wonRect
    property int clicks: 0
    signal viewClicked()
    opacity: 0.8
    Text    {
        id: wonText
        width: parent.width
        height: parent.height / 2
        anchors {
            top: parent.top
            left: parent.left
        }
        font    {
            pointSize: 99
        }

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: "You have won"
        fontSizeMode: Text.Fit
    }
    Text    {
        id: ndTurns
        width: parent.width
        height: parent.height / 2
        anchors {
            top: wonText.bottom
            left: parent.left
        }
        font    {
            pointSize: 99
        }
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: "it took you " + clicks + " turns"
        fontSizeMode: Text.Fit
    }
    MouseArea   {
        anchors.fill: parent
        onClicked: viewClicked()
    }
}
