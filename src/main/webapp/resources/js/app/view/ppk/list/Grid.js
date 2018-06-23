Ext.define('App.view.ppk.list.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ppk-grid',

    requires: [
        'App.view.ppk.list.GridViewModel',
        'App.view.ppk.list.GridViewController'
    ],

    viewModel: 'ppk-grid',
    controller: 'ppk-grid',
    padding: '10 10 10 10',

    dockedItems: [{
        xtype: 'toolbar',
        dock: 'top',
        displayInfo: true,
        items: [{
            text: 'Створити',
            handler: 'onCreateClick'
        }, {
            xtype: 'textfield',
            reference: 'filter',
            publishes: 'value',
            width: 250
        }]
    }],

    columns: {
        defaults: {
            flex: 2
        },
        items: [{
            text: 'Номер договору',
            dataIndex: 'ppkNumber',
            flex: 1
        }, {
            text: 'Адреса',
            dataIndex: 'address'
        }, {
            text: 'Абонплата',
            dataIndex: 'payment',
            flex: 1
        }, {
            xtype: 'datecolumn',
            text: 'Дата',
            dataIndex: 'since',
            format: 'd-m-Y',
            flex: 1
        }, {
            text: 'Менеджер',
            dataIndex: 'manager',
            flex: 1
        }]
    },

    bbar: {
        xtype: 'pagingtoolbar',
        displayInfo: true
    },

    bind: {
        store: '{ppks}'
    },

    listeners: {
        rowclick: 'onGridRowDbClick'
    }

});