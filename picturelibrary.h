#ifndef PICTURELIBRARY_H
#define PICTURELIBRARY_H

#include <QObject>
#include <QStandardPaths>
#include <QQuickItem>
#include <QDir>
#include <QQmlContext>
#include "pictureitem.h"

class PictureLibrary: public ListModel
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path NOTIFY pathModified)
public:
    PictureLibrary(QObject *parent = 0);
    inline QString path() {return m_currentPath;}
    void updateContext();
    void setContext(QQmlContext *);


public slots:
    Q_INVOKABLE void setPath(QString, bool append = false);
    Q_INVOKABLE void setLocation(QStandardPaths::StandardLocation v_location);
    Q_INVOKABLE void setParentPath();

signals:
    void pathModified(QString);

private:
    QString m_currentPath;
    QStringList m_allowedExts;
    QQmlContext *m_currentContext;
};

#endif // PICTURELIBRARY_H
