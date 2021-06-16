import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1
import QtQuick.Dialogs 1.2

Item {
    width: 1000
    height: 640

    property bool loginStatus

    Text {
        text: qsTr("登录DUSA")
        font.pointSize: 40
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.5
        y:parent.height/5
    }

Text {
        text: qsTr("账号或邮箱")
        font.pointSize: 12
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.5
        y:parent.height/3
    }
    //输入框-邮箱
    TextField{
        id:username
        objectName: "signin_username"
        placeholderText:qsTr("email")
        font.bold: true
        x:parent.width*0.5
        y:parent.height/2.6
        width: parent.width/4
        height: parent.height/12
        background: Rectangle{
            border.color: "steelblue"
        }
        function getUsername(){
            return username.getText()
        }
    }

    Text {
        text: qsTr("密码")
        font.pointSize: 12
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.5
        y:parent.height/1.9
    }

    //输入框-密码
    TextField{
        id:password
        objectName: "signin_password"
        placeholderText:qsTr("password")
        echoMode: TextInput.Password
        //        echoMode: TextInput.PasswordEchoOnEdit
        //        onAccepted: bt_signin.focus=true
        font.bold: true
        x:parent.width*0.5
        y:parent.height/1.7
        width: parent.width/4
        height: parent.height/12
        background: Rectangle{
            border.color: "#76B8C8"
        }
        function getPassword(){
            return password.getText()
        }
    }

    Button{
        id:bt_signin
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
        x:parent.width*0.5
        y:parent.height/1.4
        width: parent.width/4
        height: parent.height/10
        background: Rectangle{
            radius: 30
            color: "#76B8C8"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="steelblue"
                onReleased: parent.color="#76B8C8"
                onClicked: {
                    if(username.text==""&&password.text==""){
                        login_Failed.open()
                    }else{
                        http_login(username.text,password.text)
                    }
                }
            }
        }
    }

    MessageDialog {
        id: login_Failed
        title: qsTr("登录失败")
        text:"用户名或密码错误"
    }

    MessageDialog{
        id:login_successful
        text: "登录成功"

    }

    function loginDusa(){
        login.sign_IN(username.text,password.text)
        loginStatus=login.getLoginStatus()
        if(loginStatus==true){
            login_successful.open()
            //myloader.sourceComponent=home

        }
        if(loginStatus==false){
            login_Failed.open()
        }
    }


    Text {
        id: forget
        text: qsTr("忘记密码")
        color: "#76B8C8"
        font.bold: true
        x:parent.width*0.6
        y:parent.height/1.2
        MouseArea{
            anchors.fill: parent
            onPressed: parent.color="red"
            onReleased: parent.color="#76B8C8"
            onClicked: {

            }
        }
    }

    Text {
        id: up
        text: qsTr("注册DUSA")
        font.bold: true
        color: "#76B8C8"
        x:parent.width*0.7
        y:parent.height/1.2

        MouseArea{
            anchors.fill: parent
            onPressed: parent.color="red"
            onReleased: parent.color="#76B8C8"
            onClicked: {
                myloader.sourceComponent=signup
            }
        }
    }

    //登录请求
    function http_login(user,pass) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/login";
        //var params = "username="+user+"&password="+pass;

        var json = JSON.stringify({"username":user, "password":pass});

        http.open("POST", url, true);
        //console.log(params)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
                if(obj.status==="Success"){
                    login_successful.open()
                    userID=obj.user_id
                    console.log(userID)
                    myloader.sourceComponent=home
                }else{
                    login_Failed.open()
                }
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }
}
