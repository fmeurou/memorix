#include <QGuiApplication>
#include <QtQml>
#include <QQmlContext>
#include <QStandardPaths>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include "fileio.h"
#include "picturelibrary.h"
#include "pictureitem.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    static QTranslator qmlTranslator;
    QString uiLanguage = QLocale::system().name();
    qDebug() << "load qml translation" << uiLanguage;
    if(!qmlTranslator.load(uiLanguage,":/locale"))    {
        qDebug() << "cannot load translation ,trying another method"
                 << QDir::currentPath() + "/locale/" + uiLanguage
                 << qmlTranslator.load(QDir::currentPath() + "/locale/" + uiLanguage);
    }
    app.installTranslator(&qmlTranslator);
    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    qDebug() << QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    QString firstPath = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation).at(0);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    qDebug() << engine.offlineStoragePath();
    PictureLibrary *pictures = new PictureLibrary();
    pictures->setContext(context);
    pictures->setLocation(QStandardPaths::PicturesLocation);
    return app.exec();
}


