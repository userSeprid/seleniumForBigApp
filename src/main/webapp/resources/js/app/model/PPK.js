Ext.define('App.model.PPK', {

    extend: 'Ext.data.Model',

    requires: [
        'App.model.PPKPerson'
    ],

    idProperty: 'id',
    identifier: 'negative',

    fields: [

        {name: 'id', type: 'int'},
        {name: 'createDate', type: 'date'},
        {name: 'locationRegion', type: 'string', allowNull: true},
        {name: 'locationCity', type: 'string', allowNull: true},
        {name: 'locationStreet', type: 'string', allowNull: true},
        {name: 'locationHouse', type: 'int', allowNull: true, convert: null},
        {name: 'locationKorpus', type: 'int', allowNull: true, convert: null},
        {name: 'locationFloor', type: 'int', allowNull: true, convert: null},
        {name: 'locationApartments', type: 'int', allowNull: true, convert: null},
        {name: 'locationEntrance', type: 'int', allowNull: true, convert: null},
        {name: 'dashboardTypeId', type: 'number', allowNull: true, mapping: 'dashboardType.id'},
        {name: 'dashboardSubtypeId', type: 'number', allowNull: true, mapping: 'dashboardSubtype.id'},
        {name: 'dashboardNumber', type: 'int', allowNull: true, convert: null},
        {name: 'dashboardCell', type: 'string', allowNull: true, convert: null},
        {name: 'regionId', type: 'number', allowNull: true, mapping: 'region.id'},
        {name: 'companyId', type: 'number', allowNull: true, mapping: 'company.id'},
        {name: 'objectTypeId', type: 'number', allowNull: true, mapping: 'objectType.id'},
        {name: 'description', type: 'string', allowNull: true},
        {name: 'reactionTime', type: 'int', allowNull: true, convert: null},
        {name: 'increase', type: 'string', allowNull: true},
        {name: 'history', type: 'string', allowNull: true},
        {name: 'techHistory', type: 'string', allowNull: true},
        {name: 'managerId', type: 'number', allowNull: true, mapping: 'manager.id'},
        {name: 'managerCompanyId', type: 'number', allowNull: true, mapping: 'managerCompany.id'},
        {name: 'note', type: 'string', allowNull: true},
        {name: 'latitude', type: 'float', allowNull: true, convert: null},
        {name: 'longitude', type: 'float', allowNull: true, convert: null},
        {name: 'scheme', type: 'string', allowNull: true, mapping: 'files.scheme'},
        {name: 'map', type: 'string', allowNull: true, mapping: 'files.map'},
        {name: 'mapDetails', type: 'string', allowNull: true, mapping: 'files.mapDetails'},
        {name: 'balance', type: 'int'},
        {name: 'debit', type: 'int'},
        {name: 'credit', type: 'int'},
        {name: 'maxRefund', type: 'int'},
        {name: 'saldo', type: 'int'},
        {name: 'balanceDescription', type: 'string', allowNull: true},
        {name: 'documentsCompleted', type: 'boolean', allowNull: true},
        {name: 'simCard1', type: 'string', allowNull: true},
        {name: 'simCard2', type: 'string', allowNull: true},
        {name: 'cameFromId', type: 'number', mapping: 'cameFrom.id', allowNull: true},
        {name: 'payTillDay', type: 'int', convert: null, allowNull: true},
    ],

    hasMany: {
        model: 'App.model.PPKPerson',
        name: 'persons'
    },

    proxy: {
        type: 'ajax',
        url: '/api/ppk/item',
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