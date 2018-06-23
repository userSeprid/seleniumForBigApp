<script type="text/javascript" src="/resources/js/app/view/layout/Viewport.js"></script>
<style type="text/css">
    .x-grid-row-summary .x-grid-cell {
        font-weight: bold !important;
    }
</style>
<script type="text/javascript">

    Ext.require([
        'App.view.dictionary.editor.DictionaryEditorView',
        'App.view.dictionary.editor.DictionaryEditorViewModel',
    ]);

    Ext.onReady(function () {

        Ext.create('App.view.layout.Viewport', {
            item: {
                xtype: 'dictionary-editor',
                layout: 'fit',
                viewModel: 'dictionary-editor',
            },
        });
    })
</script>