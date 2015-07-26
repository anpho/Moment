import bb.cascades 1.0
import anpho.appinfo 1.0

Page {
    titleBar: TitleBar {
        title: qsTr("about")
        appearance: TitleBarAppearance.Plain
        visibility: ChromeVisibility.Visible
        scrollBehavior: TitleBarScrollBehavior.Sticky
    }

    ScrollView {
        Container {
            Header {
                title: qsTr("Version")
            }
            ImageView {
                imageSource: "asset:///icon/ic_launcher.png"
                horizontalAlignment: HorizontalAlignment.Center
                topMargin: 50.0
                topPadding: 50.0
                verticalAlignment: VerticalAlignment.Top
            }
            Label {
                text: qsTr("Moment for BlackBerry 10")
                horizontalAlignment: HorizontalAlignment.Center
                topMargin: 20.0
            }
            Label {
                text: appinfo.getVersion()
                horizontalAlignment: HorizontalAlignment.Center
                bottomMargin: 10.0
            }
            Label {
                text: "© 2005－2014 douban.com, all rights reserved."
                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                horizontalAlignment: HorizontalAlignment.Center
                bottomMargin: 20.0
            }
            Header {
                title: qsTr("About Moment")
            }
            Label {
                multiline: true
                text: qsTr("Read everywhere, everytime.")
                bottomMargin: 20.0
                horizontalAlignment: HorizontalAlignment.Center
            }
            ImageView {
                imageSource: "asset:///about.png"
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                scalingMethod: ScalingMethod.AspectFit
            }
            Header {
                title: qsTr("Author")
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                topMargin: 50.0
                ImageView {
                    imageSource: "asset:///icon/avatar.png"
                }
                Label {
                    text: qsTr("Merrick Zhang\r\nFounder of anpho and CBDA\r\n(China BlackBerry Dev. Assoc.)")
                    multiline: true

                }
            }
            Container {
                topMargin: 50.0
                bottomMargin: 50.0
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    text: qsTr("My Homepage")
                    imageSource: "asset:///icon/ic_open.png"
                    onClicked: {
                        invokeHomePage.trigger("bb.action.OPEN")
                    }

                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    text: qsTr("My Apps")
                    imageSource: "asset:///icon/ic_open.png"
                    topMargin: 50.0
                    onClicked: {
                        invokeMyApps.trigger("bb.action.OPEN");
                    }

                }
            }
            Divider {

            }
            Header {
                opacity: 0.0
                topMargin: 50
            }

        }
    }
    attachedObjects: [
        Invocation {
            id: invokeMyApps
            query {
                invokeTargetId: "sys.appworld"
                invokeActionId: "bb.action.OPEN"
                uri: "appworld://vendor/26755"
            }
        },
        Invocation {
            id: invokeHomePage
            query {
                invokeTargetId: "sys.browser"
                invokeActionId: "bb.action.OPEN"
                uri: "http://anpho.github.io"
            }
        },
        AppInfo {
            id: appinfo
        }
    ]
    actionBarVisibility: ChromeVisibility.Overlay
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    actions: [
        InvokeActionItem {
            title: qsTr("Email Me")
            imageSource: "asset:///icon/ic_email_dk.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            query.invokeTargetId: "sys.pim.uib.email.hybridcomposer"
            query.invokeActionId: "bb.action.SENDEMAIL"
            query.uri: "mailto:anphorea@gmail.com"

        }
    ]
}
