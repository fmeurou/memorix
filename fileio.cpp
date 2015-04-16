#include "fileio.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

FileIO::FileIO(QObject *parent) :
    QObject(parent)
{

}

QString FileIO::read()
{
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QString();
    }
    //mSource = "/Users/fmeurou/Source/Memorize/" + mSource;
    QFile file(mSource);
    qDebug() << file.fileName() << file.isReadable();
    QString fileContent;
    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file );
        do {
            line = t.readLine();
            fileContent += line;
         } while (!line.isNull());

        file.close();
    } else {
        qDebug() << file.error() << file.errorString();
        emit error("Unable to open the file");
        return QString("{}");
    }
    qDebug() << fileContent;
    return fileContent;
}

bool FileIO::write(const QString& data)
{
    if (mSource.isEmpty())
        return false;

    QFile file(mSource);
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();

    return true;
}
