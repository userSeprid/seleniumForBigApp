Ext.define('App.view.ppk.list.GridViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.ppk-grid',

    onCreateClick: function() {
        location.assign("/createPPK");
    },

    onGridRowDbClick: function(view, record) {
        location.assign("/viewPPK?id=" + record.get('id'));
    }
});