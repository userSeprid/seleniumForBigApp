Ext.define('Ext.ux.GMapPanel', {
    extend: 'Ext.panel.Panel',

    alias: 'widget.gmappanel',

    requires: ['Ext.window.MessageBox'],

    initComponent: function () {
        Ext.applyIf(this, {
            plain: true,
            gmapType: 'map',
            border: false
        });

        this.callParent();
    },

    afterFirstLayout: function () {
        var center = this.center;
        this.callParent();

        if (center) {
            this.createMap(center);
        } else {
            Ext.Error.raise('center is required');
        }

    },

    createMap: function (center) {
        var options = Ext.apply({}, this.mapOptions);

        options = Ext.applyIf(options, {
            zoom: 9,
            center: center,
            mapTypeId: google.maps.MapTypeId.roadmap
        });
        this.gmap = new google.maps.Map(this.body.dom, options);

        Ext.each(this.markers, this.addMarker, this);
        this.fireEvent('mapready', this, this.gmap);
    },

    addMarker: function (marker) {
        marker = Ext.apply({
            map: this.gmap
        }, marker);

        if (!marker.position) {
            marker.position = new google.maps.LatLng(marker.lat, marker.lng);
        }

        var o = new google.maps.Marker(marker);
        Ext.Object.each(marker.listeners, function (name, fn) {
            google.maps.event.addListener(o, name, fn);
        });
        return o;
    },

    afterComponentLayout: function (w, h) {
        this.callParent(arguments);
        this.redraw();
    },

    redraw: function () {
        var map = this.gmap;
        if (map) {
            google.maps.event.trigger(map, 'resize');
        }
    }

});