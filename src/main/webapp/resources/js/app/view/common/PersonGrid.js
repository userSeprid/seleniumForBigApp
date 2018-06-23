Ext.define('App.view.common.PersonGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.person-grid',

    padding: '10 10 10 10',

    //scrollable: true,
    height: 200,

    columns: {
        defaults: {
            flex: 1
        },
        items: [{
            text: 'ПIБ',
            dataIndex: 'name',
            editor: 'textfield'
        }, {
            text: 'Тип',
            dataIndex: 'typeId',
            tpl: '{typeTitle}',
            xtype: 'templatecolumn',
            editor: {
                displayField: 'title',
                valueField: 'id',
                xtype: 'combobox',
                bind: {
                    store: '{personTypes}'
                }
            },

        },]
    },

    selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting',
        clicksToEdit: 2,
    },
});