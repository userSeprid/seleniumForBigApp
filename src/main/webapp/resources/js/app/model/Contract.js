Ext.define('App.model.Contract', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'ppkId', type: 'int'},
        {name: 'typeId', type: 'int'},
    ],

    proxy: {
        type: 'rest',
        url: 'api/contract/item',
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
});