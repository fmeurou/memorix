#ifndef PICTUREITEM_H
#define PICTUREITEM_H

#include <QObject>
#include "listmodel.h"

class PictureItem : public ListItem
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id CONSTANT)
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString path READ path CONSTANT)
    Q_PROPERTY(bool isDir READ isDir CONSTANT)


public:
    enum    Roles   {
        Name = Qt::UserRole + 1,
        Path,
        IsDir,
        Id
    };

public:
    PictureItem(QObject *parent = 0);
    QString name() const;
    QString id() const;
    QString path() const;
    bool isDir() const;
    void setName(QString);
    void setId(QString);
    void setPath(QString v_path = "qrc:/icons/folder.png");
    void setIsDir(bool);

    QHash<int, QByteArray> roleNames() const;
    QVariant data(int role) const;

private:
    QString m_name, m_id, m_path;
    bool m_isDir;


};

#endif // PICTUREITEM_H
