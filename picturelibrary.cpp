#include "picturelibrary.h"

PictureLibrary::PictureLibrary(QObject *parent)
    : ListModel(new PictureItem(), parent)
{
    m_allowedExts = QStringList();
    m_allowedExts << "*.jpg" << "*.png" << "*.jpeg" << "*.JPG" << "*.PNG" << "*.JPEG";
}

void PictureLibrary::setLocation(QStandardPaths::StandardLocation v_location)   {
    foreach(QString picturePath, QStandardPaths::standardLocations(v_location))   {
        setPath(picturePath, true);
    }
}

void PictureLibrary::setPath(QString v_path, bool v_append)    {
    qDebug() << "PictureLibrary::setPath" << v_path;
    if(!v_append)   {
        removeRows(0, rowCount());
        clearAll();
    }
    m_currentPath = v_path.replace("file:/", "");
    QDir pictureDir(m_currentPath);
    qDebug() << pictureDir.absolutePath();
    QStringList pictureList = pictureDir.entryList(m_allowedExts,
                                                   QDir::Files|QDir::AllDirs|QDir::NoDotAndDotDot,
                                                   QDir::QDir::Name);
    qDebug() << pictureList;
    foreach (QString picture, pictureList) {
        qDebug() << pictureDir.absoluteFilePath(picture);
        PictureItem *pic = new PictureItem();
        pic->setId(pictureDir.absoluteFilePath(picture));
        pic->setName(QFileInfo(picture).baseName());
        pic->setIsDir(true);
        if(!QFileInfo(pictureDir.absoluteFilePath(picture)).isDir()) {
            pic->setIsDir(false);
        }
        qDebug() << "adding file or dir " << pictureDir.absoluteFilePath(picture);
        pic->setPath("file:/" + pictureDir.absoluteFilePath(picture));
        appendRow(pic);
    }
    updateContext();
}

void PictureLibrary::setParentPath()    {
    QDir currentDir(m_currentPath);
    if(currentDir.cdUp())   {
        qDebug() << "upped one dir" << currentDir.absolutePath();
        setPath(currentDir.absolutePath(), false);

    }   else    {
        qDebug() << "couldn't up " << currentDir.absolutePath();
    }
}

void PictureLibrary::setContext(QQmlContext *v_context) {
    m_currentContext = v_context;
}

void PictureLibrary::updateContext()    {
    m_currentContext->setContextProperty("pictures",new PictureItem());
    m_currentContext->setContextProperty("pictures",this);
}
