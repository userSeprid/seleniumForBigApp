Ext.define('App.view.dictionary.editor.DictionaryEditorViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.dictionary-editor',

    requires: [
        'App.model.DictionaryEditingItem',
    ],

    stores: {
        ppkSubtype: {
            model: 'App.model.DictionaryEditingItem',
            autoLoad: true,
            parentId: 105,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentOfParentsId',
                extraParams: {
                    parentId: 4
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        clientFromTo: {
            model: 'App.model.DictionaryEditingItem',
            autoLoad: true,
            parentId: 120,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/items',
                extraParams: {
                    parentId: 120
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        reminderTypes: {
            model: 'App.model.DictionaryEditingItem',
            autoLoad: true,
            parentId: 123,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/items',
                extraParams: {
                    parentId: 123
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        ppkTypes: {
            model: 'App.model.DictionaryEditingItem',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/items',
                extraParams: {
                    parentId: 4
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },
    }
});
