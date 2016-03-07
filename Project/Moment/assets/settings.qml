import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: qsTr("Settings")+ Retranslate.onLocaleOrLanguageChanged
        visibility: ChromeVisibility.Visible
        appearance: TitleBarAppearance.Plain
        scrollBehavior: TitleBarScrollBehavior.NonSticky
    }
    ScrollView {

        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Top

            Header {
                title: qsTr("Theme") + Retranslate.onLocaleOrLanguageChanged
            }
            Container {
                leftPadding: 20.0
                rightPadding: 20.0
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    horizontalAlignment: HorizontalAlignment.Left
                    text: qsTr("Choose theme from the dropdown list") + Retranslate.onLocaleOrLanguageChanged
                }
                DropDown {
                    id: themeDropDown
                    title: qsTr("Theme") + Retranslate.onLocaleOrLanguageChanged

                    Option {
                        text: qsTr("Bright") + Retranslate.onLocaleOrLanguageChanged
                        value: VisualStyle.Bright
                    }

                    Option {
                        text: qsTr("Dark") + Retranslate.onLocaleOrLanguageChanged
                        value: VisualStyle.Dark
                    }
                    onSelectedValueChanged: {
                        _app.setTheme(themeDropDown.selectedValue === VisualStyle.Bright ? "bright" : "dark")
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Left
                    multiline: false
                    visible: Application.themeSupport.theme.colorTheme.style != themeDropDown.selectedValue
                    text: qsTr("Restart the application\nto apply theme") + Retranslate.onLocaleOrLanguageChanged
                    textStyle.base: SystemDefaults.TextStyles.SubtitleText
                }
            }
            Header {
                title: qsTr("Text Size")+ Retranslate.onLocaleOrLanguageChanged
                topMargin: 50.0
            }
            Container {
                leftPadding: 20.0
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    multiline: true
                    text: qsTr("You can change the text size via System Settings / Display, this app follows the system-wide text size settings.")+ Retranslate.onLocaleOrLanguageChanged

                }

            }
            Header {
                title: qsTr("Cache Management")+ Retranslate.onLocaleOrLanguageChanged
                topMargin: 50.0
            }

            Container {
                leftPadding: 10.0
                rightPadding: 10.0
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                Label {
                    multiline: true
                    text: qsTr("This app automaticlly saves all pictures into cache to optimize the internet usage, but you can clear these caches here.")+ Retranslate.onLocaleOrLanguageChanged

                }
                Container {
                  layout: DockLayout {
                      
                  }

                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    Label {
                        id: cacheSize
                        property int byteSize: _app.cacheSize()

                        text: qsTr("Cache size: ") + bytesToSize(byteSize)+ Retranslate.onLocaleOrLanguageChanged
                        horizontalAlignment: HorizontalAlignment.Left
                        textStyle.base: SystemDefaults.TextStyles.BodyText
                        textStyle.fontWeight: FontWeight.W100

                        verticalAlignment: VerticalAlignment.Center
                        function bytesToSize(bytes) {
                            if (isNaN(bytes)) {
                                return;
                            }
                            var units = [ ' B', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB' ];
                            var amountOf2s = Math.floor(Math.log(+ bytes) / Math.log(2));
                            if (amountOf2s < 1) {
                                amountOf2s = 0;
                            }
                            var i = Math.floor(amountOf2s / 10);
                            bytes = + bytes / Math.pow(2, 10 * i);

                            // Rounds to 3 decimals places.
                            if (bytes.toString().length > bytes.toFixed(3).toString().length) {
                                bytes = bytes.toFixed(3);
                            }
                            return bytes + units[i];
                        }
                    }
                    Button {
                        id: cacheButton

                        horizontalAlignment: HorizontalAlignment.Right
                        text: qsTr("Clear Cache")+ Retranslate.onLocaleOrLanguageChanged
                        onClicked: {
                            _app.clearCache()
                            cacheSize.byteSize = _app.cacheSize()
                            cacheSize.setText(qsTr("Cache size: ") + Retranslate.onLocaleOrLanguageChanged+ cacheSize.bytesToSize(cacheSize.byteSize))
                        }
                        verticalAlignment: VerticalAlignment.Center
                    }

                }
            }
        }

    }
    onCreationCompleted: {
        var theme = _app.getTheme(Application.themeSupport.theme.colorTheme.style === VisualStyle.Bright ? "bright" : "dark");
        themeDropDown.setSelectedIndex("bright" == theme ? 0 : 1);
    }
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll

}
