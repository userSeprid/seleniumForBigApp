Ext.define('App.view.common.requiredDocuments.PPKRequiredDocumentsController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.required-documents-grid',

    onRequiredDocumentEdited: function (editor, e) {
        var self = this;
        e.record.save({
            callback: function (records, operation, success) {
                self.getView().getStore().reload();
            }
        });
    },

    onCreateClick: function () {
        var grid = this.getView();
        var store = grid.getStore();
        var model = store.model.create({
            ppkId: this.getViewModel().data.ppkId
        });
        store.add(model);
        grid.editingPlugin.startEdit(model, 0);
    },

    onDeleteClick: function () {
        var grid = this.getView();
        Ext.Ajax.request({
            method: 'DELETE',
            headers: {'Content-Type': 'application/json'},
            url: 'api/ppkRequiresDocuments/item/' + grid.getSelectionModel().getSelection()[0].id,
            success: function (res) {
                grid.getStore().reload();
            },
            failure: function (err) {
                debugger;
            }
        });

    },

    onSelectionChange: function (selected, eOpts) {
        if (eOpts.length > 0) {
            this.getView().lookup('deleteBtn').enable();
        } else {
            this.getView().lookup('deleteBtn').disable();
        }
    },

});