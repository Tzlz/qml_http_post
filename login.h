#ifndef LOGIN_H
#define LOGIN_H

#include <QObject>
#include <QJsonObject>
#include <QtNetwork>
#include <QByteArray>
#include <QObject>

class Login : public QObject
{
    Q_OBJECT
public:
    explicit Login(QObject *parent = nullptr);

private:

    bool login_status;//登录状态

    int signStatus;//注册状态

public:
    Q_INVOKABLE void sign_IN(QString username,QString password);//登录

    Q_INVOKABLE bool getLoginStatus();//获取登录状态

    Q_INVOKABLE void sign_UP(QString username,QString password);//注册

    Q_INVOKABLE int getSignStatus();//获取注册状态

    Q_INVOKABLE void delayTime();

public slots:
    void sign_IN_Finished(QNetworkReply* reply);

    void sign_UP_Finished(QNetworkReply* reply);


};

#endif // LOGIN_H
