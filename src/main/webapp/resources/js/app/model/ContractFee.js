Ext.define('App.model.ContractFee', {

    extend: 'Ext.data.Model',

    fields: [
        {name: 'ppkId', type: 'int'},
        {name: 'ppkNumber', type: 'string'},
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