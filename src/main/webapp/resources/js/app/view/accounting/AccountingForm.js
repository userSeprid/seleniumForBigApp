Ext.define('App.view.accounting.AccountingForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.accounting-form',

    requires: [
        'App.view.accounting.AccountingController',
        'App.view.accounting.AccountingViewModel',
        'App.view.accounting.PPKDebitGrid',
        'App.view.accounting.PPKCreditGrid',
        'App.view.accounting.PPKFeeGrid'
    ],

    viewModel: 'accounting-form',
    controller: 'accounting-form',

    tbar: [
        {
            xtype: 'tbtext',
            bind: {
                html: '<h4>{record.ppkNumber}</h4>'
            },
        },
        {
            xtype: 'tbseparator'
        },
        {
            xtype: 'tbtext',
            bind: {
                html: '<h4>Період з {record.minDate} по {record.maxDate}</h4>'
            },
        },
        {
            xtype: 'tbseparator'
        },
        {
            xtype: 'tbtext',
            bind: {
                html: '<h4>Початковий баланс: {record.zAmount}</h4>'
            },
        }, {
            xtype: 'tbtext',
            bind: {
                html: '<h4>Всього нараховано: {record.debit}</h4>'
            },
        }, {
            xtype: 'tbtext',
            bind: {
                html: '<h4>Всього сплачено: {record.credit}</h4>'
            }
        }, {
            xtype: 'tbtext',
            bind: {
                html: '<h4>Баланс: {record.credit + record.zAmount - record.debit}</h4>'
            }
        },
        {
            xtype: 'tbseparator'
        },
    ],

    items: [{
        xtype: 'container',
        scrollable: 'vertical',

        layout: {
            type: 'vbox',
            align: 'stretch'
        },
        items: [
            {
                xtype: 'container',
                layout: {
                    type: 'hbox',
                    align: 'stretch'
                },
                items: [
                    {
                        xtype: 'ppk-fee-grid',
                        reference: 'ppk-fee-grid',
                        title: 'Абонплата за місяцями та додтаткові оплати',
                        bind: {
                            store: '{ppkFees}'
                        },
                        flex: 1
                    },
                ]
            },
            {
                xtype: 'container',
                layout: {
                    type: 'hbox',
                    align: 'stretch'
                },
                items: [
                    {
                        xtype: 'ppk-debit-grid',
                        reference: 'ppk-debit-payment-grid',
                        title: 'Додаткові доплати',
                        bind: {
                            store: '{paymentsDebit}'
                        },
                        listeners: {
                            edit: 'onPaymentDebitEdited',
                        },
                        flex: 1,
                        bbar: [
                            {
                                xtype: 'button',
                                text: 'Створити доплату',
                                handler: 'onCreateDebitClick'
                            }
                        ]
                    },
                    {
                        flex: 1,
                        xtype: 'ppk-credit-grid',
                        reference: 'ppk-credit-payment-grid',
                        title: 'Проплати від клієнта',
                        bind: {
                            store: '{paymentsCredit}'
                        },
                        listeners: {
                            edit: 'onPaymentCreditEdited',
                        },
                        bbar: [
                            {
                                xtype: 'button',
                                text: 'Створити внесок від клієнта',
                                handler: 'onCreateCreditClick'
                            }
                        ]

                    },
                ]
            }

        ]
    }],
});