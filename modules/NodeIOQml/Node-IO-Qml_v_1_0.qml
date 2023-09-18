import QtQuick 2.0
import unik.UnikQProcess 1.0

/*
Ejemplo de uso: unik.sendToTcpServer(r.host, r.port, r.user, r.to, text)
*/

Item{
    id: r
    property string user: 'node-io-qml'
    property string to: 'all'
    property string indexPath: '/home/ns/nsp/node-io-sc/index.js'
    property string host: 'localhost'
    property int port: 3111
    signal dataReceibed(string data)
    signal dataError(string e)
    UnikQProcess{
        id: uqp
        onLogDataChanged:{
            try{
              let json=JSON.parse(logData)
              r.dataReceibed(JSON.stringify(json))
            }catch(e){
                let error='LogData del error: ['+logData+']\n'
                error+='Descripción del error: ['+e+']\n\n'
                r.dataError(error);
                //console.error(e);
            }
        }
        Component.onCompleted: {
            let cmd='node '
            cmd+=' '+r.indexPath
            cmd+=' '+r.user
            cmd+=' node-io-ss'//+r.to
            cmd+=' conectado'
            cmd+=' host='+r.host
            cmd+=' port='+r.port
            console.log('Node-IO-Qml uqp cmd: '+cmd)
            run(cmd)
        }
    }
    function send(to, data){
        let cmd='node '
        cmd+=' '+r.indexPath
        cmd+=' '+r.user
        cmd+=' '+r.to
        cmd+=' '+data
        mkProcces(cmd)
    }
    function mkProcces(cmd){
        let d=new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='    }\n'
        c+='    Component.onCompleted: {\n'
        c+='        //run(\''+cmd+'\')\n'
        c+='    }\n'
        c+='}\n'
        let obj=Qt.createQmlObject(c, r, 'uqpcode')
    }
}
