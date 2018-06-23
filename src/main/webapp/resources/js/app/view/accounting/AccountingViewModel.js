Ext.define('App.view.accounting.AccountingViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.accounting-form',


    requires: [
        'App.model.PPKPayment',
        'App.model.Dictionary',
    ],

    stores: {

        paymentsDebit: {
            model: 'App.model.PPKPayment',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/payment/debit/items',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        paymentsCredit: {
            model: 'App.model.PPKPayment',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/payment/credit/items',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        paymentDebitTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            filters: [{
                property: 'id',
                value: '104'
            }
            ],
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 88
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        paymentCreditTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            filters: [{
                property: 'id',
                value: '103'
            }],
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 88
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        contractNames: {
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/saldo/contractNames',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        ppkFees: {
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/saldo/ppkFees',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
            listeners: {
                beforeload: 'beforeLoadFees'
            }
        }
    }
});