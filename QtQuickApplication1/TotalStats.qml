import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Page {
    id: root
    property int value: 0
    NumberAnimation {
        id: na
        target: root
        property: "value"
        from: 0
        to: 100
        duration: 3000
        loops: 100
        running: true
    }


    header: Label {
        text: qsTr("Community Stats")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

        WaveProgressBar
        {
            id:wave_progessbar
            anchors.horizontalCenter: parent.horizontalCenter
            y:100
            value: root.value
        }

        CircleProgressBar
        {
            id:circle_progessbar
            anchors.horizontalCenter: parent.horizontalCenter
            y:300
            value: root.value
        }
        /* Back��ť��ʽ���� SwipeView �� setCurrentIndex() ��������������Ϊ 0��ֱ�ӷ��ص� Current ���� */
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Back")
            onClicked: swipeView.setCurrentIndex(0);
        }
    
}