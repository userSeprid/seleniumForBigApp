Ext.define('App.view.common.PPKViewGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ppk-view-grid',

    requires: [],

    title: 'ППК',
    padding: '10 10 10 10',

    columns: {
        defaults: {
            flex: 1
        },

        items: [{
            text: 'Номер',
            dataIndex: 'ppkNumber',
            flex: 1
        }, {
            xtype: 'datecolumn',
            text: 'Дата',
            dataIndex: 'since',
            format: 'd-m-Y',
            flex: 1
        }, {
            text: 'Відповідальність',
            dataIndex: 'maxRefund',
            flex: 1
        }, {
            text: 'Адреса',
            dataIndex: 'address'
        }, {
            text: 'Абонплата',
            dataIndex: 'payment',
            flex: 1
        }, {
            text: 'Менеджер',
            dataIndex: 'manager',
            flex: 1
        }, {
            text: 'Документи',
            xtype: 'checkcolumn',
            dataIndex: 'documentsCompleted',
            flex: 1
        }, {
            text: 'Баланс',
            dataIndex: 'saldo',
            flex: 1
        }, {
            text: 'Стан',
            dataIndex: 'state',
            flex: 1
        }]
    },

});