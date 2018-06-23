Ext.define('App.model.ContractStateReport', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'title', type: 'string'},
        {name: 'template', type: 'string'},
    ],
});