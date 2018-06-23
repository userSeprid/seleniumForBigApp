Ext.define('App.view.accounting.PPKFeeGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ppk-fee-grid',

    padding: '10 10 10 10',

    features: [{
        ftype: 'summary'
    }],

    columns: {
        defaults: {
            flex: 1
        },
        items: [
            {
                header: 'Місяць',
                dataIndex: 'monthName',
                renderer: function renderHeader(value, p, record) {
                    return record.get('year') == -1 ? record.get('monthName') : record.get('monthName') + ' ' + record.get('year');
                },
                summaryType: 'sum',
                summaryRenderer: function (value, summaryData, dataIndex) {
                    return 'Загальна сумма';
                }
            },
        ]
    },
});