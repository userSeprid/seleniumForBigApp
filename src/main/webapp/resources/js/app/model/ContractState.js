Ext.define('App.model.ContractState', {

    extend: 'Ext.data.Model',

    idProperty: 'id',
    identifier: 'negative',

    fields: [
        {name: 'id', type: 'int'},
        {name: 'contractId', type: 'int'},
        {name: 'contractNumber', type: 'string'},
        {name: 'startDate', type: 'date'},
        {name: 'endDate', type: 'date'},
        {name: 'stateId', type: 'int', mapping: 'state.id'},
        {name: 'state', type: 'string', mapping: 'state.title'},
        {name: 'payment', type: 'int'},
        {name: 'refund', type: 'int'},
        {name: 'socialProject', type: 'boolean'},
        {name: 'smsGuardSwitch', type: 'boolean'},
        {name: 'smsAlarm', type: 'boolean'},
    ],

    proxy: {
        type: 'rest',
        url: 'api/contractState/item',
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