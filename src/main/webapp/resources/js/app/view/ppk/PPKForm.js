Ext.define('App.view.ppk.PPKForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.ppk-form',

    requires: [
        'App.view.ppk.PPKViewController',
        'App.view.ppk.PPKViewModel',
        'App.view.common.PersonCard',
        'App.view.common.MapsPanel',
        'App.view.common.ppkPerson.AddPPKPersonDlg',
        'App.view.common.ppkPerson.AddPPKPersonViewModel',
        'App.model.PPKListItem',
        'App.view.common.PPKReminderGrid'
    ],

    viewModel: 'ppk-form',
    controller: 'ppk-form',

    scrollable: 'vertical',

    tbar: [{
        xtype: 'tbtext',
        bind: {
            html: '<h4>{ppkNumber}</h4>'
        }
    }, {
        xtype: 'tbseparator'
    }, {
        xtype: 'tbtext',
        bind: {
            html: '<h4>Створити</h4>',
            visible: '{record.id == -1}'
        }
    }, {
        xtype: 'tbtext',
        bind: {
            html: '<h4>Редагувати</h4>',
            visible: '{record.id > -1}'
        }
    }, {
        xtype: 'tbseparator'
    }, /* {
        xtype: 'tbfill'
    },*/ {
        xtype: 'label',
        text: 'Наявність документів',
    },
        {
            xtype: 'label',
            html: '<img src="resources/checked-checkbox-icon.png">',
            bind: {
                visible: '{record.documentsCompleted}'
            },
        },
        {
            xtype: 'label',
            html: '<img src="resources/unchecked-checkbox-icon.png">',
            bind: {
                visible: '{!record.documentsCompleted}'
            },
        }, {
            xtype: 'tbseparator'
        }, {
            xtype: 'label',
            bind: {
                text: '{record.state.title}',
            }
        }, {
            text: 'Видалити',
            handler: 'onPPKDisableClick',
            bind: {
                visible: '{record.state.id == 101}'
            }
        }, {
            text: 'Розрахунки',
            handler: 'onShowAccountingForm',
        }, {
            xtype: 'label',
            bind: {
                text: 'Баланс: {record.saldo}',
            }
        }
    ],

    items: [{
        xtype: 'container',
        items: [{
            xtype: 'person-card',
        }, {
            xtype: 'ppk-reminder-grid',
            bind: {
                store: '{ppkReminders}',
            }
        }, {
            xtype: 'maps-panel',
        },
        ]
    }],

    listeners: {
        // render: 'onAddPPKPersonClick',
    },

    bbar: ['->',
        {
            id: 'next-dictionary-id',
            xtype: 'button',
            text: 'Далі',
            handler: 'onCreatePPKClick',
            bind: {
                visible: '{record.id == -1}'
            }
        },
        {
            xtype: 'button',
            id: 'save-changes-dictionary-id',
            text: 'Зберегти',
            handler: 'onUpdatePPKClick',
            bind: {
                visible: '{record.id != -1}'
            }
        },
    ]
});