Ext.define('App.view.common.PersonCard', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.person-card',

    requires: [
        'App.view.common.ContractGrid',
        'App.view.common.PPKPersonGrid',
        'App.view.common.PPKViewGrid',
        'App.view.ppk.shared.DictionaryComboBox',
        'App.view.common.requiredDocuments.PPKRequiredDocumentsGrid',
        'App.model.PPKRequiredDocument',
        'App.view.common.address.AddressPanel'
    ],

    title: 'Картка клієнта',
    scrollable: true,
    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    defaults: {
        padding: '10 10 10 10',
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
        items: [{
            //First column
            defaults: {
                labelAlign: 'top'
            },
            items: [{
                xtype: 'datefield',
                dateFormat: 'Y-m-d',
                format: 'd-m-Y',
                fieldLabel: 'ППК Дата',
                bind: {
                    value: '{record.createDate}',
                }
            }, {
                xtype: 'dictionary-combobox',
                id: 'company-dictionary-id',
                fieldLabel: 'Компанія',
                publishes: 'selection',
                reference: 'company',
                msgTarget: 'side',
                bind: {
                    value: '{record.companyId}',
                    store: '{companies}'
                }
            }, {
                xtype: 'dictionary-combobox',
                id: 'region-dictionary-id',
                fieldLabel: 'Регіон',
                publishes: 'selection',
                reference: 'region',
                msgTarget: 'side',
                bind: {
                    value: '{record.regionId}',
                    store: '{regions}'
                }
            },
            ]
        }, {
            //Second column
            defaults: {
                labelAlign: 'top'
            },
            items: [{
                xtype: 'dictionary-combobox',
                id: 'console-dictionary-id',
                fieldLabel: 'Пульт',
                publishes: 'selection',
                reference: 'dashboardType',
                msgTarget: 'side',
                bind: {
                    value: '{record.dashboardTypeId}',
                    store: '{dashboardTypes}'
                },
                listeners: {
                    select: function (combo, records, eOpts) {
                        debugger;
                    }
                }
            }, {
                xtype: 'numberfield',
                id: 'console-number-dictionary-id',
                fieldLabel: '№ п-ту',
                reference: 'dashboardNumber',
                publishes: 'value',
                minValue: 0,
                msgTarget: 'side',
                bind: {
                    value: '{record.dashboardNumber}',
                }
            }, {
                xtype: 'combobox',
                id: 'dashboar-cell-id',
                reference: 'dashboardCell',
                editable: false,
                displayField: 'cellNumber',
                valueField: 'cellNumber',
                publishes: 'selection',
                msgTarget: 'side',
                bind: {
                    value: '{record.dashboardCell}',
                    store: '{dashboardCell}'
                }
            },
            ]
        }, {
            //Third column
            defaults: {
                labelAlign: 'top'
            },
            items: [{
                xtype: 'combobox',
                id: 'ppk-dictionary-id',
                displayField: 'title',
                valueField: 'id',
                reference: 'dashboardSubtype',
                publishes: 'selection',
                fieldLabel: 'ППК',
                msgTarget: 'side',
                bind: {
                    value: '{record.dashboardSubtypeId}',
                    store: '{dashboardSubtypes}'
                }
            }, {
                xtype: 'textfield',
                msgTarget: 'side',
                bind: {
                    value: '{record.dashboardProperty}',
                },
            },
                {
                    xtype: 'textfield',
                    id: 'sim-card1-dictionary-id',
                    fieldLabel: 'Сім картка 1',
                    placeholder: '(xxx) xxx-xx-xx',
                    inputMask: '(999) 999-99-99',
                    bind: {
                        value: '{record.simCard1}',
                    },
                }, {
                    xtype: 'textfield',
                    id: 'sim-card2-dictionary-id',
                    fieldLabel: 'Сім картка 2',
                    placeholder: '(xxx) xxx-xx-xx',
                    inputMask: '(999) 999-99-99',
                    bind: {
                        value: '{record.simCard2}',
                    },
                }]
        }, {
            defaults: {
                labelAlign: 'top'
            },
            items: [{
                xtype: 'fieldcontainer',
                layout: {
                    type: 'vbox',
                    align: 'stretch'
                },
                fieldLabel: 'Менеджер',
                items: [{
                    xtype: 'dictionary-combobox',
                    id: 'manager-company-dictionary-id',
                    msgTarget: 'side',
                    bind: {
                        value: '{record.managerCompanyId}',
                        store: '{managerCompanies}'
                    }
                }, {
                    xtype: 'dictionary-combobox',
                    id: 'manager-dictionary-id',
                    msgTarget: 'side',
                    bind: {
                        value: '{record.managerId}',
                        store: '{managers}'
                    }
                }]
            }, {
                xtype: 'dictionary-combobox',
                id: 'came-from-dictionary-id',
                fieldLabel: 'Прийшов від',
                msgTarget: 'side',
                bind: {
                    value: '{record.cameFromId}',
                    store: '{cameFrom}'
                }
            }/*, {
                xtype: 'dictionary-combobox',
                allowBlank: false,
                fieldLabel: 'Уйшов на',
                msgTarget: 'side',
                bind: {
                    value: '{record.goneToId}',
                    store: '{goneTo}'
                }
            }*/]
        }, {
            defaults: {
                labelAlign: 'top'
            },
            items: [
                {
                    xtype: 'dictionary-combobox',
                    id: 'object-dictionary-id',
                    fieldLabel: 'Об’єкт',
                    msgTarget: 'side',
                    bind: {
                        value: '{record.objectTypeId}',
                        store: '{objectTypes}'
                    }
                }, {
                    xtype: 'textfield',
                    id: 'latitude-dictionary-id',
                    fieldLabel: 'latitude',
                    reference: 'latitude',
                    publishes: 'value',
                    minValue: 0,
                    msgTarget: 'side',
                    bind: {
                        value: '{record.latitude}'
                    }
                },
                {
                    xtype: 'textfield',
                    id: 'longitude-dictionary-id',
                    fieldLabel: 'longitude',
                    reference: 'longitude',
                    publishes: 'value',
                    minValue: 0,
                    msgTarget: 'side',
                    maxLength: 10,
                    bind: {
                        value: '{record.longitude}'
                    }
                },
                {
                    xtype: 'numberfield',
                    id: 'react-time-dictionary-id',
                    fieldLabel: 'Час реагування',
                    msgTarget: 'side',
                    bind: {
                        value: '{record.reactionTime}'
                    }
                },
            ]
        }, {
            defaults: {
                labelAlign: 'top'
            },
            items: [{
                fieldLabel: 'Початковий баланс',
                xtype: 'numberfield',
                id: 'start-capital-dictionary-id',
                allowBlank: false,
                msgTarget: 'side',
                decimalPrecision: 2,
                bind: {
                    value: "{record.balance}"
                }
            }, {
                xtype: 'textarea',
                id: 'balance-notes-dictionary-id',
                grow: true,
                msgTarget: 'side',
                bind: {
                    value: "{record.balanceDescription}"
                }
            }, {
                fieldLabel: 'Сплата до',
                id: 'deadline-dictionary-id',
                xtype: 'numberfield',
                msgTarget: 'side',
                bind: {
                    value: "{record.payTillDay}"
                }
            },
            ]
        }
        ]
    }, {
        xtype: 'address-panel',
    }, {
        xtype: 'contract-grid',
        minHeight: 300,
        reference: 'contracts',
        bind: {
            store: '{contractsStates}',
        },
        listeners: {
            edit: 'onContractEdited',
        }
    }, {
        xtype: 'ppk-person-grid',
        height: 'auto',
        reference: 'ppkpersons',
        allowBlank: false,
        msgTarget: 'side',
        minHeight: 200,
        bind: {
            store: '{ppkpersons}',
        },
        listeners: {
            edit: 'onPPKPersonEdited',
        }
    }, {
        xtype: 'ppk-view-grid',
        minHeight: 200,
        title: 'Корпоративні об\'єкти',
        bind: {
            store: '{ppksSameOwner}',
        }
    }, {
        xtype: 'ppk-view-grid',
        minHeight: 200,
        title: 'Пов\'язані об\'єкти',
        bind: {
            store: '{ppksByAdvisor}',
            visible: '{record.id > -1}'
        }
    }, {
        xtype: 'required-documents-grid',
        title: 'Необхідні документи',
        bind: {
            store: '{ppkRequiresDocuments}',
            viewModel: {
                data: {
                    ppkId: '{record.id}'
                }
            },
        },
    }, {
        xtype: 'textarea',
        id: 'history-dictionary-id',
        fieldLabel: 'Історія',
        grow: true,
        msgTarget: 'side',
        bind: {
            value: "{record.history}"
        }
    }, {
        xtype: 'textarea',
        id: 'tech-history-dictionary-id',
        fieldLabel: 'Tex. iсторія',
        grow: true,
        bind: {
            value: "{record.techHistory}"
        }
    }, {
        xtype: 'textarea',
        id: 'description-dictionary-id',
        fieldLabel: 'Опис',
        grow: true,
        msgTarget: 'side',
        bind: {
            value: "{record.description}"
        }
    }, {
        xtype: 'textfield',
        id: 'possibility-to-increase-ap-dictionary-id',
        fieldLabel: 'Можливість збільш. АП',
        grow: true,
        msgTarget: 'side',
        bind: {
            value: "{record.increase}"
        }
    }, {
        xtype: 'textarea',
        id: 'notes-dictionary-id',
        fieldLabel: 'Примітки',
        grow: true,
        bind: {
            value: "{record.note}"
        }
    },
    ]
});