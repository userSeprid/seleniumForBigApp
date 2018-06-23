Ext.define('App.view.layout.Header', {
    extend: 'Ext.Container',
    alias: 'widget.main-header',

    layout: 'fit',
    height: 20,
    style: {
        'background-color': '#f5f5f5'
    },

    items: [
        {
            xtype: 'toolbar',
            width: 500,
            items: [
                {
                    xtype: 'tbtext',
                    style: 'width:auto;height:20px;margin-left:10px;color:gold;font-weight: bold;font-size:20px;',
                    html: 'SIRIUS',
                },
                {xtype: 'tbspacer'},
                {
                    text: 'Список ППК',
                    handler: function () {
                        location.assign("/ppkList");
                    }
                },
                {
                    text: 'Редактор словників',
                    handler: function () {
                        location.assign("/dictionary/editor");
                    }
                },
            ]
        }
    ]
});