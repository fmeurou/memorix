#ifndef PICTURELIBRARY_H
#define PICTURELIBRARY_H

#include <QObject>
#include <QStandardPaths>
#include <QQuickItem>
#include <QDir>
#include "pictureitem.h"

class PictureLibrary: public ListModel
{
    Q_OBJECT
public:
    PictureLibrary(QObject *parent = 0);


};

#endif // PICTURELIBRARY_H
