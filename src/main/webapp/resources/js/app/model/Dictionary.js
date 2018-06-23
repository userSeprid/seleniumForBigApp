Ext.define('App.model.Dictionary', {
    extend: 'Ext.data.Model',

    fields: [
        {name: 'id', type: 'number'},
        {name: 'parentId', type: 'number'},
        {name: 'code', type: 'string', allowNull: true},
        {name: 'title', type: 'string'}
    ],

    idProperty: 'id'

});