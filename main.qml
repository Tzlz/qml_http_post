import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Styles 1.4

import MyLogin 1.0
import My_Home_Operate 1.0

Window {
    visible: true
    width: 1000
    height: 640
    title: qsTr("DUSA SOCIAL PALTFORM")

    property string modify_description
    property int i: 0
    property int userID//用户id
    property string photo_url//用户头像
    property var user_name
    property var ttext
    property var user_name6
    property var ttext6
    property var user_name7
    property var ttext7

    property var user_name5: []//mytweet user_name
    property var ttext5:[]//mytweet text
    property int length//mytweet length
    property var total_tweet5:[]//mytweet tweet_id:

    property var user_name3: []//total_tweet user_name
    property var ttext3:[]//total_tweet text
    property int length3//total_tweet length
    property var photo_url3:[]//total_tweet photo_url:
    property var total_tweet3:[]//total_tweet tweet_id:


    property var user_name1: []//followed user_name
    property var ttext1:[]//followed desc
    property int length1//followed length
    property var photo_url1:[]//followed photo_url:

    property var user_name2: []//following user_name
    property var ttext2:[]//following text
    property int length2//following length
    property var photo_url2:[]//following photo_url:


    property var description
    property var followingJson
    property var followedJson
    property var mytweetJson

    function getJsonLength(jsonData) {
        var length;
        for(var ever in jsonData) {
            length++;
        }
        return length;
    }


    //Loader加载不同组件，实现页面切换
    Loader{
        id:myloader
    }
    //开始加载登录注册界面
    Component.onCompleted:myloader.sourceComponent=sign

    //登录-注册Component
    Component{
        id:sign
        Sign{
        }
    }

    //注册-Component
    Component{
        id:signup
        Sign_up{
        }
    }

    //登录-Component
    Component{
        id:signin
        Sign_in{
        }
    }
    //主页-Component
    Component{
        id:home
        Home{
        }
    }
    //设置个人资料-Component
    Component{
        id:setting
        Setting{
        }
    }

    //关注的人-Component
    Component{
        id:following
        Following{

        }
    }

    //关注我的人-Component
    Component{
        id:followed
        Followed{

        }
    }

    Component{
        id:myTwitter
        MyTwitter{

        }
    }

    //Login
    Login{
        id:login

    }

    //getFollowing:
    function getFollowing(userID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/get_following";
        var json = JSON.stringify({"user_id":userID});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                followingJson = JSON.parse(http.responseText);
                console.log(followingJson)
                ttext7=followingJson.following_list[0].description
                user_name7=followingJson.following_list[0].username
                for(i;i<followingJson.follower_list.length1;i++){
                    user_name2.push(followingJson.following_list[i].username)
                    ttext2.push(followingJson.followering_list[i].desc)
                    total_tweet2.push(followingJson.following_list[i].tweet_id)
                }
                console.log(user_name2)
                console.log(ttext2)
                console.log(total_tweet2)


            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    //getFollowed:
    function getFollowed(userID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/get_follower";
        var json = JSON.stringify({"user_id":userID});

        http.open("POST", url, true);
        //console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                followedJson = JSON.parse(http.responseText);
                console.log(followedJson)
                length1=followedJson.follower_list.length
                console.log("l:"+length1)              
                ttext6=followedJson.follower_list[0].description
                console.log(ttext)
                user_name6=followedJson.follower_list[0].username
                console.log(user_name)
                for(i;i<followedJson.follower_list.length1;i++){
                    user_name1.push(followedJson.follower_list[i].username)
                    ttext1.push(followedJson.follower_list[i].desc)
                    total_tweet1.push(followedJson.follower_list[i].tweet_id)
                }
                console.log(user_name1)
                console.log(ttext1)
                console.log(total_tweet1)

            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    //mytweet:
    function getMytweets(userID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/personal_tweet";
        var json = JSON.stringify({"user_id":userID});

        http.open("POST", url, true);
        //console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                mytweetJson=JSON.parse(http.responseText)
                console.log(mytweetJson)
                ttext=mytweetJson.tweet_list[0].text
                console.log(ttext)
                user_name=mytweetJson.tweet_list[0].username
                console.log(user_name)
                length=mytweetJson.tweet_list.length
                console.log("l:"+length)
                for(i;i<mytweetJson.tweet_list.length;i++){
                    user_name5.push(mytweetJson.tweet_list[i].username)
                    ttext5.push(mytweetJson.tweet_list[i].text)
                    total_tweet5.push(mytweetJson.tweet_list[i].tweet_id)
                }
                console.log(user_name5)
                console.log(ttext5)
                console.log(total_tweet5)
                console.log(user_name5[2])
                console.log(ttext5[2])
                console.log(total_tweet5[2])
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    //mytotal_tweet:
    function getTotal_tweets(userID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/total_tweet";
        var json = JSON.stringify({"user_id":userID});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    //setting:
    function setting(username,userID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/profile";
        var json = JSON.stringify({"user_id":userID});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    //like
    function like(tweetID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/like";
        var json = JSON.stringify({"user_id":userID});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }

    //send_comment
    function send_comment(userID,tweetID) {
        var http = new XMLHttpRequest()
        var url = "http://47.94.162.148:8000/api/send_comment";
        var json = JSON.stringify({"user_id":userID,"tweet_id":tweetID});

        http.open("POST", url, true);
        console.log(json)
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", json.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function(){ // Call a function when the state changes.
            if (http.status === 200) {
                console.log(http.responseText)
                const obj = JSON.parse(http.responseText);
                console.log(obj)
            } else {
                console.log("error: " + http.status)
            }
        }
        http.send(json);
    }
}
