Ext.define('App.model.PPKPerson', {
    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'ppkId', type: 'int'},
        {name: 'personId', type: 'int'},
        {name: 'name', type: 'string'},
        {name: 'typeId', type: 'int'},
        {name: 'type', type: 'string'},
        {name: 'phone', type: 'string'},
        {name: 'email', type: 'string'},
        {name: 'fax', type: 'string'},
        {name: 'skype', type: 'string'},
        {name: 'note', type: 'string'},
        {name: 'owner', type: 'bool'},
        {name: 'payer', type: 'bool'},
        {name: 'alarm', type: 'bool'},
        {name: 'advisor', type: 'bool'},
    ],

    proxy: {
        type: 'rest',
        url: 'api/ppkperson/item',
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