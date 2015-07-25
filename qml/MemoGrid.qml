import QtQuick 2.0

GridView    {
    id: barbaList
    property int founds: 0
    property var firstFlipped: null
    property var lastFlipped: null
    property int clicks: 0
    property int totalFound: 0
    property var listModel: null
    signal puzzleWon(int clicks)
    cellWidth: width / 4
    cellHeight: height / 4
    clip: true
    visible: false
    delegate: Card  {
        id: flipCard
        width: barbaList.cellWidth - 5
        height: barbaList.cellHeight - 5
        onCardClicked: {
            if(!flipCard.found && !(barbaList.firstFlipped && barbaList.lastFlipped))  {
                flipCard.flipped = !flipCard.flipped
                if(flipCard.flipped)    {
                    if(!barbaList.firstFlipped) {
                        console.log("first card")
                        barbaList.firstFlipped = flipCard
                    } else if(!barbaList.lastFlipped) {
                        console.log("last card")
                        barbaList.lastFlipped = flipCard
                    }
                    flippedTimer.start()
                }   else    {
                    if(barbaList.lastFlipped)  {
                        barbaList.lastFlipped = null
                    }
                    else if(barbaList.firstFlipped)   {
                        barbaList.firstFlipped = null
                    }
                }
            }
        }
    }
    model: listModel
    onWidthChanged: {
        console.log("resizing", listModel)
        if(listModel)   {
            barbaList.cellWidth = barbaList.width/Math.ceil(Math.sqrt(listModel.count));
            barbaList.cellHeight = barbaList.height/Math.ceil(Math.sqrt(listModel.count));
        }
    }
    function resizeGrid()   {
        barbaList.cellWidth = barbaList.width/Math.ceil(Math.sqrt(listModel.count));
        barbaList.cellHeight = barbaList.height/Math.ceil(Math.sqrt(listModel.count));
    }
    Timer {
        id: flippedTimer
        interval: 500; running: false; repeat: false
        onTriggered: {
            if(barbaList.firstFlipped && barbaList.lastFlipped) {
                barbaList.clicks += 1
                if(barbaList.firstFlipped.cardName == barbaList.lastFlipped.cardName)    {
                    console.log("found", barbaList.firstFlipped.cardName, barbaList.lastFlipped.cardName)
                    barbaList.firstFlipped.found = true
                    barbaList.lastFlipped.found = true
                    barbaList.firstFlipped = null
                    barbaList.lastFlipped = null
                    barbaList.founds += 1
                    if(barbaList.founds == barbaList.totalFound)   {
                        puzzleWon(barbaList.clicks)
                    }
                }   else    {
                    console.log("not found")
                    barbaList.firstFlipped.flipped = false
                    barbaList.lastFlipped.flipped = false
                    barbaList.firstFlipped = null
                    barbaList.lastFlipped = null
                }
            }
        }
    }
}
