import QtQuick 2.0
import FileIO 1.0

FileIO {
    id: myFile
    source: "my_file.txt"
    onError: console.log(msg)
}
