Ext.define('App.model.PPKListItem', {
    extend: 'Ext.data.Model',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'address', type: 'string'},
        {name: 'ppkNumber', type: 'string'},
        {name: 'client', type: 'string'},
        {name: 'manager', type: 'string', mapping: 'manager.title'},
        {name: 'payment', type: 'number'},
        {name: 'since', type: 'date'},
        {name: 'documentsCompleted', type: 'boolean'},
        {name: 'state', type: 'string', mapping: 'state.title'}
    ],

    idProperty: 'id'
});