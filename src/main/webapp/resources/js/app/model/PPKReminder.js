Ext.define('App.model.PPKReminder', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [

        {name: 'id', type: 'int'},
        {name: 'ppkId', type: 'int'},
        {name: 'actionDate', type: 'date'},
        {name: 'typeTitle', type: 'string', mapping: 'type.title'},
        {name: 'typeId', type: 'int', mapping: 'type.id'},
        {name: 'description', type: 'string'},

    ],

    proxy: {
        type: 'ajax',
        url: '/api/ppkReminder/item',
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