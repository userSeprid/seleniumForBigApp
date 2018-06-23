Ext.define('App.view.common.requiredDocuments.PPKRequiredDocumentsGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.required-documents-grid',

    requires: [
        'App.view.common.requiredDocuments.PPKRequiredDocumentsController',
        'App.view.common.requiredDocuments.PPKRequiredDocumentsViewModel',
    ],

    viewModel: 'required-documents-grid',
    controller: 'required-documents-grid',

    padding: '10 10 10 10',

    dockedItems: [{
        xtype: 'toolbar',
        dock: 'top',
        displayInfo: true,
        items: [{
            text: 'Створити',
            handler: 'onCreateClick'
        }, {
            text: 'Видалити',
            reference: 'deleteBtn',
            handler: 'onDeleteClick',
            disabled: true
        }]
    }],

    columns: {
        defaults: {
            flex: 1
        },
        items: [{
            text: 'Назва документу',
            dataIndex: 'title',
            editor: 'textfield'
        }, {
            text: 'Статус',
            dataIndex: 'statusId',
            tpl: '{statusTitle}',
            xtype: 'templatecolumn',
            editor: {
                displayField: 'title',
                valueField: 'id',
                xtype: 'combobox',
                bind: {
                    store: '{requiredDocumentStatus}'
                }
            }
        }, {
            xtype: 'datecolumn',
            text: 'Дійсно до',
            dataIndex: 'validTill',
            format: 'd-m-Y',
            editor: {
                xtype: 'datefield',
                format: 'd-m-Y',
            }
        }, {
            text: 'Опис',
            dataIndex: 'notes',
            editor: 'textfield'
        },]
    },

    selModel: 'rowmodel',

    plugins: {
        ptype: 'rowediting',
        clicksToEdit: 2,
    },

    listeners: {
        edit: 'onRequiredDocumentEdited',
        selectionchange: 'onSelectionChange'
    }
});