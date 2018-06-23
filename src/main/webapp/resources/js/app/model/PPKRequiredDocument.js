Ext.define('App.model.PPKRequiredDocument', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'ppkId', type: 'int'},
        {name: 'title', type: 'string'},
        {name: 'validTill', type: 'date'},
        {name: 'notes', type: 'string'},
        {name: 'statusId', type: 'number', mapping: 'status.id'},
        {name: 'statusTitle', type: 'string', mapping: 'status.title'},
    ],

    proxy: {
        type: 'rest',
        url: '/api/ppkRequiresDocuments/item',
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