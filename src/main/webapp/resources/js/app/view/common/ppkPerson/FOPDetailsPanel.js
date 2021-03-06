Ext.define('App.view.common.ppkPerson.FOPDetailsPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.fop-details-panel',

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
                        fieldLabel: 'Паспорт',
                        bind: {
                            value: '{selectedPerson.passportNumber}',
                        }
                    }, {
                        xtype: 'textarea',
                        fieldLabel: 'Ким коли віданий',
                        bind: {
                            value: '{selectedPerson.passportInstitute}',
                        }
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'ІНН',
                        placeholder: 'xxxxxxxxxx',
                        inputMask: '9999999999',
                        bind: {
                            value: '{selectedPerson.inn}',
                        }
                    },{
                        xtype: 'textfield',
                        fieldLabel: 'Номер запису ЄДРПО',
                        msgTarget: 'side',
                        placeholder: 'xxxxxxxxxxxxxxxxx',
                        inputMask: '99999999999999999',
                        bind: {
                            value: '{selectedPerson.edrpo}',
                        }
                    },{
                        xtype: 'datefield',
                        format: 'd.m.Y',
                        fieldLabel: 'Дата реєстрації',
                        bind: {
                            value: '{selectedPerson.registrationDate}',
                        }
                    },]
            },
            {
                //Second column
                defaults: {
                    labelAlign: 'top'
                },
                items: [
                    {
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

                    },
                ]
            },
            {
                //third column
                defaults: {
                    labelAlign: 'top'
                },
                items: [{
                    xtype: 'textarea',
                    fieldLabel: 'Юридична адреса',
                    bind: {
                        value: '{selectedPerson.registration}',
                    }
                }, {
                    xtype: 'textarea',
                    fieldLabel: 'Фактична адреса',
                    reference: 'factAddress',
                    bind: {
                        value: '{selectedPerson.factAddress}',
                    }
                }, {
                    xtype: 'textarea',
                    fieldLabel: 'Примiтки',
                    bind: {
                        value: '{selectedPerson.note}',
                    },

                },]
            }
        ]
    }]
})
;