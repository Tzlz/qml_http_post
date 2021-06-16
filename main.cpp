#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"login.h"
#include"home_operate.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("DUSA");
    QGuiApplication app(argc, argv);
    //Login *login=new Login();

    //QML方式：qmlRegisterType注册C++类型至QML
    //参数：qmlRegisterType<C++类型名> (import时模块名 主版本号 次版本号 QML中的类型名)
    qmlRegisterType<Login>("MyLogin", 1, 0, "Login");
    qmlRegisterType<Home_Operate>("My_Home_Operate", 1, 0, "Home_Operate");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
