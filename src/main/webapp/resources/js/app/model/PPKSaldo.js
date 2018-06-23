Ext.define('App.model.PPKSaldo', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'ppkNumber', type: 'string'},
        {name: 'minDate', type: 'string', mapping: 'dates.minDate'},
        {name: 'maxDate', type: 'string', mapping: 'dates.maxDate'},
        {name: 'debit', type: 'int'},
        {name: 'credit', type: 'int'},
    ],

    proxy: {
        type: 'ajax',
        url: '/api/saldo/findSaldoByPPK',
        reader: {
            type: 'json',
            rootProperty: 'item',
        }
    }
});