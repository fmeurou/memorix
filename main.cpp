#include <QGuiApplication>
#include <QtQml>
#include <QQmlContext>
#include <QStandardPaths>
#include <QQmlApplicationEngine>
#include "fileio.h"
#include "picturelibrary.h"
#include "pictureitem.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    qDebug() << QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    QString firstPath = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation).at(0);
    context->setContextProperty("pictures",new PictureLibrary());
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    return app.exec();
}
