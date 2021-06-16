import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Item {
    id:homePage
    width: 1000
    height: 640

    //发推请求
    function relesae_twitter(twitterText,userID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/send_tweet";
        var json = JSON.stringify({"text":twitterText, "user_id":userID});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
                if(obj.status==="Success"){
                    release_success.open()
                    release.close()
                }else {
                    release_failure.open()
                }
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }


    MessageDialog{
        id:nologin
        text: "请先登录"
    }

    MessageDialog{
        id:release_success
        text: "成功"
    }
    MessageDialog{
        id:release_failure
        text:"失败"
    }


    //主页——左板块
    Rectangle{
        id:l
        height: parent.height
        width: parent.width/4
        anchors.left: parent.left
        border.color: "#76B8C8"

        //button-消息通知
        Button{
            text: qsTr("主页")
            font.pointSize: 13
            font.bold: true
            width: parent.width/2
            height: parent.height/15
            x:parent.width*0.3
            y:parent.height/6
            background: Rectangle{
                radius: 30
                color: "#EDF3F5"
                border.color: "#76B8C8"
                Image {
                    source: "/images/home.png"
                    width: parent.width/4
                    height: parent.height*0.8
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: parent.color="steelblue"
                    onReleased: parent.color="#EDF3F5"
                    onClicked: {
                        console.log("11")
                        //getTotal_tweets(userID)
                        getMytweets(userID)
                        myloader.sourceComponent=home
                    }
                }
            }
        }
        //button-被关注
        Button{
            text: qsTr("关注者")
            font.pointSize: 13
            font.bold: true
            width: parent.width/2
            height: parent.height/15
            x:parent.width*0.3
            y:parent.height/3.8
            background: Rectangle{
                radius: 30
                color: "#EDF3F5"
                border.color: "#76B8C8"
                Image {
                    source: "/images/user.png"
                    width: parent.width/4
                    height: parent.height*0.8
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: parent.color="steelblue"
                    onReleased: parent.color="#EDF3F5"
                    onClicked: {
                        console.log("11")
                        getFollowed(userID)
                        myloader.sourceComponent=followed

                    }
                }
            }
        }

        //button-已关注
        Button{
            text: qsTr("关注")
            font.pointSize: 13
            font.bold: true
            width: parent.width/2
            height: parent.height/15
            x:parent.width*0.3
            y:parent.height/2.8
            background: Rectangle{
                radius: 30
                color: "#EDF3F5"
                border.color: "#76B8C8"
                Image {
                    source: "/images/user.png"
                    width: parent.width/4
                    height: parent.height*0.8
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: parent.color="steelblue"
                    onReleased: parent.color="#EDF3F5"
                    onClicked: {
                        console.log("11")
                        getFollowing(userID)
                        myloader.sourceComponent=following

                    }
                }
            }
        }

        //button-设置个人资料
        Button{
            text: qsTr("个人资料")
            font.pointSize: 13
            font.bold: true
            width: parent.width/2
            height: parent.height/15
            x:parent.width*0.3
            y:parent.height/2.2
            background: Rectangle{
                radius: 30
                color: "#EDF3F5"
                border.color: "#76B8C8"
                Image {
                    source: "/images/setting.png"
                    width: parent.width/4
                    height: parent.height*0.8
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: parent.color="steelblue"
                    onReleased: parent.color="#EDF3F5"
                    onClicked: {
                        myloader.sourceComponent=setting
                        console.log("11")

                    }
                }
            }
        }

        //button-我的推特
        Button{
            text: qsTr("我的推特")
            font.pointSize: 13
            font.bold: true
            width: parent.width/2
            height: parent.height/15
            x:parent.width*0.3
            y:parent.height/1.8
            background: Rectangle{
                radius: 30
                color: "#EDF3F5"
                border.color: "#76B8C8"
                Image {
                    source: "/images/bussiness-man.png"
                    width: parent.width/4
                    height: parent.height*0.8
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: parent.color="steelblue"
                    onReleased: parent.color="#EDF3F5"
                    onClicked: {
                        getMytweets(userID)
                        myloader.sourceComponent=myTwitter
                        console.log("11")

                    }
                }
            }
        }



        //button-个人资料
        Button{
            id:personal
            width: parent.width/3
            height: parent.height/8
            x:parent.width*0.1
            y:parent.height/1.4
            background: Rectangle{
                radius: 40
                Image {
                    id:avatar
                    source: "/images/user-filling.png"
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: parent.color="steelblue"
                    onReleased: parent.color="#76B8C8"
                    onClicked: {
                        console.log("11")
                    }
                }
            }
        }
        TextArea{
            readOnly: true
            width: parent.width*0.5
            height: personal.height
            anchors.left: personal.right
            y:parent.height/1.3
            font.pointSize: 15
            color: "#76B8C8"
            text: modify_description
            background: Rectangle{
                //border.color: "red"
            }
        }
    }


    //主页——中部板块
    Rectangle{
        id:m
        height: parent.height
        width: parent.width/2
        anchors.left: l.right
        border.color: "#76B8C8"
        //中--顶
        Rectangle{
            id:t
            width: parent.width
            height: parent.height/8
            border.color: "#76B8C8"

            Image {
                id:homePic
                source: "/images/home.png"
                width: parent.width/6
                height: parent.height
            }
            Text {
                text: qsTr("主页")
                font.bold: true
                font.pointSize: 30
                anchors.left: homePic.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        //中--中
        Rectangle{
            width: parent.width
            height: parent.height/8
            border.color:"#76B8C8"
            anchors.top: t.bottom

            //发布博客
            Button{
                text: "发布"
                font.pointSize: 13
                width: parent.width/4
                height: parent.height/2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                background: Rectangle{
                    radius: 20
                    color: "#76B8C8"
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color="steelblue"
                        }
                        onReleased: parent.color="#76B8C8"
                        onClicked: {
                            release.open()
                            console.log("11")
                        }
                    }
                }
            }
            //弹出发布博客界面
            Popup{
                id:release
                width: parent.width*0.9
                height: parent.height*3
                x:parent.width/20
                y:parent.height/7
                background: Rectangle{
                    radius: 50
                    border.color: "#76B8C8"
                }
                Rectangle{
                    id:blogWord
                    width: parent.width
                    height: parent.height*0.6
                    y:parent.height*0.2
                    border.color: "#EDF3F5"
                    TextArea{
                        id:twitter_word
                        wrapMode:TextEdit.Wrap//换行
                        anchors.fill: parent
                        Image {
                            id:blogPic
                            width: parent.width/7
                            height: parent.height/2
                            source:picture_And_video.fileUrl
                            anchors.bottom: twitter_word.bottom
                        }
                    }
                }

                //退出发博
                Button{
                    width: parent.width/14
                    height: parent.height/7
                    anchors.bottom: blogWord.top
                    background: Rectangle{
                        radius: 15
                        border.color:"#76B8C8"
                        Image {
                            source: "/images/close-bold.png"
                            width: parent.width*0.8
                            height: parent.height*0.8
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressed: parent.color="steelblue"
                            onReleased: parent.color="white"
                            onClicked: {
                                release.close()
                            }
                        }
                    }
                }
                //上传图片
                Button{
                    width: parent.width/12
                    height: parent.height/6
                    x:parent.width/10
                    anchors.top: blogWord.bottom
                    background: Rectangle{
                        //border.color:"#76B8C8"
                        Image {
                            source: "/images/picture.png"
                            width: parent.width*0.8
                            height: parent.height*0.8
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressed: parent.color="#EDF3F5"
                            onReleased: parent.color="white"
                            onClicked: {
                                picture_And_video.open()
                            }
                        }
                    }
                }

                //上传视频
                Button{
                    width: parent.width/12
                    height: parent.height/6
                    x:parent.width/5
                    anchors.top: blogWord.bottom
                    background: Rectangle{
                        //border.color:"#76B8C8"
                        Image {
                            source: "/images/play.png"
                            width: parent.width
                            height: parent.height
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressed: parent.color="#EDF3F5"
                            onReleased: parent.color="white"
                            onClicked: {
                                picture_And_video.open()
                            }
                        }
                    }
                }

                //发布
                Button{
                    text: "发布"
                    font.pointSize: 12
                    width: parent.width/6
                    height: parent.height/6
                    anchors.right: parent.right
                    anchors.top: blogWord.bottom
                    background: Rectangle{
                        radius: 10
                        color: "#EDF3F5"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: parent.color="steelblue"
                            onReleased: parent.color="#EDF3F5"
                            onClicked: {
                                relesae_twitter(twitter_word.text,userID)
                            }
                        }
                    }
                }

                //打开文件，选择图像与视频
                FileDialog{
                    id:picture_And_video
                    title: "选择文件"
                    folder: shortcuts.desktop
                    selectExisting: true
                    selectFolder: false
                    selectMultiple: false
                    nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
                    onAccepted: {
                        picture_And_video.fileUrl
                        console.log("You chose: " + picture_And_video.fileUrl);
                    }
                    onRejected: {
                        console.log("Canceled");
                        //Qt.quit();
                    }
                }

            }
        }

        //中--底
        Rectangle{
            id:others
            width: parent.width
            height: parent.height*0.75
            border.color: "#76B8C8"
            anchors.bottom: parent.bottom

            ListModel{
                id:twitterModel
                property bool completed: false
                Component.onCompleted: {
                    append({"name": user_name, "tweet_text": ttext});
                    completed = true;

                }
            }

            //博客列表
            ListView {
                id: blog
                anchors.fill: parent
                model:twitterModel
                clip: true
                //verticalLayoutDirection: ItemView.BottomToTop
                delegate: ItemDelegate{
                    height: m.height/2
                    width: m.width
                    background: Rectangle{
                        border.color: "#76B8C8"
                        border.width: 1
                        TextField{
                            readOnly: true
                            width: parent.width*0.75
                            height: parent.height*0.6
                            x:parent.width/4.2
                            y:parent.height/50
                            background: Rectangle{
                                border.color: "#76B8C8"
                            }
                            Text {
                                text:ttext
                                x:parent.width/10
                                y:parent.height/4
                                wrapMode: Text.WordWrap //换行
                                font.pointSize: 15
                                color: "#76B8C8"
                            }
                        }
                        Rectangle{
                            id:photo
                            width: parent.width/6
                            height: parent.height/4
                            x:parent.width/20
                            y:parent.height/20
                            radius: 40
                            Image {
                                source: "/images/user-filling.png"
                                width: parent.width
                                height: parent.height
                                anchors.fill: parent
                            }
                        }
                        Text {
                            width: parent.width/6
                            height: parent.height/4
                            x:parent.width/20
                            anchors.top: photo.bottom
                            text: qsTr(user_name)
                            font.pointSize: 18
                            color: "#76B8C8"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    //点赞
                    Button{
                        x:parent.width*0.7
                        y:parent.height*0.8
                        width: parent.width/8
                        height: parent.height/6
                        background: Rectangle{
                            radius: 10
                            Image {
                                anchors.fill: parent
                                source: "/images/good.png"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onPressed: parent.color="#EDF3F5"
                                onReleased: parent.color="white"
                                onClicked: {

                                }
                            }
                        }
                    }
                    //评论
                    Button{
                        x:parent.width*0.4
                        y:parent.height*0.8
                        width: parent.width/8
                        height: parent.height/6
                        background: Rectangle{
                            radius: 10
                            border.color: "#EDF3F5"
                            Image {
                                anchors.fill: parent
                                source: "/images/elipsis.png"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onPressed: parent.color="#EDF3F5"
                                onReleased: parent.color="white"
                                onClicked: {
                                    comment.open()
                                }
                            }
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar{}
            }
        }

        Popup{
            id:comment
            width: blog.width*0.8
            height: blog.height/3
            x:parent.width*0.1
            y:parent.height/2.5
            background: Rectangle{
                border.color:  "#76B8C8"
            }
            Rectangle{
                id:w_commment
                anchors.top: parent.topInset
                width: parent.width*0.8
                height: parent.height/5
                TextArea{
                    anchors.fill: parent
                    text: ""
                }
                border.color:  "#76B8C8"
            }
            Button{
                width: parent.width*0.2
                height: w_commment.height
                Text {
                    text: qsTr("评论")
                    font.pointSize: 15
                    color:  "black"
                    anchors.verticalCenter: parent.verticalCenter
                    x:parent.width/3.5
                }
                x:parent.width*0.82
                background: Rectangle{
                    radius: 15
                    color: "#EDF3F5"
                    MouseArea{
                        anchors.fill: parent
                        onPressed: parent.color="steelblue"
                        onReleased: parent.color="#76B8C8"
                        onClicked: {

                        }
                    }
                }
            }

            Rectangle{
                id:comment_list
                width: parent.width
                height: parent.height*0.8
                anchors.top: w_commment.bottom
                ListView{
                    anchors.fill: parent
                    model: 2
                    delegate: ItemDelegate{
                        height: comment_list.height/2
                        width: comment_list.width
                        background: Rectangle{
                            border.color: "#76B8C8"
                            border.width: 1
                        }
                    }
                }
            }
        }
    }

    //主页——右板块
    Rectangle{
        id:r
        height: parent.height
        width: parent.width/4
        anchors.right: parent.right
        border.color: "#76B8C8"

        Text {
            text: qsTr("登录")
            font.pointSize: 13
            x:parent.width*0.7
            y:parent.height/50
            color: "#76B8C8"
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color="red"
                onReleased: parent.color="#76B8C8"
                onClicked: {
                    myloader.sourceComponent=signin
                }
            }

        }

        //搜索
        Rectangle{
            x:parent.width*0.1
            y:parent.height/8
            width: parent.width*0.8
            height: parent.height/15
            border.color: "#76B8C8"
            radius: 20

            TextField{
                placeholderText: "搜索"
                font.bold: true
                width: parent.width*0.8
                anchors.centerIn: parent
                Keys.enabled: true;
                Keys.onPressed: {
                    switch(event.key)
                    {
                    case Qt.Key_Enter:
                    }
                }

            }
        }

        Rectangle{
            x:parent.width*0.1
            width: parent.width*0.8
            height: parent.height*0.75
            anchors.bottom: parent.bottom
            //border.color: "red"

            Rectangle{
                width: parent.width
                height: parent.height*0.1
                border.color: "#76B8C8"
                Text {
                    text: qsTr("你可能感兴趣")
                    font.bold: true
                    font.pointSize: 12
                    color: "#76B8C8"
                    anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter

                }

            }
            //你感兴趣的用户
            Rectangle{
                width: parent.width
                height: parent.height*0.9
                anchors.bottom: parent.bottom
                border.color:"#76B8C8"

                ListView {
                    id: user
                    anchors.fill: parent
                    model: ListModel
                    //verticalLayoutDirection: ItemView.BottomToTop
                    delegate: Rectangle{
                        height: 80
                        width: parent.width
                        border.color: "#76B8C8"
                        border.width: 1
                    }
                    ScrollBar.vertical: ScrollBar{}
                }
            }

        }
        states: [
            State {
                name: "name"
                PropertyChanges {
                    target: object
                }
            }
        ]
    }
}

