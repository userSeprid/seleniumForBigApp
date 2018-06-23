Ext.define('App.view.common.ContractGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.contract-grid',

    requires: [],

    title: 'Договори',
    padding: '10 10 10 10',

    selModel: {
        selType: 'rowmodel'
    },

    columns: {
        defaults: {
            flex: 1
        },

        items: [
            {
                flex: 1,
                text: 'Договiр №',
                dataIndex: 'contractNumber'
            },
            {
                text: 'Період охорони',
                flex: 2,
                columns: [
                    {
                        flex: 1,
                        text: 'З',
                        dataIndex: 'startDate',
                        xtype: 'datecolumn',
                        format: 'd-m-Y',
                        editor: {
                            xtype: 'datefield',
                            format: 'd-m-Y',
                            /*listeners: {
                                change: function (field, newVal, oldVal) {
                                    debugger;
                                    alert('beforeshow' + field);
                                }
                            }*/
                        }
                    },
                    {
                        flex: 1,
                        text: 'По',
                        dataIndex: 'endDate',
                        xtype: 'datecolumn',
                        format: 'd-m-Y',
                        editor: {
                            xtype: 'datefield',
                            format: 'd-m-Y',
                        }
                    }
                ]
            },
            {
                flex: 1,
                header: 'Вiдповiдальнiсть',
                dataIndex: 'refund',
                editor: {
                    xtype: 'numberfield',
                    allowBlank: false
                },

            },
            {
                flex: 1,
                text: 'Абонплата',
                dataIndex: 'payment',
                editor: {
                    xtype: 'numberfield',
                    allowBlank: false
                }
            },
            {
                xtype: 'checkcolumn',
                text: 'Залоговий місяць',
                dataIndex: 'deposit',
                cls: 'multiline',
            },
            {
                xtype: 'checkcolumn',
                text: 'Соціальний проект',
                dataIndex: 'socialProject',
                cls: 'multiline',
            },
            {
                xtype: 'checkcolumn',
                text: 'СМС постановка/знаття',
                dataIndex: 'smsGuardSwitch',
                cls: 'multiline',
            },
            {
                xtype: 'checkcolumn',
                text: 'СМС тривога',
                dataIndex: 'smsAlarm',
                cls: 'multiline',
            },
            {
                flex: 1,
                text: 'Статус',
                dataIndex: 'state',
            }, {
                flex: 2,
                xtype: 'widgetcolumn',
                text: 'Договір',
                onWidgetAttach: function (col, widget, rec) {
                    Ext.Object.each(rec.get('stateReports'), function (key, value, myself) {
                        widget.items.get(0).menu.add({
                            text: value.title,
                            handler: function (cm, color) {
                                debugger;
                                var win = window.open('/reports/agreement/' + value.id, '_blank');
                                win.focus();
                            }
                        });
                    });
                },

                widget: {
                    xtype: 'panel',
                    border: false,
                    items: [{
                        xtype: 'button',
                        text: 'Створити',
                        menu: []
                    }]
                }
            }
        ]
    },

    listeners: {
        selectionchange: 'onChangeSelectedContract',
    },

    selModel: 'rowmodel',

    plugins: [
        {
            ptype: 'rowediting',
            clicksToEdit: 2,
            listeners: {
                beforeedit: 'beforeEditContract',
            }
        },
    ],

    bbar: ['->', {
        xtype: 'button',
        text: 'Додати новий контракт',
        reference: 'addNewContractBtn',
        id: 'addNewContractBtn',
        menu: [],
    }, {
        text: 'Додати новий період до контракту',
        handler: 'onAddPeriodToContractClick',
        reference: 'addPeriodToContractBtn',
        disabled: true
    },],

})
;