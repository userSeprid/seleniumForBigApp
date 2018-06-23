Ext.define('App.view.contract.create.ContractCreateForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.contract-create-form',

    requires: [
        'App.model.ContractState',
        'App.view.contract.create.ContractCreateController',
        'App.view.contract.create.ContractCreateViewModel'
    ],

    viewModel: 'contract-create-form',
    controller: 'contract-create-form',

    scrollable: true,
    layout: {
        type: 'vbox',
        align: 'stretch'
    },

    tbar: [{
        xtype: 'tbtext',
        bind: {
            text: '{contractNumber}'
        }
    },
    ],

    items: [
        // First field set
        {
            xtype: 'container',
            layout: {
                type: 'hbox',
                align: 'stretch'
            },
            defaults: {
                xtype: 'container',
                flex: 1,
                layout: {
                    type: 'vbox',
                    align: 'stretch'
                },
                padding: '10 15',
            },
            items: [
                {
                    //First column
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [
                        {
                            xtype: 'dictionary-combobox',
                            publishes: 'selection',
                            reference: 'contractType',
                            fieldLabel: 'Тип контракту',
                            allowBlank: false,
                            msgTarget: 'side',
                            bind: {
                                value: '{record.contractTypeId}',
                                store: '{contractTypes}'
                            }
                        },
                        {
                            xtype: 'dictionary-combobox',
                            fieldLabel: 'Статус контракту',
                            allowBlank: false,
                            msgTarget: 'side',
                            bind: {
                                value: '{record.statusId}',
                                store: '{contractStates}'
                            }
                        },


                        {
                            xtype: 'textarea',
                            fieldLabel: 'Реквізити',
                            grow: true,
                            allowBlank: false,
                            msgTarget: 'side',
                            bind: {
                                value: "{record.requisites}"
                            }
                        },

                    ]

                },
                {
                    // second column
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [
                        {
                            xtype: 'numberfield',
                            fieldLabel: 'Абонплата',
                            reference: 'dashboardNumber',
                            publishes: 'value',
                            minValue: 0,
                            allowBlank: false,
                            msgTarget: 'side',
                            bind: {
                                value: '{record.payment}'
                            }
                        },



                    ]

                },
                {  // second column
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [
                        {
                            xtype: 'numberfield',
                            fieldLabel: 'Відшкодування',
                            allowBlank: false,
                            msgTarget: 'side',
                            bind: {
                                value: "{record.responsibility}"
                            }
                        },


                        {
                            xtype: 'textarea',
                            fieldLabel: 'Опис',
                            grow: true,
                            allowBlank: false,
                            msgTarget: 'side',
                            bind: {
                                value: "{record.description}"
                            }
                        },

                    ]

                },
            ],

        }
    ],

    bbar: ['->', {
        xtype: 'button',
        text: 'Створити',
        handler: 'onCreateContractClick',
        bind: {
            visible: '{record.id < 0}'
        }
    },
        {
            xtype: 'button',
            text: 'Зберегти зміни',
            handler: 'onUpdateContractClick',
            bind: {
                visible: '{record.id > 0}'
            }
        },
    ]
})
;