TEMPLATE = app

QT += qml quick
QTPLUGIN += qsvg
QTPLUGIN+= qsqlite
INCLUDEPATH += .

TRANSLATIONS =  locale/fr.ts \
                locale/en.ts

SOURCES += main.cpp \
    fileio.cpp \
    picturelibrary.cpp \
    pictureitem.cpp \
    listmodel.cpp

RESOURCES += \
    qml/qml.qrc \
    icons/icons.qrc \
    data/data.qrc \
    locale/locale.qrc \
    locale/locale.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    fileio.h \
    picturelibrary.h \
    pictureitem.h \
    listmodel.h

DISTFILES += \
    models/meurou.json \
    models/barbapapa.json \
    models/starwars.json \
    models/cars.json

lupdate_only    {
    SOURCES += \
        qml/Card.qml \
        qml/FileIO.qml \
        qml/GoogleLibrary.qml \
        qml/LocalLibrary.qml \
        qml/MainForm.ui.qml \
        qml/MemoGrid.qml \
        qml/MemoryModel.qml \
        qml/Params.qml \
        qml/PuzzleList.qml \
        qml/TopBar.qml \
        qml/WonScreen.qml \
        qml/main.qml
}

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    ios_icon.files = $$files($$PWD/ios/AppIcon*.png)
    QMAKE_BUNDLE_DATA += ios_icon
}
