Ext.define('App.view.contract.create.ContractCreateController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.contract-create-form',

    submitContract: function (conf) {
        var form = this.getView();
        if (form.isValid()) {
            var self = this;
            var vm = self.getViewModel();

            var record = vm.get('record');

            var req = record.data;

            Ext.Ajax.request({
                method: conf.method,
                headers: {'Content-Type': 'application/json'},
                url: 'api/contract/item',
                params: Ext.util.JSON.encode(req),
                success: function (res) {
                    location.assign('/viewPPK?id=' + Ext.util.JSON.decode(res.responseText).id);
                },
                failure: function (err) {
                    debugger;
                }
            });
        }
    },

    onCreateContractClick: function () {
        this.submitContract({method: 'POST'});
    },

    onUpdateContractClick: function () {
        this.submitContract({method: 'PUT'});
    },

});