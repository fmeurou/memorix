import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import "json"

Window {
    visible: true
    MainForm {
        id: mainForm
        anchors.fill: parent
        property var modelList: [
            ":/data/json/barbapapa.json",
            ":/data/json/starwars.json",
            ":/data/json/cars.json",
            ":/data/json/meurou.json"
        ]
        ListModel   {
            id: randomList
        }

        ListModel   {
            id: puzzleList
        }

        TopBar  {
            id: topBar
            upVisible: false
            onUpClicked: {
                memoList.visible = false
                showMenu()
            }
            onParamsClicked:{
                memoList.visible = false
                centerView.source = "Params.qml"
                upVisible = false
            }
        }

        Rectangle   {
            width: parent.width
            anchors {
                top: topBar.bottom
                left: parent.left
                bottom: parent.bottom
            }

            MemoGrid    {
                id: memoList
                visible: false
                anchors.fill: parent
                onPuzzleWon: {
                    console.log("puzzle won")
                    centerView.source = "WonScreen.qml"
                    topBar.upVisible = false
                    centerView.item.clicks = clicks
                }
            }

            Loader  {
                id: centerView
                source: ""
                anchors.fill: parent
            }
            Connections {
                ignoreUnknownSignals: true
                target: centerView.item
                onInitPuzzle: initPuzzle(v_puzzleModel)
                onViewClicked: showMenu()
            }
        }
    }



    Component.onCompleted:  {
        for(var i = 0; i < mainForm.modelList.length; i++)  {
            console.log("FileIO {id: myFile;source: '" + mainForm.modelList[i] + "';onError: console.log(msg);}", mainForm, "")
            var objectString = "import QtQuick 2.4; import FileIO 1.0; FileIO {id: myFile;source: '" + mainForm.modelList[i] + "';onError: console.log(msg);}"
            var modelReader = Qt.createQmlObject(objectString, mainForm, "");
            var jsonModel = JSON.parse(modelReader.read())
            console.log(jsonModel.title)
            puzzleList.append(jsonModel)
            showMenu()
        }
    }
    function loadModel(v_modelName) {
        console.log("loading model", v_modelName)

    }

    function showMenu() {
        topBar.upVisible = false
        memoList.visible = false
        centerView.source = "PuzzleList.qml"
        centerView.item.puzzleModel = puzzleList
    }

    function initPuzzle(v_model)  {
        console.log("init puzzle")
        centerView.source = ""
        randomList.clear()
        memoList.clicks = 0
        memoList.founds = 0
        var nbList = [];
        for(var i = 0; i < v_model.count; i++)   {
            nbList.push(i);
        }
        var firstArray = shuffle(nbList);
        for(var i = 0; i < firstArray.length; i++)  {
            randomList.append(v_model.get(firstArray[i]))
        }
        var secondArray = shuffle(firstArray);
        for(var i = 0; i < secondArray.length; i++)  {
            randomList.append(v_model.get(secondArray[i]))
        }
        console.log(centerView.item)
        memoList.listModel = randomList
        memoList.totalFound = v_model.count
        memoList.resizeGrid()
        memoList.visible = true
        topBar.upVisible = true

    }

    function shuffle(array) {
      var currentIndex = array.length, temporaryValue, randomIndex ;

      // While there remain elements to shuffle...
      while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
      }

      return array;
    }
}
