import QtQuick.LocalStorage 2.0
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
            ":/data/json/template.json",
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
                centerView.source = "LocalLibrary.qml"
                upVisible = true
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

    MessageDialog   {
        id: messageDialog
        property string idToDelete: ""
        title: qsTr("Puzzle deletion warning")
        text: qsTr("You are about to remove a puzzle. There's no turning back!")
        standardButtons: StandardButton.Cancel | StandardButton.Ok
        onAccepted: {
            removePuzzle(idToDelete)
            idToDelete = ""
            visible = false
        }
        onRejected: {
            console.log("that was close!")
            visible = false
        }

        Component.onCompleted: visible = false
    }



    Component.onCompleted:  {
        initialize()
        showMenu()
    }

    function loadPuzzles()  {
        puzzleList.clear()
        for(var i = 0; i < mainForm.modelList.length; i++)  {
            console.log("FileIO {id: myFile;source: '" + mainForm.modelList[i] + "';onError: console.log(msg);}", mainForm, "")
            var objectString = "import QtQuick 2.4; import FileIO 1.0; FileIO {id: myFile;source: '" + mainForm.modelList[i] + "';onError: console.log(msg);}"
            var modelReader = Qt.createQmlObject(objectString, mainForm, "");
            var jsonModel = JSON.parse(modelReader.read())
            console.log(jsonModel.title)
            puzzleList.append(jsonModel)
        }
        var localPuzzles = JSON.parse(getSetting("puzzles", "{\"puzzleList\": []}"))
        console.log("loadPuzzles", localPuzzles)
        for(var i = 0; i < localPuzzles.puzzleList.length; i++)  {
            puzzleList.append(localPuzzles.puzzleList[i])
        }

    }

    function loadModel(v_modelName) {
        console.log("loading model", v_modelName)

    }

    function showMenu() {
        loadPuzzles()
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

    function storePuzzle(puzzleJSON)  {
        var existingPuzzles = JSON.parse(getSetting("puzzles", "{\"puzzleList\": []}"))
        console.log("storePuzzle", JSON.stringify(existingPuzzles), JSON.stringify(puzzleJSON))
        existingPuzzles.puzzleList.push(puzzleJSON)
        console.log()
        setSetting("puzzles", JSON.stringify(existingPuzzles))
        showMenu()
    }

    function removePuzzle(puzzleId)   {
        var existingPuzzles = JSON.parse(getSetting("puzzles", "{\"puzzleList\": []}"))
        console.log("storePuzzle", JSON.stringify(existingPuzzles), puzzleId)
        for(var i = 0; i < existingPuzzles.puzzleList.length; i++)  {
            if(existingPuzzles.puzzleList[i].id == puzzleId)    {
                existingPuzzles.puzzleList.splice(i, 1);
            }
        }
        console.log("removed element", puzzleId)
        setSetting("puzzles", JSON.stringify(existingPuzzles))
        showMenu()
    }


    function slugify(text)  {
      return text.toString().toLowerCase()
        .replace(/\s+/g, '-')           // Replace spaces with -
        .replace(/[^\w\-]+/g, '')       // Remove all non-word chars
        .replace(/\-\-+/g, '-')         // Replace multiple - with single -
        .replace(/^-+/, '')             // Trim - from start of text
        .replace(/-+$/, '');            // Trim - from end of text
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

    //storage.js
    // First, let's create a short helper function to get the database connection
    function getDatabase() {
         return LocalStorage.openDatabaseSync("memorix", "1.0", "StorageDatabase", 100000);
    }

    // At the start of the application, we can initialize the tables we need if they haven't been created yet
    function initialize() {
        var db = getDatabase();
        db.transaction(
            function(tx) {
                // Create the settings table if it doesn't already exist
                // If the table exists, this is skipped
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
          });
    }

    // This function is used to write a setting into the database
    function setSetting(setting, value) {
       // setting: string representing the setting name (eg: “username”)
       // value: string representing the value of the setting (eg: “myUsername”)
       var db = getDatabase();
       var res = "";
       db.transaction(function(tx) {
            var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
                  //console.log(rs.rowsAffected)
                  if (rs.rowsAffected > 0) {
                    res = "OK";
                  } else {
                    res = "Error";
                  }
            }
      );
      // The function returns “OK” if it was successful, or “Error” if it wasn't
      return res;
    }
    // This function is used to retrieve a setting from the database
    function getSetting(setting, defaultValue) {
       var db = getDatabase();
       var res="";
       db.transaction(function(tx) {
         var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
         if (rs.rows.length > 0) {
              res = rs.rows.item(0).value;
         } else {
             res = defaultValue;
         }
      })
      // The function returns “Unknown” if the setting was not found in the database
      // For more advanced projects, this should probably be handled through error codes
      return res
    }

    function showConfirmationDialog(v_idToDelete)  {
        messageDialog.idToDelete = v_idToDelete
        messageDialog.visible = true
    }
}
