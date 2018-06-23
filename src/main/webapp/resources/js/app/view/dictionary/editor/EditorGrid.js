Ext.define('App.view.dictionary.editor.EditorGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.dictionary-grid-editor',

    padding: '10 10 10 10',
    height: 300,

    columns: {
        defaults: {
            flex: 2
        },
        items: [{
            text: '№',
            dataIndex: 'id',
        }, {
            text: 'Код',
            dataIndex: 'code',
            editor: 'textfield',
        }, {
            text: 'Название',
            dataIndex: 'title',
            editor: 'textfield',
        }]
    },

    listeners: {
        edit: function (editor, e) {
            e.record.save();
            this.getStore().reload();
        }
    },

    selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting',
        clicksToEdit: 2,
    },

    bbar: ['->',
        {
            xtype: 'button',
            text: 'Створити',
            handler: function () {
                var grid = this.up().up();
                var store = grid.getStore();
                var model = store.model.create({parentId: grid.getStore().parentId});
                store.add(model);
                grid.editingPlugin.startEdit(model, 0);

            },
            bind: {
                visible: '{record.id == -1}'
            }
        },
    ]
})
;
