Ext.define('App.model.PPKPayment', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'ppkId', type: 'int'},
        {name: 'typeCode', mapping: 'type.code', type: 'string'},
        {name: 'typeId', mapping: 'type.id', type: 'int'},
        {name: 'createDate', type: 'date'},
        {name: 'amount', type: 'int'},
        {name: 'comments', type: 'string'},
    ],

    proxy: {
        type: 'rest',
        url: '/api/payment/item',
        appendId: false,
        reader: {
            type: 'json',
            rootProperty: 'item'
        },
        writer: {
            type: 'json',
            writeAllFields: true
        }
    }
})