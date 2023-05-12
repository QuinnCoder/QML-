import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5



Item {
    id: root
    property url normalUrl : "qrc:/images/close_normal.png"     //����״̬�µ�ͼƬ·��
    property url hoveredUrl : "qrc:/images/close_hover.png"    //����
    property url pressedUrl: "qrc:/images/close_hover.png"     //����
    property url disabledUrl : "qrc:/images/close_hover.png"   //����

    property alias imageItem: img           //ֱ�ӱ�������Imageʵ������������޸�����������
    property alias imageUrl: img.source     //��������ͼƬ·��

    property alias imageWidth: img.width
    property alias imageHeight: img.height
    property alias imageAnchors: img.anchors
    property alias containsMouse: area.containsMouse
    property alias containsPress: area.containsPress
    //����ź�
    signal clicked();
    Image {
        id: img
        anchors.fill: parent
        //Ĭ�ϰ����״̬ѡȡ��ͬ��ͼƬ
        source: root.enabled ? (containsPress ? pressedUrl : (containsMouse ? hoveredUrl : normalUrl)) : disabledUrl
    }

    MouseArea {
        id: area
        anchors.fill: parent;
        hoverEnabled: parent.enabled;
        onClicked: root.clicked();
        cursorShape: Qt.PointingHandCursor
        preventStealing: true
    }
}