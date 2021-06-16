#ifndef HOME_OPERATE_H
#define HOME_OPERATE_H

#include <QObject>
#include <QJsonObject>
#include <QtNetwork>
#include <QByteArray>
#include <QObject>

class Home_Operate : public QObject
{
    Q_OBJECT
public:
    explicit Home_Operate(QObject *parent = nullptr);

signals:

public:
    Q_INVOKABLE void modify_information();//修改个人信息
    Q_INVOKABLE void getmodifystatus();//修改状态

    Q_INVOKABLE void release_blog();//发博

    Q_INVOKABLE void delete_blog(int blogID);//删博

    Q_INVOKABLE void following();//获取关注的人

    Q_INVOKABLE void followed();//获取关注我的人

private slots:   
    void modify_Finished(QNetworkReply* reply);

    void release_blog_Finished(QNetworkReply* reply);

    void delete_blog_Finished(QNetworkReply* reply);

    void following_Finished(QNetworkReply* reply);

    void followed_Finished(QNetworkReply* reply);


};

#endif // HOME_OPERATE_H
