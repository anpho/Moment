import bb.cascades 1.0

Container {
    property string pazid: "adq55snh-14zpz4ol-uvb7d"
    property string ua: "Mozilla/5.0 (BB10; Kbd) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.0.700 Mobile Safari/537.35+"
    property string ip
    property bool devip: false
    property string api: "1.7"
    property string adunit: "728x90"
    property string strict_adunit: "0"
    property string endpoint: "http://ads.adiquity.com/mapi"
    property string fmt:"html"

    WebView {
        id: adview
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
    }
    onCreationCompleted: {
        getIP();
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    function showAD(_ip) {
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    adview.html = request.responseText;
                    console.log(adview.html);
                }
            } else {

            }
        }
        request.open("POST", endpoint, true)
        request.setRequestHeader("X-ADQ-pazid", pazid);
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        var data = [ "pazid=" + pazid, "ua=" + ua, "ip=" + _ip, "devip=" + devip, "api=" + api, "adunit=" + adunit,
            "strict_adunit=" + strict_adunit,"fmt="+fmt ]
        request.send(data.join("&"));
    }
    function getIP() {
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    var plainIP = request.responseText;
                    plainIP = plainIP.substring(plainIP.search("{"), plainIP.length - 1);
                    ip = JSON.parse(plainIP).cip;
                    console.log(ip)
                    showAD(ip)
                } else {

                }
            }
        }
        request.open("GET", "http://pv.sohu.com/cityjson?ie=utf-8", true)
        request.send();
    }
}
