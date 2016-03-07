/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.0
import bb.system 1.0
import "ajax.js" as Ajax
NavigationPane {
    id: navpane
    property string today: "https://moment.douban.com/api/stream/current"
    property alias displayingday: picker.value
    property string backindays: "https://moment.douban.com/api/stream/date/"
    property variant todayinDate
    property variant earlist
    property variant latest
    property variant startdate: "2014-05-12"
    function loadData(day) {
        if (Ajax.request) Ajax.request.abort();

        content.removeAll();
        var dispday = backindays + day;
        Ajax.getTEXT(dispday, function(data) {
                if (data) {
                    data = JSON.parse(data);
                    if (data.total == 0) {
                        content.add(emp.createObject())
                    } else {

                        for (var i = 0; i < data.total; i ++) {
                            var c = clise.createObject();
                            c.column = data.posts[i].column;
                            c.title = data.posts[i].title;
                            c.intro = data.posts[i].abstract;
                            if (data.posts[i].thumbs && data.posts[i].thumbs.length > 0) c.picurl = data.posts[i].thumbs[0].large.url;
                            c.weburl = data.posts[i].url ? data.posts[i].url : data.posts[i].short_url;
                            if (! c.weburl) {
                                c.weburl = data.posts[i].original_url;
                            }
                            if (data.posts[i].original_url) {
                                c.originurl = data.posts[i].original_url;
                            }

                            c.shorturl = data.posts[i].short_url;
                            if (data.posts[i].author) c.author = {
                                uid: data.posts[i].author.uid,
                                url: data.posts[i].author.url,
                                avatar: data.posts[i].author.large_avatar,
                                name: data.posts[i].author.name
                            }
                            c.likes = data.posts[i].like_count;
                            c.comments = data.posts[i].comments_count;
                            c.style = data.posts[i].display_style;
                            //                            c.update();
                            content.add(c);
                        }
                    }
                } else {
                    toast.show()
                }
            })
    }
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                navpane.push(aboutpage.createObject());
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                navpane.push(settingspage.createObject());
            }
        }
        actions: [
            ActionItem {
                imageSource: "asset:///icon/ic_open.png"
                title: qsTr("Rate App") + Retranslate.onLocaleOrLanguageChanged
                onTriggered: {
                    invokeReview.trigger("bb.action.OPEN")
                }
            }
        ]
    }
    Page {
        titleBar: TitleBar {
            // Localized text with the dynamic translation and locale updates support
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties {
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    Label {
                        text: Qt.formatDate(picker.value, "yyyy-MM-dd")
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                    }
                }
                expandableArea {
                    content: DateTimePicker {
                        title: qsTr("Date") + Retranslate.onLocaleOrLanguageChanged
                        id: picker
                        //                        value: displayingday
                        onValueChanged: {
                            //displayingday = new Date(picker.value);
                            loadData(Qt.formatDate(picker.value, "yyyy-MM-dd"))
                        }
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        minimum: earlist
                        maximum: latest

                    }
                    expanded: false
                    toggleArea: TitleBarExpandableAreaToggleArea.EntireTitleBar
                }
            }
            appearance: TitleBarAppearance.Plain
            scrollBehavior: TitleBarScrollBehavior.NonSticky
        }
        actionBarVisibility: ChromeVisibility.Overlay
        actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
        ScrollView {
            topMargin: 20.0
            leftMargin: 20.0
            rightMargin: 20.0
            bottomMargin: 20.0
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            scrollRole: ScrollRole.Main
            Container {
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                ProgressIndicator {
                    id: pind
                    toValue: 4.0
                    visible: false
                    horizontalAlignment: HorizontalAlignment.Fill
                }

                Container {
                    id: content
                    horizontalAlignment: HorizontalAlignment.Fill
                    implicitLayoutAnimationsEnabled: false
                }

                ActivityIndicator {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    visible: pind.value < 4
                    running: true
                    preferredWidth: 100.0
                    preferredHeight: 100.0
                    id: act
                    topMargin: 200.0

                }

            }

        }
        actions: [
            ActionItem {
                title: qsTr("prev") + Retranslate.onLocaleOrLanguageChanged

                onTriggered: {
                    console.log(displayingday);
                    displayingday = new Date(displayingday.setDate(displayingday.getDate() - 1));
                }
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///icon/ic_previous.png"
                enabled: Qt.formatDate(displayingday, "yyyy-MM-dd") > startdate
            },
            ActionItem {
                title: qsTr("next") + Retranslate.onLocaleOrLanguageChanged
                onTriggered: {
                    console.log(displayingday + "," + todayinDate);
                    displayingday = new Date(displayingday.setDate(displayingday.getDate() + 1));
                }
                enabled: Qt.formatDate(displayingday, "yyyy-MM-dd") < Qt.formatDate(todayinDate, "yyyy-MM-dd")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///icon/ic_next.png"
            }
        ]
    }

    onPopTransitionEnded: {
        page.destroy();
    }
    onCreationCompleted: {
        var a = new Date();
        latest = todayinDate = displayingday = a;
        latest.setHours(23);
        latest.setMinutes(59);
        latest.setSeconds(59);
        var b = new Date();
        b.setDate(12);
        b.setMonth(4);
        b.setYear(2014);
        b.setHours(0);
        b.setMinutes(0);
        b.setSeconds(0);
        earlist = b;
        console.log("earlist: " + earlist);
        loadData(Qt.formatDate(displayingday, "yyyy-MM-dd"))
    }

    attachedObjects: [
        // Definition of the second Page, used to dynamically create the Page above.
        ComponentDefinition {
            id: clise
            source: "Clist.qml"
        },
        ComponentDefinition {
            id: reader
            source: "reader.qml"
        },
        ComponentDefinition {
            id: aboutpage
            source: "about.qml"
        },
        ComponentDefinition {
            id: settingspage
            source: "settings.qml"
        },
        SystemToast {
            id: toast
            body: qsTr("Network Error") + Retranslate.onLocaleOrLanguageChanged
            modality: SystemUiModality.Global
            position: SystemUiPosition.MiddleCenter
        },
        ComponentDefinition {
            id: emp
            Label {
                text: qsTr("No content today") + Retranslate.onLocaleOrLanguageChanged
            }
        },
        Invocation {
            id: invokeReview
            query {
                invokeTargetId: "sys.appworld"
                invokeActionId: "bb.action.OPEN"
                uri: "appworld://content/59888363"
            }
        }
    ]
}
