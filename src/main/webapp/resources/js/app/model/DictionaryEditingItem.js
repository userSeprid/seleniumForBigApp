Ext.define('App.model.DictionaryEditingItem', {
    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'number'},
        {name: 'parentId', type: 'int'},
        {name: 'code', type: 'string'},
        {name: 'title', type: 'string'},
        {name: 'parentTitle', type: 'string'},
    ],

    proxy: {
        type: 'rest',
        url: '/api/dictionary/item',
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