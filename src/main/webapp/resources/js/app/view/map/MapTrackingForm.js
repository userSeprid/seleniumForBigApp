Ext.define('App.view.map.MapTrackingForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.map-tracking-form',

    requires: ['App.view.map.MapTrackingController'],

    /*
        viewModel: 'ppk-form',
    */

    controller: 'map-tracking-form',

    scrollable: 'vertical',

    tbar: [{
        text: 'Start movement',
        handler: 'onMovementStart',
    }, {
        xtype: 'tbseparator'
    }, {
        text: 'Stop movement',
        handler: 'onMovementStop',
    },
    ],
    padding: '10 15',

    items: [
        {
            xtype: 'gmappanel',
            reference: 'GMap',
            width: 750,
            height: 750,
            center: {
                lat: 50.444155,
                lng: 30.522530,
            },
        },
    ],
});