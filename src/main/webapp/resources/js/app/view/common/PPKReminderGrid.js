Ext.define('App.view.common.PPKReminderGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.ppk-reminder-grid',

    padding: '10 10 10 10',
    height: 200,

    title: 'Нагадування',
    columns: {
        defaults: {
            flex: 2
        },
        items: [/*{
            text: '№',
            dataIndex: 'id',
        },*/ {
            text: 'Тип',
            dataIndex: 'typeId',
            xtype: 'templatecolumn',
            tpl: '{typeTitle}',
            editor: {
                xtype: 'combo',
                displayField: 'title',
                valueField: 'id',
                editable: false,
                forceSelection: true,
                mode: 'local',
                triggerAction: 'all',
                bind: {
                    store: '{reminderTypes}'
                }
            }
        }, {
            text: 'Дата',
            xtype: 'datecolumn',
            format: 'd-m-Y',
            dataIndex: 'actionDate',
            editor: {
                xtype: 'datefield',
                dateFormat: 'Y-m-d',
                format: 'd-m-Y',
                minValue: new Date(),
            }
        }, {
            text: 'Опис',
            dataIndex: 'description',
            editor: 'textfield',
        }]
    },

    listeners: {
        edit: function (editor, e) {
            var self = this;
            e.record.save({
                callback: function (records, operation, success) {
                    self.getStore().reload();
                }
            });
        }
    },

    selModel: 'rowmodel',
    plugins: {
        ptype: 'rowediting',
        clicksToEdit: 2,
    },

    dockedItems: [{
        xtype: 'toolbar',
        dock: 'bottom',
        items: [{
            xtype: 'tbfill'
        }, {
            xtype: 'button',
            text: 'Створити нагадування',
            handler: function () {
                var grid = this.up().up();
                var store = grid.getStore();
                var model = store.model.create({ppkId: grid.getStore().ppkId});
                store.add(model);
                grid.editingPlugin.startEdit(model, 0);

            },
        }]
    }],

});
