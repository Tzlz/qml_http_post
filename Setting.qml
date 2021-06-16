import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Item {
    width: 1000
    height: 640

    //修改个人资料
    function modify_inf(userID,desc) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/change_desc";
        var json = JSON.stringify({"user_id":userID,"desc":desc});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                if(obj.status==="Success"){
                    modify_description=desc
                    modify_success.open()
                    myloader.sourceComponent=home
                    console.log("modify success")
                }else{
                    modify_failure.open()
                    console.log("modify failure")
                    //release_failure.open()
                }
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    MessageDialog{
        id:modify_success
        text: "修改成功"
    }

    MessageDialog{
        id:modify_failure
        text: "修改失败"
    }

    Text {
        text: qsTr("更改你人资料")
        font.bold: true
        font.pixelSize: 30
        color: "#76B8C8"
        x:parent.width/3.5
        y:parent.height/6
    }

    Text {
        text: qsTr("头像")
        font.bold: true
        font.pixelSize: 20
        color: "#76B8C8"
        x:parent.width/3.5
        y:parent.height/3.5
    }

    //打开文件，选择图像
    FileDialog{
        id:fds
        title: "选择文件"
        folder: shortcuts.desktop
        selectExisting: true
        selectFolder: false
        selectMultiple: false
        nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
        onAccepted: {
            fds.fileUrl
            //icon=fds.fileUrl
            console.log("You chose: " + fds.fileUrl);
        }

        onRejected: {
            console.log("Canceled");
            //Qt.quit();
        }
    }

    //更换头像
    Button{
        width: parent.width/12
        height: parent.height/8
        x:parent.width/2.7
        y:parent.height/3.8
        background: Rectangle{
            radius: 40
            border.color: "#76B8C8"
            Image {
                source: "/images/camera.png"
                width: parent.width/2
                height: parent.height/2
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="white"
                onClicked: {
                    fds.open()
                }
            }
        }
    }

    Text {
        text: qsTr("用户名")
        font.bold: true
        font.pixelSize: 20
        color: "#76B8C8"
        x:parent.width/3.5
        y:parent.height/2.5
    }

    TextField{
        id:modify_username
        font.pointSize: 15
        color: "#76B8C8"
        placeholderText:qsTr("your Name")
        width: parent.width/5
        height: parent.height/13
        x:parent.width/3.5
        y:parent.height/2.2
        background: Rectangle{
            border.color: "#76B8C8"

        }
    }

    Text {
        text: qsTr("介绍")
        font.bold: true
        font.pixelSize: 20
        color: "#76B8C8"
        x:parent.width/3.5
        y:parent.height/1.7
    }

    TextArea{
        id:js
        width: parent.width/5
        height: parent.height/6
        x:parent.width/3.5
        y:parent.height/1.5
        wrapMode:TextEdit.Wrap//换行
        placeholderText:qsTr("About you")
        font.pixelSize: 20
        background: Rectangle{
            border.color: "#76B8C8"
        }
        text: js.text
    }

    //button-取消
    Button{
        Text {
            text: qsTr("返回主页")
            font.pointSize: 15
            anchors.centerIn: parent
        }
        width: parent.width/8
        height: parent.height/15
        x:parent.width*0.7
        y:parent.height*0.65
        background: Rectangle{
            radius: 20
            color: "#EDF3F5"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#EDF3F5"
                onClicked: {
                    myloader.sourceComponent=home
                }
            }
        }
    }

    //button-确认修改
    Button{
        id:modify
        Text {
            text: qsTr("完成")
            font.pointSize: 15
            anchors.centerIn: parent
        }
        width: parent.width/8
        height: parent.height/15
        x:parent.width*0.7
        y:parent.height*0.75
        background: Rectangle{
            radius: 20
            color: "#EDF3F5"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#EDF3F5"
                onClicked: {
                    modify_inf(userID,js.text)
                }
            }
        }
    }


}
