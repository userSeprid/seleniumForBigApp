Ext.define('App.view.dictionary.editor.DictionaryEditorView', {
    extend: 'Ext.form.Panel',
    alias: 'widget.dictionary-editor',

    requires: [
        'App.view.dictionary.editor.EditorGrid',
        'App.view.dictionary.editor.EditorPPKSubtypeGrid'
    ],

    viewModel: 'dictionary-editor',

    // scrollable: 'vertical',

    items: [
        {
            xtype: 'container',
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'dictionary-grid-pkk-subtype-editor',
                    title: 'Редагування словника "Підтип ППК"',
                    bind: {
                        store: '{ppkSubtype}'
                    }
                }, {
                    xtype: 'dictionary-grid-editor',
                    title: 'Редагування словника "Прийшов-Уйшов"',
                    bind: {
                        store: '{clientFromTo}'
                    }
                }, {
                    xtype: 'dictionary-grid-editor',
                    title: 'Редагування словника "Типи нагадувачів"',
                    bind: {
                        store: '{reminderTypes}'
                    }
                }]
        },
    ],
})
;
