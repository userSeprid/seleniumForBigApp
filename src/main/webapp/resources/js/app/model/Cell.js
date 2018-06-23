Ext.define('App.model.Cell', {
    extend: 'Ext.data.Model',

    fields: [
        {name: 'cellNumber', type: 'number'},
    ],

    idProperty: 'cellNumber'

});