/* =================================================
 * This file is part of the TTK Music Player project
 * Copyright (c) 2014 - 2016 Greedysky Studio
 * All rights reserved!
 * Redistribution and use of the source code or any derivative
 * works are strictly forbiden.
   =================================================*/

import QtQuick 2.4
import QtMultimedia 5.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import "Core"

Rectangle{
    id: ttkMusicVideoPage
    width: parent.width
    height: parent.height

    Column{
        Rectangle{
            color: "black"
            width: ttkMusicVideoPage.width
            height: ttkMusicVideoPage.height - dpHeight(50)

            MediaPlayer{
                id: videoPlayer
                source: "http://112.25.9.182/hd.yinyuetai.com/uploads/videos/common/F871015476463CE20C9F9BA645A05880.flv?sc=c5de1f9541cb51f7&br=1095&rd=Android"
                autoPlay: true
                volume: 1
            }

            VideoOutput {
                anchors.fill: parent
                source: videoPlayer
            }
        }

        Rectangle {
            color: ttkTheme.alphaLv15
            width: ttkMusicVideoPage.width
            height: dpHeight(50)

            Row {
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: dpWidth(10)
                anchors.left: parent.left

                TTKImageButton {
                    width: dpWidth(30)
                    height: dpHeight(30)
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/image/test"

                    property int status: 1
                    onPressed: {
                        if(status === 1) {
                            videoPlayer.pause();
                            status = 0;
                            source = "qrc:/image/test";
                        }else{
                            videoPlayer.play();
                            status = 1;
                            source = "qrc:/image/test";
                        }
                    }
                }

                Text {
                    width: dpWidth(60)
                    id: positionLabel
                    text: TTK_UTILS.normalizeTime(videoPlayer.position, "mm:ss");
                    color: ttkTheme.white
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                }

                Slider {
                    id: videoTimeSlider
                    width: ttkMusicVideoPage.width - dpWidth(30)*6
                    height: dpHeight(30)
                    minimumValue: 0
                    maximumValue: videoPlayer.duration <= 0 ? 1 : videoPlayer.duration
                    anchors.verticalCenter: parent.verticalCenter
                    value: videoPlayer.position

                    function sliderGeometry() {
                        return (videoTimeSlider.value - videoTimeSlider.minimumValue) /
                               (videoTimeSlider.maximumValue - videoTimeSlider.minimumValue);
                    }

                    style: SliderStyle{
                        groove: Row {
                            Rectangle{
                                implicitWidth: videoTimeSlider.width*videoTimeSlider.sliderGeometry()
                                implicitHeight: dpHeight(3)
                                color: ttkTheme.topbar_background
                            }

                            Rectangle{
                                implicitWidth: videoTimeSlider.width*(1-videoTimeSlider.sliderGeometry())
                                implicitHeight: dpHeight(3)
                                color: ttkTheme.gray
                            }
                        }

                        handle: Rectangle{
                            anchors.centerIn: parent;
                            color: ttkTheme.topbar_background
                            width: dpWidth(20)
                            height: dpHeight(20)
                            radius: dpWidth(10)
                        }
                    }

                    MouseArea {
                        id: videoTimeSliderArea
                        anchors.fill: parent
                        onPressed: {
                            if(videoPlayer.seekable) {
                                var pos = videoPlayer.duration * mouse.x / parent.width
                            }
                            videoPlayer.seek(pos)
                            videoTimeSlider.value = pos;
                        }
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    width: dpWidth(60)
                    id: durationLabel
                    text: TTK_UTILS.normalizeTime(videoPlayer.duration, "mm:ss");
                    color: ttkTheme.white
                }
            }
        }
    }
}