<script type="text/javascript" src="/resources/js/app/view/layout/Viewport.js"></script>
<style type="text/css">
    .x-grid-row-summary .x-grid-cell{
        font-weight: bold !important;
    }
</style>
<script type="text/javascript">
    Ext.require([
        'App.view.accounting.AccountingForm',
        'App.model.PPKSaldo'
    ]);

    Ext.onReady(function () {

        App.model.PPKSaldo.load(${param.id}, {
            success: function (record) {
                Ext.create('App.view.layout.Viewport', {
                    item: {
                        xtype: 'accounting-form',
                        layout: 'fit',
                        viewModel: {
                            type: 'accounting-form',
                            data: {
                                record: record
                            }
                        }
                    }
                });
            },
            failure: function () {
                debugger;
            }
        });
    });

</script>