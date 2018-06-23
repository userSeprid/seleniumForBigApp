var fee_grid_reference = 'ppk-fee-grid';
var debit_grid_reference = 'ppk-debit-payment-grid';
var credit_grid_reference = 'ppk-credit-payment-grid';

Ext.define('App.view.accounting.AccountingController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.accounting-form',

    onPaymentDebitEdited: function (editor, e) {
        e.record.save();
        var grid = this.getView().lookup(debit_grid_reference);
        grid.getStore().reload();
        this.getView().lookup(fee_grid_reference).getStore().reload();
        this.getViewModel().get('record').load();
    },

    onPaymentCreditEdited: function (editor, e) {
        e.record.save();
        var grid = this.getView().lookup(credit_grid_reference);
        grid.getStore().reload();
        this.getView().lookup(fee_grid_reference).getStore().reload();
        this.getViewModel().get('record').load();
    },

    onCreateDebitClick: function () {
        var vm = this.getViewModel();
        var record = vm.get('record');
        var grid = this.getView().lookup(debit_grid_reference);
        var store = grid.getStore();
        var model = store.model.create({ppkId: record.id, createDate: new Date()});
        store.add(model);
        grid.editingPlugin.startEdit(model, 0);
    },

    onCreateCreditClick: function () {
        var vm = this.getViewModel();
        var record = vm.get('record');
        var grid = this.getView().lookup(credit_grid_reference);
        var store = grid.getStore();
        var model = store.model.create({ppkId: record.id, createDate: new Date()});
        store.add(model);
        grid.editingPlugin.startEdit(model, 0);
    },

    beforeLoadFees: function () {
        var grid = this.getView().lookup(fee_grid_reference);
        if (grid.headerCt.columnManager.columns != null) {
            return;
        }
        var ppkFeesStore = this.getViewModel().getStore('ppkFees');
        this.getViewModel().getStore('contractNames').load({
            callback: function (records, operation, success) {
                Ext.each(records, function (record, index) {
                    var column = {
                        text: record.data,
                        dataIndex: 'c' + index,
                        summaryType: 'sum'
                    };
                    grid.headerCt.insert(grid.columns.length + records.length, column);
                });
                grid.getView().refresh();
                grid.reconfigure(ppkFeesStore);
            }
        });
    }
})