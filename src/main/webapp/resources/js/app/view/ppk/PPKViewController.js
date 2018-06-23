var addPPKPerson;

Ext.define('App.view.ppk.PPKViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.ppk-form',

    onFileInputChange: function (fileInput, value, newValue, opts) {
        var self = this;
        var file = event.target.files[0];
        var reader = new FileReader();
        var record = self.getViewModel().get('record');
        reader.onload = function (e) {
            var image = self.lookup(opts.ref);
            //image.el.dom.src = e.target.result;
            record.set(opts.ref, e.target.result);
        };
        if (file) reader.readAsDataURL(file);
    },


    onCreatePPKClick: function () {
        var self = this;
        var vm = self.getViewModel();

        var record = vm.get('record');

        /*
                    var grid = self.lookup('ppkpersons');
                    var persons = Ext.pluck(grid.getStore().getRange(0, 10), 'data');
        */

        var response = record.data;
//            response.persons = persons;

        Ext.Ajax.request({
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            url: '/api/ppk/item',
            params: Ext.util.JSON.encode(response),
            success: function (res) {
                location.assign("/viewPPK?id=" + Ext.util.JSON.decode(res.responseText).id);
            },
            failure: function (err) {
                debugger;
                Ext.Msg.alert('Помилка', 'Комірка вже зайнята', Ext.emptyFn);
            }
        });
    },

    onAddPPKPersonClick: function () {
        var record = this.getViewModel().get('record');
        var ppkpersons = this.getView().lookup('ppkpersons');

        addPPKPerson = Ext.create('App.view.common.ppkPerson.AddPPKPersonDlg', {
                viewConfig: {
                    preserveScrollOnReload: true
                },
                viewModel: {
                    type: 'add-ppk-person-dlg',
                },
                listeners: {
                    beforehide: function (win, eOpts) {
                        var selection = win.lookup('persons').getSelectionModel().getSelection();
                        if (win.performAdd && selection.length > 0) {
                            var person = selection[0];
                            Ext.create('App.model.PPKPerson', {
                                ppkId: record.id,
                                personId: person.id,
                            }).save({
                                callback: function (r, options, success) {
                                    ppkpersons.store.reload();
                                }
                            });
                        }
                        return true;
                    }
                }
            }
        );
        addPPKPerson.show();
    },

    onUpdatePPKClick: function () {
        var form = this.getView();
        if (form.isValid()) {
            var self = this;
            var vm = self.getViewModel();

            var record = vm.get('record');

            var files = {
                scheme: record.get('scheme'),
                map: record.get('map'),
                mapDetails: record.get('details')
            };


            var response = record.data;
            response.files = files;

            Ext.Ajax.request({
                method: 'PUT',
                headers: {'Content-Type': 'application/json'},
                url: '/api/ppk/item',
                params: Ext.util.JSON.encode(response),
                success: function (res) {
                    location.assign("/viewPPK?id=" + Ext.util.JSON.decode(res.responseText).id);
                },
                failure: function (err) {
                    Ext.Msg.alert('Помилка', 'Комірка вже зайнята', Ext.emptyFn);
                    debugger;
                }
            });
        }

    },

    onContractEdited: function (editor, e) {
        debugger;
        e.record.save({
            callback: function (records, operation, success) {
                if (!success) {
                    Ext.Msg.alert('Помилка', 'Зміни в датах не валідні, зміни не збережені', Ext.emptyFn);
                }
            }
        });
        this.getStore('contracts').reload();
    },

    onImageSave: function () {
        var self = this;
        var vm = self.getViewModel();
        var record = vm.get('record');

        var images = {
            ppkId: record.get('id'),
            scheme: record.get('scheme'),
            map: record.get('map'),
            mapDetails: record.get('mapDetails')
        };

        Ext.Ajax.request({
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            url: '/api/ppkFiles/updateFiles',
            params: Ext.util.JSON.encode(images),
            success: function (res) {
                debugger;
            },
            failure: function (err) {
                debugger;
            }
        });
    },

    beforeEditContract: function (editor, context, eOpts) {
        /* alert(Ext.Array.findBy(editor.getCmp().getColumns(), function (item, index) {
             return item.dataIndex === 'startDate';
         }));
         this.getView().lookup('contracts').getColumns()[2].getEditor().minValue = new Date();*/
        // return context.record.data.stateId != 93;
        return true;
    },

    onChangeSelectedContract: function (selected, eOpts) {
        if (selected.selected.items[0].data.endDate != null) {
            this.getView().lookup('addPeriodToContractBtn').enable();
        } else {
            this.getView().lookup('addPeriodToContractBtn').disable();
        }
    },

    onPPKPersonEdited: function (editor, e) {
        var self = this;
        e.record.save({
            callback: function (records, operation, success) {
                self.getStore('ppkpersons').reload();
                self.getStore('ppksSameOwner').reload();
                self.getStore('ppksByAdvisor').reload();
                self.getStore('ppkRequiresDocuments').reload();
            }
        });
    },

    onPPKDisableClick: function () {
        var vm = this.getViewModel();
        var record = vm.get('record');
        Ext.Ajax.request({
            method: 'PUT',
            url: 'api/ppk/item/disable/' + record.get('id'),
            success: function (response, opts) {
                location.assign("/viewPPK?id=" + record.get('id'));
            },

            failure: function (response, opts) {
                console.log('server-side failure with status code ' + response.status);
                debugger;
            }
        })
    },

    onShowAccountingForm: function () {
        var vm = this.getViewModel();
        var record = vm.get('record');
        location.assign("/accounting/report?id=" + record.id);
    },

    onPersonEdited: function (editor, e) {
        e.record.save();
        if (e.record.id < 0) {
            var filter = this.getView().lookup('filter');
            filter.setValue(e.record.data.name);
        }
        this.getStore('ppkpersons').reload();
    },

    onCreatePersonClick: function () {
        var grid = this.getView().lookup('ppkpersons');
        var store = grid.getStore();
        var model = store.model.create();
        store.add(model);
        grid.editingPlugin.startEdit(model, 0);
    },

    onAddPersonToPPKClick: function () {
        var vm = this.getViewModel();
        var record = vm.get('record');

        var grid = this.getView().lookup('persons');
        var row = grid.getSelectionModel().getSelection()[0];
        Ext.create('App.model.PPKPerson', {
            ppkId: record.id,
            personId: row.data.id,
        }).save();

        location.assign("/viewPPK?id=" + record.id);
    },

    onAddContractClick: function (menu, item, e, eOpts) {
        var grid = this.getView().lookup('contracts');
        var record = this.getViewModel().get('record');
        debugger;
        var contract = Ext.create('App.model.Contract',
            {
                ppkId: record.id,
                typeId: menu.contractTypeId
            });
        contract.save({
            callback: function (records, operation, success) {
                grid.getStore().reload();
            }
        });

    },

    onAddPeriodToContractClick: function () {
        var grid = this.getView().lookup('contracts');
        var row = grid.getSelectionModel().getSelection()[0];
        var record = Ext.create('App.model.ContractState',
            {
                contractId: row.get('contractId'),
            });
        record.save({
            callback: function (records, operation, success) {
                grid.getStore().reload();
            }
        });
    },

})
;