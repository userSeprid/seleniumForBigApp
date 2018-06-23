Ext.define('App.model.Person', {
    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'typeId', type: 'int', mapping: 'type.id'},
        {name: 'typeTitle', type: 'string', mapping: 'type.title'},
        {name: 'name', type: 'string'},
        {name: 'phone', type: 'string'},
        {name: 'email', type: 'string'},
        {name: 'fax', type: 'string'},
        {name: 'skype', type: 'string'},
        {name: 'note', type: 'string'},
        {name: 'inn', type: 'string'},
        {name: 'passportNumber', type: 'string'},
        {name: 'passportInstitute', type: 'string'},
        {name: 'registration', type: 'string'},
        {name: 'factAddress', type: 'string'},
        {name: 'edrpo', type: 'string'},
        {name: 'registrationDate', type: 'date'},
        {name: 'ipn', type: 'string'},
        {name: 'vat', type: 'string'},
        {name: 'bank', type: 'string'},
        {name: 'account', type: 'string'},
        {name: 'mfo', type: 'string'},
        {name: 'cto', type: 'string'},
    ],

    proxy: {
        type: 'rest',
        url: 'api/person/item',
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