import bb.cascades 1.0
import bb.system 1.0

Page {
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    actionBarVisibility: ChromeVisibility.Visible
    property alias url: web.url
    property string originalurl: ""
    property bool readMode: true

    onReadModeChanged: {
        if (! readMode) {
            web.settings.userStyleSheetLocation = "asset:///reader.css"
            _app.setValue("readMode", "off");
        } else {
            web.settings.userStyleSheetLocation = "asset:///reader-black.css"
            _app.setValue("readMode", "on");
        }
    }
    onCreationCompleted: {
        if (_app.getValue("readMode", "off") === "on") {
            readMode = true;
        } else {
            readMode = false;
        }
    }
    onUrlChanged: {
        console.log(url)
    }
    ScrollView {

        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        Container {
            ProgressIndicator {
                id: pindic
                toValue: 100.0
                value: web.loadProgress
                visible: web.loading
                horizontalAlignment: HorizontalAlignment.Fill
            }
            WebView {
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Fill
                id: web
                settings.userStyleSheetLocation: "asset:///reader-black.css"
                onCreationCompleted: {

                }
                contextMenuHandler: ContextMenuHandler {
                    onPopulating: {
                        event.abort()
                    }
                }
                settings.defaultFontSizeFollowsSystemFontSize: true
            }
        }
    }

    actions: [
        ActionItem {
            imageSource: "asset:///icon/icon_001.png"
            title: qsTr("Browser Back")+ Retranslate.onLocaleOrLanguageChanged
            enabled: web.canGoBack
            onTriggered: {
                web.goBack();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        InvokeActionItem {
            imageSource: "asset:///icon/icon_189.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            title: qsTr("Share URL")+ Retranslate.onLocaleOrLanguageChanged
            query {
                mimeType: "text/plain"
                invokeActionId: "bb.action.SHARE"
            }
            onTriggered: {
                data = encodeURI(url);
            }
        },
        ActionItem {
            imageSource: "asset:///icon/icon_170.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            title: qsTr("Open current page in Browser")+ Retranslate.onLocaleOrLanguageChanged
            onTriggered: {
                Qt.openUrlExternally(web.url)
            }
        },
        ActionItem {
            imageSource: "asset:///icon/icon_170.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            title: qsTr("Open post in Browser")+ Retranslate.onLocaleOrLanguageChanged
            onTriggered: {
                Qt.openUrlExternally(originalurl)
            }
            enabled: originalurl.length > 5
        },
        ActionItem {
            imageSource: "asset:///icon/icon_211.png"
            title: qsTr("ReaderMode")+ Retranslate.onLocaleOrLanguageChanged
            onTriggered: {
                readMode = ! readMode;
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
}
