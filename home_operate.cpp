#include "home_operate.h"

Home_Operate::Home_Operate(QObject *parent) : QObject(parent)
{

}

void Home_Operate::modify_information()
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(modify_Finished(QNetworkReply*)));

    request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://192.168.31.115:8000/api/sign"));

    QJsonObject obj1;

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);
}

void Home_Operate::modify_Finished(QNetworkReply *reply)
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
}

void Home_Operate::getmodifystatus()
{

}

void Home_Operate::release_blog()
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(release_blog_Finished(QNetworkReply*)));

    //request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://192.168.31.115:8000/api/sign"));

    QJsonObject obj1;

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);
}

void Home_Operate::release_blog_Finished(QNetworkReply *reply)
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
}

void Home_Operate::delete_blog(int blogID)
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(delete_blog_Finished(QNetworkReply*)));

    //request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://192.168.31.115:8000/api/sign"));

    QJsonObject obj1;
    obj1.insert("blogID",blogID);

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);
}

void Home_Operate::delete_blog_Finished(QNetworkReply *reply)
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
}

void Home_Operate::following()
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(following_Finished(QNetworkReply*)));

    //request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://192.168.31.115:8000/api/sign"));

    QJsonObject obj1;

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);
}

void Home_Operate::following_Finished(QNetworkReply *reply)
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
}
void Home_Operate::followed()
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(followed_Finished(QNetworkReply*)));

    //request.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/json"));
    request.setUrl(QUrl("http://192.168.31.115:8000/api/sign"));

    QJsonObject obj1;

    QByteArray byte_array = QJsonDocument(obj1).toJson();

    qDebug()<< "user info: " << obj1;
    qDebug()<< "user info: " <<byte_array;
    QNetworkReply* reply = naManager->post(request,byte_array);
}

void Home_Operate::followed_Finished(QNetworkReply *reply)
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
}
