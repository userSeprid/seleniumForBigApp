Ext.define('App.view.common.ppkPerson.PointOfContactPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.point-of-contact-details-panel',

    padding: '10 10 10 10',
    title: 'Даталі контакту',

    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    items: [{
        // First field set
        xtype: 'container',
        layout: {
            type: 'hbox',
            align: 'stretch'
        },
        defaults: {
            xtype: 'container',
            flex: 1,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            padding: '10 15'
        },
        items: [
            {
                //First column
                defaults: {
                    labelAlign: 'top'
                },
                items: [
                    {
                        xtype: 'textfield',
                        fieldLabel: 'ПІП',
                        allowBlank: false,
                        msgTarget: 'side',
                        bind: {
                            value: '{selectedPerson.name}',
                        }
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'Телефон',
                        placeholder: '(xxx) xxx-xx-xx',
                        inputMask: '(999) 999-99-99',
                        bind: {
                            value: '{selectedPerson.phone}',
                        },
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'e-mail',
                        vtype: 'email',
                        bind: {
                            value: '{selectedPerson.email}',
                        },

                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'Факс',
                        placeholder: '(xxx) xxx-xx-xx',
                        inputMask: '(999) 999-99-99',
                        bind: {
                            value: '{selectedPerson.fax}',
                        },

                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'Skype',
                        bind: {
                            value: '{selectedPerson.skype}',
                        },
                    }, {
                        xtype: 'textarea',
                        fieldLabel: 'Примiтки',
                        bind: {
                            value: '{selectedPerson.note}',
                        },

                    },
                ]
            },
/*
            {
                //Second column
                defaults: {
                    labelAlign: 'top'
                },
                items: []
            },
            {
                //third column
                defaults: {
                    labelAlign: 'top'
                },
                items: []
            }
*/
        ]
    }]
})
;