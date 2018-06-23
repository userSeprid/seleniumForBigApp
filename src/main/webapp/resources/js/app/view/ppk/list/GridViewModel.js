var pageSize = 50;

Ext.define('App.view.ppk.list.GridViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.ppk-grid',

    requires: [
        'App.model.PPKListItem'
    ],

    stores: {
        ppks: {
            model: 'App.model.PPKListItem',
            autoLoad: {start: 0, limit: pageSize},
            pageSize: pageSize,
            remoteFilter: true,
            filters: [{
                property: 'search',
                value: '{filter.value}',
                disableOnEmpty: true
            }],
            proxy: {
                type: 'ajax',
                url: '/api/ppk/items',
                reader: {
                    type: 'json',
                    totalProperty: 'total',
                    rootProperty: 'items'
                }
            }
        }
    }

});