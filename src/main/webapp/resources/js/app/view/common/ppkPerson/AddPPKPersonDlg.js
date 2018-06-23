Ext.define('App.view.common.ppkPerson.AddPPKPersonDlg', {
    extend: 'Ext.window.Window',
    alias: 'widget.add-ppk-person-dlg',

    requires: [
        'Ext.window.Window',
        'App.view.common.ppkPerson.AddPPKPersonController',
        'App.view.common.ppkPerson.AddPPKPersonViewModel',
        'App.view.common.PersonGrid',
        'App.model.Person',
        'App.view.common.ppkPerson.FOPDetailsPanel',
        'App.view.common.ppkPerson.NaturalPersonDetailsPanel',
        'App.view.common.ppkPerson.JuralPersonDetailsPanel',
        'App.view.common.ppkPerson.PointOfContactPanel',
    ],

    viewModel: 'add-ppk-person-dlg',
    controller: 'add-ppk-person-dlg',

    closeAction: 'hide',

    title: 'Додати новий контакт до ППК',
    height: '80%',
    width: '70%',
    layout: 'fit',
    floating: true,

    dockedItems: [{
        xtype: 'toolbar',
        dock: 'top',
        displayInfo: true,
        items: [{
            text: 'Створити',
            handler: 'onCreatePersonClick'
        }, {
            xtype: 'textfield',
            reference: 'filter',
            publishes: 'value',
            width: 250
        }]
    }],

    items: [
        {
            xtype: 'form',
            reference: 'form',
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'panel',
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            xtype: 'person-grid',
                            reference: 'persons',
                            bind: {
                                store: '{persons}',
                            },
                            listeners: {
                                edit: 'onPersonEdited',
                            }
                        }, {
                            xtype: 'pagingtoolbar',
                            displayInfo: true,
                            bind: {
                                store: '{persons}',
                            },
                        },
                        {
                            xtype: 'fop-details-panel',
                            bind: {
                                visible: '{selectedPerson.type.id == 96}'
                            }
                        },
                        {
                            xtype: 'natural-person-details-panel',
                            bind: {
                                visible: '{selectedPerson.type.id == 97}'
                            }
                        },
                        {
                            xtype: 'jural-person-details-panel',
                            bind: {
                                visible: '{selectedPerson.type.id == 95}'
                            }

                        },
                        {
                            xtype: 'point-of-contact-details-panel',
                            bind: {
                                visible: '{selectedPerson.type.id == 98}'
                            }
                        }
                    ]
                },
            ]

        }
    ],

    bbar: ['->', {
        text: 'Зберегти зміни',
        handler: 'onUpdatePersonClick'
    }, {
        text: 'Додати контакт до ППК',
        handler: 'onAddPersonToPPKClick'
    },
    ]

});
