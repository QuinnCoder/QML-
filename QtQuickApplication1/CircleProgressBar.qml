import QtQuick 2.12
import QtQuick.Controls 2.12
 
//canvas���ƻ��ν�����
//������ 2022-02-10
Item {
    id: control
 
    implicitWidth: 160
    implicitHeight: 160
 
    property real from: 0 //��Сֵ
    property real to: 100 //���ֵ
    property real value: 0 //��ǰֵ
    property real percent: (value-from)/(to-from) //�ٷֱ�[0,1]
    //
    property int canvasMargin: 3
    property int canvasWidth: width < height ? width : height
    property int canvasRadius: canvasWidth / 2 - canvasMargin
    property int lineWidth: 16
    property int lineBorder: 6
    property color bgColor: "#0486FF"
    property color valueColor: "#0486FF"
    //
    property real _valueAngle: Math.PI/2+Math.PI*2*percent
    on_ValueAngleChanged: canvas.requestPaint()
    //
    property real speed: 0.1
    property real offset: 0
 
    Canvas {
        id: canvas
        width: canvasWidth
        height: canvasWidth
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, canvasWidth, canvasWidth);
            ctx.lineCap = "round";
 
            drawBg(ctx);
            drawValue(ctx);
        }
 
        //context.arc(x,y,r,sAngle,eAngle,counterclockwise);
        //x:Բ�����ĵ�x���ꡣ
        //y:Բ�����ĵ�y���ꡣ
        //r:Բ�İ뾶��
        //sAngle:��ʼ�ǣ��Ի��ȼơ�������Բ�ε�������λ����0�ȣ���
        //eAngle:�����ǣ��Ի��ȼơ�
        //counterclockwise:��ѡ������False=˳ʱ�룬true=��ʱ�롣
        function drawBg(ctx)
        {
            var color_offset = offset>Math.PI?(1-(offset-Math.PI)/Math.PI):(offset/Math.PI);
 
            ctx.beginPath();
            ctx.arc(canvasWidth/2, canvasWidth/2, canvasRadius-lineWidth/2-lineBorder, 0, 2*Math.PI);
            ctx.lineWidth = lineWidth+lineBorder*2;
            ctx.strokeStyle = Qt.lighter(bgColor, 1.7+0.2*color_offset);
            ctx.stroke();
 
            ctx.beginPath();
            ctx.arc(canvasWidth/2, canvasWidth/2, canvasRadius-lineWidth/2-lineBorder, 0, 2*Math.PI);
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = Qt.lighter(bgColor, 1.6+0.2*color_offset);
            ctx.stroke();
        }
 
        function drawValue(ctx)
        {
            //ctx.save();
            //����ӰЧ��ʱcpuռ����������
            //ctx.shadowColor= valueColor;
            //ctx.shadowBlur= lineWidth/4;
            ctx.beginPath();
            ctx.arc(canvasWidth/2, canvasWidth/2, canvasRadius-lineWidth/2-lineBorder, Math.PI/2, _valueAngle, false);
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = valueColor;
            ctx.stroke();
            //ctx.restore();
        }
 
        Text {
            id: txt
            anchors.centerIn: parent
            font.family: "Microsoft YaHei"
            font.pixelSize: (canvasWidth-lineWidth)/6;
            font.bold: true
            color: valueColor
            text: qsTr("%1 %").arg(control.percent.toFixed(2)*100);
        }
    }
 
    //�ö�ʱ��ˢ��
    Timer {
        running: visible
        repeat: true
        interval: 35
        onTriggered:{
            //�����ƶ�
            offset += speed;
            offset %= Math.PI*2;
            canvas.requestPaint();
        }
    }
    /*NumberAnimation {
        target: control
        running: visible
        loops: -1
        property: "offset"
        from: 0
        duration: 2000
        to: Math.PI*2
    }
    onOffsetChanged: canvas.requestPaint();*/
}