<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">

    var stores = [];
    var loadedStores = 0;
    var onLoadCallback;

    function initStores(functionOnLoad) {
        stores = [];
        onLoadCallback = functionOnLoad;
    }

    function registerStore(store) {
        stores.push(store);
        store.load({
            callback: function (r, options, success) {
                if (success === true) {
                    loadedStores = loadedStores + 1;
                    if (loadedStores == stores.length) {
                        onLoadCallback();
                    }
                }
            }
        });
    }
</script>