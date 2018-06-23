Ext.define('App.view.ppk.PPKViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.ppk-form',


    requires: [
        'App.model.Dictionary',
        'App.model.Cell',
        'App.model.Contract',
        'App.model.ContractState',
        'App.model.PPKReminder',
    ],

    data: {
        minDate: new Date(1900, 0, 1),
        maxDate: new Date(),
        dateEditor: {
            xtype: 'datefield',
            format: 'd.m.Y',
            bind: {
                minValue: '{minDate}',
                maxValue: '{maxDate}'
            }
        }
    },

    formulas: {

        extraParams: {
            bind: {
                dashboardType: '{dashboardType.selection.id}',
                dashboardNumber: '{dashboardNumber.value}'
            },
            get: function (data) {
                return {
                    dashboardTypeId: data.dashboardType,
                    dashboardNumber: data.dashboardNumber,
                }
            }
        },

        ppkNumber: {

            bind: {
                company: '{company.selection}',
                region: '{region.selection}',
                dashboardType: '{dashboardType.selection}',
                dashboardNumber: '{dashboardNumber.value}',
                dashboardCell: '{dashboardCell.selection}',
            },

            get: function (values) {
                var company = values.company ? values.company.data.code : 'xxx';
                var region = values.region ? values.region.data.code : 'xx';
                var dashboardType = values.dashboardType ? values.dashboardType.data.code : 'x';
                var dashboardNumber = values.dashboardNumber ? values.dashboardNumber : 'x';
                var dashboardCell = values.dashboardCell ? values.dashboardCell.data.cellNumber : 'xxx';
                return Ext.String.format('{0}-П-{1}-{2}{3}{4}',
                    company, region, dashboardType, dashboardNumber, dashboardCell);
            }
        },

        extraParams: {
            bind: {
                dashboardType: '{dashboardType.selection.id}',
                dashboardNumber: '{dashboardNumber.value}'
            },
            get: function (data) {
                return {
                    dashboardTypeId: data.dashboardType,
                    dashboardNumber: data.dashboardNumber,
                }
            }
        },

        cellParams: {
            bind: {
                dashboardType: '{dashboardType.selection.id}',
                dashboardSubtype: '{dashboardSubtype.selection.id}',
                dashboardNumber: '{dashboardNumber.value}'
            },
            get: function (data) {
                return {
                    dashboardTypeId: data.dashboardType,
                    dashboardSubtype: data.dashboardSubtype,
                    dashboardNumber: data.dashboardNumber,
                }
            }
        },

    },

    stores: {
        companies: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 3
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },
        regions: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 2
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },
        dashboardTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 4
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        dashboardSubtypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: '{dashboardType.selection.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
            updateProxy: function (proxy) {
                proxy.onAfter('extraparamschanged', this.load, this)
            }
        },

        dashboardCell: {
            //model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dashboard/availableCells',
                extraParams: {
                    dashboardTypeId: '{dashboardType.selection.id}',
                    dashboardSubtypeId: '{dashboardSubtype.selection.id}',
                    dashboardNumber: '{dashboardNumber.value}',
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
            updateProxy: function (proxy) {
                proxy.onAfter('extraparamschanged', this.load, this)
            }
        },

        objectTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 5
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        states: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 6
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },
        managerCompanies: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 65
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },
        managers: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: '{record.managerCompanyId}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
            updateProxy: function (proxy) {
                proxy.onAfter('extraparamschanged', this.load, this)
            }
        },

        contractsStates: {
            autoLoad: true,
            model: 'App.model.ContractState',
            proxy: {
                type: 'rest',
                url: '/api/contractState/items',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
        },

        ppkpersons: {
            autoLoad: true,
            model: 'App.model.PPKPerson',
            proxy: {
                type: 'rest',
                url: '/api/ppkperson/items',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
        },

        ppksSameOwner: {
            autoLoad: true,
            model: 'App.model.PPKListItem',
            proxy: {
                type: 'rest',
                url: '/api/ppk/items/sameOwner',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
        },

        ppksByAdvisor: {
            autoLoad: true,
            model: 'App.model.PPKListItem',
            proxy: {
                type: 'rest',
                url: '/api/ppk/items/byAdvisor',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
        },

        ppkRequiresDocuments: {
            model: 'App.model.PPKRequiredDocument',
            autoLoad: true,
            proxy: {
                type: 'rest',
                url: '/api/ppkRequiresDocuments/items',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                },
                writer: {
                    type: 'json'
                }
            }
        },

        cameFrom: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 120
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        goneTo: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
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
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 123
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        ppkReminders: {
            model: 'App.model.PPKReminder',
            autoLoad: true,
            ppkId: '{record.id}',
            proxy: {
                type: 'rest',
                url: '/api/ppkReminder/items',
                extraParams: {
                    ppkId: '{record.id}'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                },
                writer: {
                    type: 'json'
                }
            }
        },

        requiredDocumentStatus: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 144
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            }
        },

        contractTypes: {
            model: 'App.model.Dictionary',
            autoLoad: true,
            proxy: {
                type: 'ajax',
                url: '/api/dictionary/findByParentId',
                extraParams: {
                    parentId: 1
                },
                reader: {
                    type: 'json',
                    rootProperty: 'items'
                }
            },
            listeners: {
                load: function (store, records, success, operation, opts) {
                    var toolbar = Ext.getCmp('addNewContractBtn');
                    // First the top level items
                    store.each(function (record) {
                        toolbar.menu.add({
                            text: record.get('title'),
                            contractTypeId: record.get('id'),
                            listeners: {
                                click: 'onAddContractClick'
                            }
                        })
                    })
                }
            }
        },


    }

});