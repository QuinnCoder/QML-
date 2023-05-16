import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Page {
    header: Label {
        text: qsTr("Current")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    MyClock{	//ʵ������һ���ļ����ļ����Ƶ�һ��Ҫ��д
            id:clock
            anchors.centerIn: parent
        }

    Label {
        text: qsTr("Current activity")
        anchors.centerIn: parent
    }
}