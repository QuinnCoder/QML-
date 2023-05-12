import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
 
//canvas���Ʋ��˽�����
//������ 2022-02-10
Item {
    id: control
 
    implicitHeight: 160
    implicitWidth: 160
 
    property real from: 0 //��Сֵ
    property real to: 100 //���ֵ
    property real value: 0 //��ǰֵ
    property real percent: (value-from)/(to-from) //�ٷֱ�[0,1]
    //
    property int canvasMargin: 3
    property int canvasWidth: width < height ? width : height
    //
    property int fontPx: 34
    property string fontFamily: "Arial"
    property color waveColor: "#0486FF"
    property int waveBorder: 6
    property int waveRadius: canvasWidth / 2 - canvasMargin - waveBorder
    //
    property real waveWidth: 0.05   //���˿��,��ԽСԽ��
    property real waveHeight: 5     //���˸߶�,��Խ��Խ��
    property real speed: 0.1        //�����ٶ�,��Խ���ٶ�Խ��
    property real offset: 0         //����xƫ����,���ڶ���
 
    Canvas {
        id: canvas
        width: canvasWidth
        height: canvasWidth
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, canvasWidth, canvasWidth);
            ctx.lineCap = "round";
 
            ctx.save();
            ctx.beginPath();
            ctx.arc(canvasWidth/2, canvasWidth/2, waveRadius+waveBorder-canvasMargin, 0, 2*Math.PI);
            ctx.lineWidth = waveBorder;
            var color_offset = offset>Math.PI?(1-(offset-Math.PI)/Math.PI):(offset/Math.PI);
            ctx.strokeStyle = Qt.lighter(waveColor, 1.5+0.3*color_offset);
            ctx.stroke();
 
            var progress_text = qsTr("%1 %").arg(parseInt(percent*100));
            ctx.font = fontPx + "px '" + fontFamily + "'";
            ctx.textAlign = "center";
            ctx.fillStyle = waveColor;
            //canvas����߶Ⱥ;��л��е�����
            ctx.fillText(progress_text, canvasWidth/2, canvasWidth/2+fontPx/2-5);
 
            ctx.save();
            ctx.beginPath();
            ctx.lineWidth = 0;
            ctx.arc(canvasWidth/2, canvasWidth/2, waveRadius, 0, 2*Math.PI);
            ctx.clip();
            drawWave(ctx, waveColor, 0, 0, false);
            ctx.clip();
            ctx.font = fontPx + "px '" + fontFamily + "'";
            ctx.textAlign = "center";
            ctx.fillStyle = "white";
            ctx.fillText(progress_text, canvasWidth/2, canvasWidth/2+fontPx/2-5);
            ctx.restore();
        }
 
        //���ʣ���ɫ��xƫ�ƣ�yƫ�ƣ��Ƕ�ֵȡ��
        function drawWave(ctx, w_color, x_offset, y_offset, reverse)
        {
            ctx.beginPath();
            var x_base = canvasWidth/2-waveRadius;
            var y_base = canvasWidth/2+waveRadius-waveRadius*2*percent;
            //���Ҳ��ˣ������경��Ϊ5px���Ҳ���5��Ϊ������㲽���Ĳ���
            for(var x_value = 0; x_value <= waveRadius*2 + 5; x_value += 5){
                var y_value = waveHeight*Math.sin((reverse?-1:1)*(x_value)*waveWidth+offset+x_offset)+y_offset;
                ctx.lineTo(x_base+x_value, y_base+y_value);
            }
            //���ҵײ�Χ��ʵ��
            ctx.lineTo(canvasWidth/2+waveRadius, canvasWidth/2+waveRadius);
            ctx.lineTo(canvasWidth/2-waveRadius, canvasWidth/2+waveRadius);
            ctx.closePath();
            ctx.fillStyle = w_color;
            ctx.fill();
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