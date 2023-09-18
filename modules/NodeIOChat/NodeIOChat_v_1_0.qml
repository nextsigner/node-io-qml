import QtQuick 2.0
import NodeIOQml 1.0

Rectangle{
    id: r
    border.color: 'white'
    border.width: 1
    color: 'black'
    property string user: 'anonimo'
    property string to: 'anonimo2'
    property string host: 'localhost'
    property int port: 3111
    NodeIOQml{
        id: nioqml
        user: r.user
        to: r.to
        host: r.host
        port: r.port
        onDataReceibed:{
            let d = new Date(Date.now())
            let sd=d.toString()
            let json=JSON.parse(data)
            log.text+='From: '+json.from+' '+sd+'\n'
            log.text+='To: '+json.to+'\n'
            log.text+='Data: '+json.data
            log.text+='\n\n'
        }
        onDataError:{
            log.text+='Error:\n'+e+'\n\n'
        }
    }
    Flickable{
        width: r.width
        height: r.height-40
        contentWidth: parent.width
        contentHeight: log.contentHeight+200
        Text{
            id: log
            width: r.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            font.pixelSize: 20
            color: 'white'
        }
    }
    Row{
        spacing: 10
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            id: label1
            text: '<b>'+r.user+'</b>'
            font.pixelSize: 20
            color: 'white'
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle{
            width: r.width-label1.contentWidth-20
            height: 40
            color: 'black'
            border.color: 'white'
            border.width: 2
            TextInput{
                //anchors.fill: parent
                width: parent.width-20
                height: parent.height
                anchors.centerIn: parent
                color: 'white'
                Keys.onReturnPressed: {
                    unik.sendToTcpServer(r.host, r.port, r.user, r.to, text)
                    text=''
                }
            }
        }
    }
    function addMsg(text){
        log.text+=text+'\n'
    }
}
