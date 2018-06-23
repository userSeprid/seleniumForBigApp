Ext.define('App.view.common.ppkPerson.JuralPersonDetailsPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.jural-person-details-panel',

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
                        fieldLabel: 'Назва',
                        allowBlank: false,
                        msgTarget: 'side',
                        bind: {
                            value: '{selectedPerson.name}',
                        }
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'ЭРДПОУ',
                        placeholder: 'xxxxxxxx',
                        inputMask: '99999999',
                        bind: {
                            value: '{selectedPerson.edrpo}',
                        }
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'ІПН',
                        placeholder: 'xxxxxxxxxxxx',
                        inputMask: '999999999999',
                        bind: {
                            value: '{selectedPerson.ipn}',
                        }
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'Свідоцтво платника ПДВ',
                        placeholder: 'xxxxxxxx',
                        inputMask: '99999999',
                        bind: {
                            value: '{selectedPerson.vat}',
                        }
                    },
                    {
                        xtype: 'textfield',
                        fieldLabel: 'p/p',
                        bind: {
                            value: '{selectedPerson.account}',
                        }
                    }, {
                        xtype: 'textfield',
                        fieldLabel: 'МФО',
                        msgTarget: 'side',
                        placeholder: 'xxxxxx',
                        inputMask: '999999',
                        bind: {
                            value: '{selectedPerson.mfo}',
                        }
                    }, {
                        xtype: 'textarea',
                        fieldLabel: 'Банк',
                        bind: {
                            value: '{selectedPerson.bank}',
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
                        fieldLabel: 'Ген. директор',
                        bind: {
                            value: '{selectedPerson.cto}',
                        },
                    },
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