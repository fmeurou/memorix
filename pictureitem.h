#ifndef PICTUREITEM_H
#define PICTUREITEM_H

#include <QObject>
#include "listmodel.h"

class PictureItem : public ListItem
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId)
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString path READ path WRITE setPath)


public:
    enum    Roles   {
        Name = Qt::UserRole + 1,
        Path,
        Id
    };

public:
    PictureItem(QObject *parent = 0);
    QString name() const;
    QString id() const;
    QString path() const;
    void setName(QString);
    void setId(QString);
    void setPath(QString);

    QHash<int, QByteArray> roleNames() const;
    QVariant data(int role) const;

private:
    QString m_name, m_id, m_path;


};

#endif // PICTUREITEM_H
