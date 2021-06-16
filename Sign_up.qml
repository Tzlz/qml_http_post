import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4
import Qt.labs.platform 1.1
import QtQuick.Dialogs 1.2

import MyLogin 1.0

Item {
    width: 1000
    height: 640

    Text {
        text: qsTr("注册DUSA账号")
        font.pointSize: 40
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.3
        y:parent.height/7
    }

    Text {
        text: qsTr("邮箱")
        font.pointSize: 12
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.3
        y:parent.height/3.5
    }
    TextField{
        id:email
        objectName: "signup_email"
        placeholderText:qsTr("email")
        font.bold: true
        x:parent.width*0.3
        y:parent.height/3
        width: parent.width/5
        height: parent.height/15
        background: Rectangle{
            border.color: "#76B8C8"
        }
        function setAccount(){
            return email.getText()
        }
    }

    Text {
        text: qsTr("用户名")
        font.pointSize: 12
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.3
        y:parent.height/2.3
    }
    TextField{
        id:username
        objectName: "signup_username"
        placeholderText:qsTr("username")
        font.pointSize: 10
        font.bold: true
        x:parent.width*0.3
        y:parent.height/2.1
        width: parent.width/5
        height: parent.height/15
        background: Rectangle{
            border.color: "#76B8C8"
        }

        function setUsername(){
            return username.getText()
        }
    }

    Text {
        text: qsTr("密码")
        font.pointSize: 12
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.3
        y:parent.height/1.7
    }
    TextField{
        id:password
        objectName: "signup_password"
        placeholderText:qsTr("password")
        echoMode: TextInput.Password
        font.bold: true
        x:parent.width*0.3
        y:parent.height/1.6
        width: parent.width/5
        height: parent.height/15
        background: Rectangle{
            border.color: "#76B8C8"
        }
    }

    Text {
        text: qsTr("确认密码")
        font.pointSize: 12
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.3
        y:parent.height/1.4
    }
    TextField{
        id:password_again
        objectName: "signup_password_again"
        placeholderText:qsTr("password")
        echoMode: TextInput.Password
        font.bold: true
        x:parent.width*0.3
        y:parent.height/1.3
        width: parent.width/5
        height: parent.height/15
        background: Rectangle{
            border.color: "#76B8C8"
        }
    }


    Button{
        //        text: "注册"
        //        //font.bold: true
        //        font.pointSize: 15
        Text {
            text: qsTr("注册")
            font.bold: true
            font.pointSize: 15
            color: "white"
            anchors.centerIn: parent
        }
        x:parent.width*0.7
        y:parent.height/1.3
        width: parent.width/10
        height: parent.height/20
        background: Rectangle{
            radius: 30
            color: "#76B8C8"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#76B8C8"
                onClicked: {
                    if(email.text==""){
                        emptyEmail.open()
                    }else if(username.text==""){
                        emptyUsername.open()
                    }else if(password.text==""){
                        emptyPassword.open()
                    }else if(password.text!=password_again.text){
                        wrongPsaaword.open()
                    }else{
                        http_sign(username.text,password.text)
                    }
                }
            }
        }
    }

    MessageDialog {
        id: sign_upMessageDialog
        title: qsTr("注册失败")
        text:"用户已存在"
    }

    MessageDialog {
        id: wrongPsaaword
        title: qsTr("注册失败")
        text:"密码错误"
    }
    MessageDialog {
        id: emptyEmail
        title: qsTr("注册失败")
        text:"请输入邮箱"
    }
    MessageDialog {
        id: emptyUsername
        title: qsTr("注册失败")
        text:"请输入用户名"
    }
    MessageDialog {
        id: emptyPassword
        title: qsTr("注册失败")
        text:"请输入密码"
    }


    MessageDialog {
        id: successfull
        text:"注册成功"
    }

    Button{
        //        text: "回到首页"
        //        //font.bold: true
        //        font.pointSize: 15
        Text {
            text: qsTr("回到首页")
            font.bold: true
            font.pointSize: 15
            color: "white"
            anchors.centerIn: parent
        }
        x:parent.width*0.7
        y:parent.height/1.5
        width: parent.width/10
        height: parent.height/20
        background: Rectangle{
            radius: 30
            color: "#76B8C8"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#76B8C8"
                onClicked: {
                    myloader.sourceComponent=sign
                }
            }
        }
    }


    //注册请求
    function http_sign(user,pass) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/register";
        var params = "username="+user+"&password="+pass;

        var json = JSON.stringify({"username":user, "password":pass});

        http.open("POST", url, true);
        console.log(params)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
                if(obj.status==="Success"){
                    successfull.open()
                    myloader.sourceComponent=sign
                }else if(obj.message==="User exist"){
                    sign_upMessageDialog.open()
                }
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }
}
