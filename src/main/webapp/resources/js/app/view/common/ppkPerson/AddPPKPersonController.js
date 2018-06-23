Ext.define('App.view.common.ppkPerson.AddPPKPersonController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.add-ppk-person-dlg',


    onPersonEdited: function (editor, e) {
        var self = this;
        e.record.save({
            callback: function (r, options, success) {
                debugger;
                if (success === true) {
                    var filter = self.getView().lookup('filter');
                    filter.setValue(e.record.data.name);
                    self.getStore('persons').reload();
                }
            }
        });
    },

    onCreatePersonClick: function () {
        var grid = this.getView().lookup('persons');
        var store = grid.getStore();
        var model = store.model.create();
        store.add(model);
        grid.editingPlugin.startEdit(model, 0);
    },

    onAddPersonToPPKClick: function () {
        this.getView().performAdd = true;
        this.getView().hide();
    },

    onUpdatePersonClick: function () {
        this.getView().lookup('persons').getSelectionModel().getSelection()[0].save();
    }

})