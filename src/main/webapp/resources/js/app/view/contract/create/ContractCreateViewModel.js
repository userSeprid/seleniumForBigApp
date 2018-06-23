Ext.define('App.view.contract.create.ContractCreateViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.contract-create-form',

    requires: [
        'App.model.Person',
        'App.model.Dictionary',
    ],

    formulas: {
        contractNumber: {
            bind: {
                contractType: '{contractType.selection.code}',
            },
            get: function (values) {
                var numberParts = this.get('record').numberParts;
                return Ext.String.format(values['contractType'],
                    numberParts.company,
                    numberParts.region,
                    numberParts.dashboardType,
                    numberParts.dashboardNumber,
                    numberParts.dashboardCell
                );
            }
        },
    },

    stores: {
        contractTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 1
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
        },

        contractStates: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 6
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
        }
    }

});