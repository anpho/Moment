import bb.cascades 1.0

Container {
    gestureHandlers: [
        TapHandler {
            onTapped: {
                var r = reader.createObject();
                r.url = weburl;
                r.originalurl = originurl;
                navpane.push(r);
            }
        }
    ]
    leftPadding: 20
    rightPadding: 20
    property alias column: head.subtitle
    property alias title: caption.text
    property alias intro: lbl.text
    property alias picurl: webv.url
    property string weburl //reader url
    property string originurl //web originurl
    property string shorturl
    property variant author
    //author : uid/url/avatar/name
    property string likes
    property string comments
    property string style

    function update() {

    }

    Header {
        id: head
    }
    Label {
        id: caption
        multiline: true
        textStyle.fontSize: FontSize.Large
        textStyle.fontStyle: FontStyle.Default
    }
    Container {
        id: cont
        layout: StackLayout {
            orientation: (style === "10002") ? LayoutOrientation.RightToLeft : (style === "10003") ? LayoutOrientation.BottomToTop : LayoutOrientation.LeftToRight
        }
        leftPadding: 20.0
        rightPadding: 20.0
        Label {
            id: lbl
            visible: (style === "10003") ? false : true
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            multiline: true
            topMargin: 20.0
            leftMargin: 20.0
            rightMargin: 20.0
            bottomMargin: 20.0

        }
        WebView {
            id: webv
            visible: (style === "10002" || style === "10003")
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            topMargin: 20.0
            leftMargin: 20.0
            rightMargin: 20.0
            bottomMargin: 20.0
            //            maxWidth: (style === "10002") ? 333 : cont.maxWidth
            horizontalAlignment: HorizontalAlignment.Fill
            settings.zoomToFitEnabled: true

            touchPropagationMode: TouchPropagationMode.None
        }
        attachedObjects: LayoutUpdateHandler {
            onLayoutFrameChanged: {
                webv.maxWidth = (style === "10002") ? 333 : layoutFrame.width;
            }
        }
    }

}