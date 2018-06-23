Ext.define('App.view.common.PPKPersonGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ppk-person-grid',

    title: 'Контакти',
    padding: '10 10 10 10',
    columns: {
        defaults: {
            flex: 1
        },
        items: [{
            text: 'ПIБ',
            dataIndex: 'name',
            editor: 'textfield'
        }, {
            text: 'Тип контакту',
            dataIndex: 'type',
        }, {
            text: 'Телефон',
            dataIndex: 'phone',
            editor: 'textfield',
            renderer: function (value) {
                return value.replace(/^(\d{3})(\d{3})(\d{2})(\d{2})$/, '($1) $2-$3-$4');
            }
        }, {
            text: 'Email',
            dataIndex: 'email',
            editor: 'textfield'
        }, {
            text: 'Fax',
            dataIndex: 'fax',
            editor: 'textfield'
        }, {
            text: 'Skype',
            dataIndex: 'skype',
            editor: 'textfield'
        }, {
            text: 'Власник',
            xtype: 'checkcolumn',
            dataIndex: 'owner',
        }, {
            text: 'Платник',
            xtype: 'checkcolumn',
            dataIndex: 'payer',
        }, {
            text: 'Тривога',
            xtype: 'checkcolumn',
            dataIndex: 'alarm',
        }, {
            xtype: 'checkcolumn',
            header: 'Домовлявся',
            dataIndex: 'advisor',
            enabled: false,
        }, {
            text: 'Примiтки',
            dataIndex: 'note',
            editor: 'textfield'
        },
        ]
    },

    // selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting',
        clicksToEdit: 1,
    },

    bbar: ['->', {
        text: 'Додати контакт',
        handler: 'onAddPPKPersonClick'
        // add contact search
    }]
});