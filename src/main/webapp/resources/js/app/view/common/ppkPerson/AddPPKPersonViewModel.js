var pageSize = 20;

Ext.define('App.view.common.ppkPerson.AddPPKPersonViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.add-ppk-person-dlg',

    stores: {
        persons: {
            remoteSort: true,
            sorters: [{
                property: 'id',
                direction: 'asc'
            }],

            remoteFilter: true,
            filters: [{
                property: 'search',
                value: '{filter.value}',
                disableOnEmpty: true
            }],

            model: 'App.model.Person',
            autoLoad: {start: 0, limit: pageSize},
            pageSize: pageSize,
            proxy: {
                type: 'ajax',
                url: '/api/person/items',
                reader: {
                    type: 'json',
                    totalProperty: 'total',
                    rootProperty: 'items'
                }
            }
        },

        personTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 94
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },
    },

    formulas: {

        selectedPerson: {

            bind: {
                person: '{persons.selection}',
            },

            get: function (values) {
                if (this.getView().lookup('persons').getSelectionModel().getSelection().length > 0) {
                    return this.getView().lookup('persons').getSelectionModel().getSelection()[0]
                } else {
                    return {type: {id: -1}};
                }
            }
        },
    }
})