import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

Item {
    width: 1000
    height: 640
    Text {
        text: qsTr("世界在变化")
        font.pointSize: 40
        font.bold: true
         color: "#76B8C8"
        x:parent.width/1.7
        y:parent.height/5

    }
    Text {
        text: qsTr("加入DUSA")
        font.bold: true
        font.pointSize: 25
        color: "#76B8C8"
        x:parent.width/1.7
        y:parent.height/3
    }
    Button{
//        text: "注册"
//        font.bold: true
//        font.pointSize: 20
        Text {
            text: qsTr("注册")
            font.bold: true
            font.pointSize: 20
            color: "white"
            anchors.centerIn: parent
        }

        x:parent.width/1.7
        y:parent.height/2
        width: parent.width/5
        height: parent.height/10
        background: Rectangle{
            radius: 30
            color: "#76B8C8"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#76B8C8"
                onClicked: {
                    myloader.sourceComponent=signup
                }
            }
        }
    }

    Button{
//        text: "登录"
//        font.bold: true
//        font.pointSize: 20
        Text {
            text: qsTr("登录")
            font.bold: true
            font.pointSize: 20
            color: "white"
            anchors.centerIn: parent
        }
        x:parent.width/1.7
        y:parent.height/1.5
        width: parent.width/5
        height: parent.height/10
        background: Rectangle{
            radius: 30
            color: "#76B8C8"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#76B8C8"
                onClicked: {
                    myloader.sourceComponent=signin
                }
            }
        }
    }

}
