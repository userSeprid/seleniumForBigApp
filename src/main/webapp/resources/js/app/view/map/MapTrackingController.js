var markers = [];

var task;

Ext.define('App.view.map.MapTrackingController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.map-tracking-form',

    loadRelocationData: function (callback) {
        Ext.Ajax.request({
            method: 'GET',
            headers: {'Content-Type': 'application/json'},
            url: '/api/relocation/items',
            success: function (res) {
                callback(Ext.JSON.decode(res.responseText));
            },
            failure: function (err) {
                debugger;
            }
        });
    },

    onMovementStart: function () {
        var self = this;
        task = {
            run: function () {
                self.loadRelocationData(function (resp) {
                        var gmap = self.getView().lookup('GMap');
                    Ext.Array.each(resp.items, function (location) {
                            var marker = markers.find(function (m) {
                                return m.androidAccountId === location.androidAccountId;
                            });
                            if (marker) {
                                // marker already exists
                                marker.o.setPosition(new google.maps.LatLng(location.lat, location.lng))
                            } else {
                                debugger;
                                markers.push({
                                    androidAccountId: location.androidAccountId,
                                    o: gmap.addMarker(location)
                                });
                            }
                        });


                        Ext.Array.each(markers, function (marker, index) {
                            marker.lat = marker.lat + Math.random() / 10000 * (index + 1);
                            marker.lng = marker.lng + Math.random() / 10000 * (index + 1);
                            ;
                        });
                    }
                );
            },

            interval: 1000
        };

        Ext.TaskManager.start(task);
    },

    onMovementStop: function () {
        Ext.Array.each(markers, function (marker) {
            marker.o.setMap(null);
        });

        Ext.TaskManager.stop(task);
    }


});