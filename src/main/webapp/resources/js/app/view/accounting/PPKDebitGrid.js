Ext.define('App.view.accounting.PPKDebitGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ppk-debit-grid',

    padding: '10 10 10 10',

    features: [{
        ftype: 'summary'
    }],

    columns: {
        defaults: {
            flex: 1
        },
        items: [{
            xtype: 'datecolumn',
            text: 'Дата створення',
            dataIndex: 'createDate',
            format: 'd-m-Y',
            editor: {
                xtype: 'datefield',
                format: 'd-m-Y',
            }
        },
            {
                text: 'Тип',
                dataIndex: 'typeId',
                tpl: '{typeCode}',
                xtype: 'templatecolumn',
                editor: {
                    displayField: 'title',
                    valueField: 'id',
                    xtype: 'combobox',
                    bind: {
                        store: '{paymentDebitTypes}'
                    }
                },
                summaryRenderer: function (value, summaryData, dataIndex) {
                    return 'Загальна сумма';
                }
            },
            {
                header: 'Сумма',
                dataIndex: 'amount',
                editor: {
                    xtype: 'numberfield',
                    allowBlank: false
                },
                summaryType: 'sum',
            }
        ]
    },

    selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting',
        clicksToEdit: 2,
    },
});