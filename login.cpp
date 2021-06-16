#include "login.h"

Login::Login(QObject *parent) : QObject(parent)
{

}

void Login::delayTime()
{
    QThread::sleep(10);
}

void Login::sign_IN(QString username,QString password)
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(sign_IN_Finished(QNetworkReply*)));

    //QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(sign_IN_Finished(QNetworkReply*)),Qt::QueuedConnection);
    request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://47.94.162.148:8000/api/login"));

    QJsonObject obj1;
    obj1["password"]=password;
    obj1["username"]=username;

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);

}

void Login::sign_IN_Finished(QNetworkReply * reply)
{
    QByteArray bytes = reply->readAll();
    // 获取http状态码
    QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);

    if(statusCode.isValid())
    {
        qDebug() << "status code=" << statusCode.toInt();
    }

    QNetworkReply::NetworkError err = reply->error();

    if(err != QNetworkReply::NoError)
    {
        qDebug() << "Failed: " << reply->errorString();
    }
    else
    {
        // 获取返回内容
        qDebug() << "loginResultJson is:" <<  QString::fromStdString(bytes.toStdString());
        //loginResultJson = QString::fromStdString(bytes.toStdString());
    }

    QJsonParseError json_error;
    QJsonDocument parse_doucment = QJsonDocument::fromJson(bytes, &json_error);
    if(json_error.error == QJsonParseError::NoError)
    {
        if(parse_doucment.isObject())
        {
            QJsonObject obj = parse_doucment.object();
            if(obj.contains("status"))
            {
                QJsonValue value = obj.take("status");
                qDebug()<<value;
                if(value=="Success"){
                    login_status=true;
                }
                if(value=="Failed"){
                    login_status=false;
                }
                qDebug()<<"login status:"<<login_status;
            }
        }
    }
}

bool Login::getLoginStatus()
{
    qDebug()<<login_status;
    return login_status;
}

void Login::sign_UP(QString username, QString password)
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(sign_IN_Finished(QNetworkReply*)));

    request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://47.94.162.148:8000/api/sign"));

    QJsonObject obj1;
    obj1["password"]=password;
    obj1["username"]=username;

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);

    qDebug()<<"login status:"<<login_status;
}

void Login::sign_UP_Finished(QNetworkReply *reply)
{
    QByteArray bytes = reply->readAll();
    // 获取http状态码
    QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);

    if(statusCode.isValid())
    {
        qDebug() << "status code=" << statusCode.toInt();
    }

    QNetworkReply::NetworkError err = reply->error();

    if(err != QNetworkReply::NoError)
    {
        qDebug() << "Failed: " << reply->errorString();
    }
    else
    {
        // 获取返回内容
        qDebug() << "loginResultJson is:" <<  QString::fromStdString(bytes.toStdString());
        //loginResultJson = QString::fromStdString(bytes.toStdString());
    }

    QJsonParseError json_error;
    QJsonDocument parse_doucment = QJsonDocument::fromJson(bytes, &json_error);
    if(json_error.error == QJsonParseError::NoError)
    {
        if(parse_doucment.isObject())
        {
            QJsonObject obj = parse_doucment.object();
            if(obj.contains("status"))
            {
                QJsonValue value = obj.take("status");
                qDebug()<<value;
                if(value=="Success"){
                    signStatus=0;
                }
                if(value=="Failed"){

                }
                qDebug()<<login_status;
            }
        }
    }
}

int Login::getSignStatus()
{
    return signStatus;
}
