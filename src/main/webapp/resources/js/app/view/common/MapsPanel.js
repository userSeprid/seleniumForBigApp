Ext.define('App.view.common.MapsPanel', {
        extend: 'Ext.panel.Panel',
        alias: 'widget.maps-panel',

        requires: [
            'App.view.common.ContractGrid',
            'App.view.ppk.shared.DictionaryComboBox'
        ],

        title: 'Картка клієнта',
        scrollable: true,
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
                        labelAlign: 'top',
                    },
                    items: [{
                        xtype: 'image',
                        reference: 'scheme',
                        bind: {
                            src: '{record.scheme}'
                        },
                        style: {
                            'height': 'auto',
                            'min-width': '300px',
                            'min-height': '300px',
                            'max-width': '300px',
                            'max-height': '300px'
                        },
                    }, {
                        xtype: 'filefield',
                        buttonText: 'Вибiр',
                        width: '100%',
                        fieldLabel: 'Схема',
                        labelAlign: 'top',
                        listeners: {
                            change: {
                                fn: 'onFileInputChange',
                                ref: 'scheme'
                            }
                        }
                    }
                    ]
                },
                {
                    //Second column
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [{
                        xtype: 'image',
                        style: {
                            'height': 'auto',
                            'min-width': '300px',
                            'min-height': '300px',
                            'max-width': '300px',
                            'max-height': '300px'
                        },
                        reference: 'map',
                        bind: {
                            src: '{record.map}'
                        }
                    }, {
                        xtype: 'filefield',
                        buttonText: 'Вибiр',
                        width: '100%',
                        fieldLabel: 'Карта',
                        labelAlign: 'top',
                        listeners: {
                            change: {
                                fn: 'onFileInputChange',
                                ref: 'map'
                            }
                        }
                    }
                    ]
                },
                {
                    //Third column
                    defaults: {
                        labelAlign: 'top'
                    },
                    items: [{
                        xtype: 'image',
                        style: {
                            'height': 'auto',
                            'min-width': '300px',
                            'min-height': '300px',
                            'max-width': '300px',
                            'max-height': '300px'
                        },
                        reference: 'mapDetails',
                        bind: {
                            src: '{record.mapDetails}'
                        }
                    },
                        {
                            xtype: 'filefield',
                            buttonText: 'Вибiр',
                            width: '100%',
                            fieldLabel: 'Карта деталізація',
                            labelAlign: 'top',
                            listeners: {
                                change: {
                                    fn: 'onFileInputChange',
                                    ref: 'mapDetails'
                                }
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Оновити',
                            handler: 'onImageSave'
                        }
                    ]
                }]
        }]
    }
);