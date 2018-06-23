Ext.define('App.view.dictionary.editor.EditorPPKSubtypeGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.dictionary-grid-pkk-subtype-editor',

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
            text: 'Типу пульту',
            dataIndex: 'parentId',
            xtype: 'templatecolumn',
            tpl: '{parentTitle}',
            editor: {
                xtype: 'combo',
                displayField: 'title',
                valueField: 'id',
                editable: false,
                forceSelection: true,
                mode: 'local',
                triggerAction: 'all',
                bind: {
                    store: '{ppkTypes}'
                }
            }
        },
            {
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
