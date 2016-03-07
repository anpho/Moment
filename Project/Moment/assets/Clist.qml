import bb.cascades 1.0
import cn.anpho 1.0
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
    property string picurl
    onPicurlChanged: {
        webv.url = picurl.replace("https://", "http://");
    }
    implicitLayoutAnimationsEnabled: false
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
        implicitLayoutAnimationsEnabled: false
    }
    Label {
        id: caption
        multiline: true
        textStyle.fontSize: FontSize.Large
        textStyle.fontStyle: FontStyle.Default
        implicitLayoutAnimationsEnabled: false
    }
    Container {
        id: cont
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        leftPadding: 20.0
        rightPadding: 20.0
        implicitLayoutAnimationsEnabled: false
        WebImageView {
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
            touchPropagationMode: TouchPropagationMode.None
            scalingMethod: ScalingMethod.AspectFill
            loadEffect: ImageViewLoadEffect.None
            implicitLayoutAnimationsEnabled: false
            attachedObjects: LayoutUpdateHandler {
                onLayoutFrameChanged: {
                    webv.preferredHeight = layoutFrame.width;
                }
            }
            imageSource: "asset:///ic_default_image_square_light.png"
        }
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
            textStyle.fontSize: FontSize.Medium
            implicitLayoutAnimationsEnabled: false
        }
    }

}