#include "pictureitem.h"

PictureItem::PictureItem(QObject *parent) :
    ListItem(parent)
{
}

QString PictureItem::name() const   {return m_name;}
void PictureItem::setName(QString v_name) {m_name = v_name;}
QString PictureItem::id() const   {return m_id;}
void PictureItem::setId(QString v_id) {m_id = v_id;}
QString PictureItem::path() const   {return m_path;}
void PictureItem::setPath(QString v_path) {m_path = v_path;}

QHash<int, QByteArray> PictureItem::roleNames() const
{
  QHash<int, QByteArray> names;
  names[Id] = "id";
  names[Name] = "name";
  names[Path] = "path";
  return names;
}

QVariant PictureItem::data(int role) const  {
    switch(role)    {
        case Id: return m_id;
        case Name: return m_name;
        case Path: return m_path;
    }
    return QVariant();
}

