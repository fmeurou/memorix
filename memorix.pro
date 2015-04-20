TEMPLATE = app

QT += qml quick
QTPLUGIN += qsvg
INCLUDEPATH += .
CONFIG += console

SOURCES += main.cpp \
    fileio.cpp \
    picturelibrary.cpp \
    pictureitem.cpp \
    listmodel.cpp

RESOURCES += \
    qml/qml.qrc \
    icons/icons.qrc \
    data/data.qrc

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
