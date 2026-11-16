import QtQuick 2.5

Rectangle {
    id: root
    color: "black"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit / 4)
        }

        Image {
            id: logo
            // Increased size
            property real size: units.gridUnit * 20

            // Position at the top center with comfortable breathing room
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.25
            anchors.horizontalCenter: parent.horizontalCenter

            source: "images/freedom.png"

            // Explicit dimensions + PreserveAspectFit prevent stretching/clipping
            width: size
            height: size
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true

            // Render at high resolution so upscaling stays sharp
            sourceSize.width: size * 2
            sourceSize.height: size * 2
        }

        Image {
            id: busyIndicator
            y: logo.y + logo.height + (parent.height - (logo.y + logo.height)) / 2 - height / 2
            anchors.horizontalCenter: parent.horizontalCenter

            source: "images/busy01.svg"
            sourceSize.height: units.gridUnit * 3
            sourceSize.width: units.gridUnit * 3

            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 800
                loops: Animation.Infinite
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
