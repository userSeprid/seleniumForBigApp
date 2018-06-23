Ext.define('App.view.layout.Viewport', {
    extend: 'Ext.Viewport',
    alias: 'widget.main-viewport',
    requires: ['App.view.layout.Header'],

    scrollable: {
        x: false,
        y: true,
        indicators: false // this ?
    },

    constructor: function (config) {
        var self = this;
        self.items = [{
            xtype: 'main-header',
            region: 'north',
            height: 40
        }, Ext.apply(config.item, {region: 'center'})]
        self.callParent(arguments);
    },

    initComponent: function () {
        var self = this;
        self.items = [{
            xtype: 'main-header',
            region: 'north',
            height: 40
        }, Ext.merge({region: 'center'}, self.config.item)];
        self.callParent(arguments);
    }
});