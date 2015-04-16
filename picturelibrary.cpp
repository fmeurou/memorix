#include "picturelibrary.h"

PictureLibrary::PictureLibrary(QObject *parent)
    : ListModel(new PictureItem(), parent)
{
    foreach(QString picturePath, QStandardPaths::standardLocations(QStandardPaths::PicturesLocation))   {
        QDir pictureDir(picturePath);
        QStringList allowedFiles;
        allowedFiles << "*.jpg" << "*.png" << "*.jpeg" << "*.JPG" << "*.PNG" << "*.JPEG";
        QStringList pictureList = pictureDir.entryList(allowedFiles, QDir::Files, QDir::QDir::Name);
        foreach (QString picture, pictureList) {
            PictureItem *pic = new PictureItem();
            pic->setId(pictureDir.absoluteFilePath(picture));
            pic->setName(QFileInfo(picture).baseName());
            pic->setPath("file:/" + pictureDir.absoluteFilePath(picture));
            appendRow(pic);
        }
    }
}



