import bb.cascades 1.0

Container {
    property variant callbacks

    function set(key, value) {
        var data = {
            action: "SAVE",
            key: key,
            value: value
        };
        sto.postMessage(JSON.stringify(data));
    }
    function get(key, callback) {
        var cid = Qt.md5(new Date().getTime() + Math.random() * 5);
        var data = {
            action: "GET",
            key: key,
            cid: cid
        };
        callbacks.cid = callback;
        sto.postMessage(JSON.stringify(data));

    }

    WebView {
        visible: false
        id: sto
        html: "<!DOCTYPE html><html lang=\"en\"><head><title>Storage</title></head><body><script>window.onload = function(){ if (navigator.cascades){ navigator.cascades.onmessage = function(message){var type=message.action;if (type==\"SAVE\"){LocalStorage.setItem(message.key,message.value)}else if (type == \"GET\"){var key=message.key;var cid=message.cid;var value=LocalStorage.getItem(key);if (!value) value=\"\";navigator.cascades.postMessage({cid:cid,data:value});} } } }</script></body></html>"
        onMessageReceived: {
            var result = message.data;
            result = JSON.parse(result)
            var cid = result.cid;
            var data = result.data;
            if (callbacks[cid] instanceof Function) {
                callbacks[cid](data);
                callbacks[cid] = null;
            }
        }
    }

}
