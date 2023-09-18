import QtQuick 2.7
import QtQuick.Controls 2.0
import NodeIOChat 1.0

ApplicationWindow{
    id: app
    visible: true
    visibility: 'Maximized'
    color: 'black'
    Item{
        id: xApp
        anchors.fill: parent
        Row{
            anchors.centerIn: parent
            NodeIOChat{
                id: niochat1
                user: 'user1'
                to: 'user2'
                width: xApp.width/2
                height: xApp.height
                host: '192.168.1.43'
                port: 3111
            }
            NodeIOChat{
                id: niochat2
                user: 'user2'
                to: 'user1'
                width: xApp.width/2
                height: xApp.height
                host: niochat1.host
                port: niochat1.port
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
}
