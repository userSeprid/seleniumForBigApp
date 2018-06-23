Ext.define('App.view.common.address.AddressPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.address-panel',

    requires: [
        'App.view.common.address.AddressPanelController',
        'App.view.common.address.AddressPanelViewModel'
    ],

    viewModel: 'address-panel',
    controller: 'address-panel',

    title: 'Адреса',

    layout: {
        type: 'vbox',
        align: 'stretch'
    },

    defaults: {
        padding: '10 10 10 10',
    },

    items: [
        {
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
                //1
                defaults: {
                    labelAlign: 'top'
                },
                items: [
                    {
                        xtype: 'textfield',
                        id: 'city-dictionary-id',
                        fieldLabel: 'Місто, смт, селище',
                        bind: {
                            value: '{record.locationCity}',
                        },
                    }, {
                        xtype: 'textfield',
                        id: 'location-region-dictionary-id',
                        fieldLabel: 'Район',
                        bind: {
                            value: '{record.locationRegion}',
                        },
                    }]
            },
                {
                    //2
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [{
                        xtype: 'textfield',
                        id: 'street-dictionary-id',
                        fieldLabel: 'Вулиця, проспект, бульвар, провулок',
                        bind: {
                            value: '{record.locationStreet}',
                        },
                    },
                        {
                            xtype: 'numberfield',
                            id: 'building-dictionary-id',
                            fieldLabel: 'Будинок',
                            bind: {
                                value: '{record.locationHouse}',
                            },
                        }]
                },
                {
                    //3
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [{
                        xtype: 'numberfield',
                        id: 'house-block-dictionary-id',
                        fieldLabel: 'Корпус',
                        bind: {
                            value: '{record.locationKorpus}',
                        },
                    },
                        {
                            xtype: 'numberfield',
                            id: 'entrance-dictionary-id',
                            fieldLabel: 'Під\'їзд',
                            bind: {
                                value: '{record.locationEntrance}',
                            },
                        },
                    ]
                }, {
                    //4
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [
                        {
                            xtype: 'numberfield',
                            id: 'floor-dictionary-id',
                            fieldLabel: 'Поверх',
                            bind: {
                                value: '{record.locationFloor}',
                            }
                            ,
                        },
                        {
                            xtype: 'numberfield',
                            id: 'flat-number-dictionary-id',
                            fieldLabel:
                                'Квартира',
                            bind: {
                                value: '{record.locationApartments}',
                            }
                            ,
                        }
                    ]
                }]
        }]
});