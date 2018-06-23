<%--
<script src="/javascript/article_admin.js"></script>
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="resources/js/app/view/layout/Viewport.js"></script>
<script type="text/javascript">
    Ext.require(['App.view.ppk.PPKForm', 'App.model.PPK']);

    Ext.onReady(function() {

        App.model.PPK.load(${param.id}, {
            success: function(record) {
                Ext.create('App.view.layout.Viewport', {
                    item: {
                        xtype: 'ppk-form',
                        layout: 'fit',
                        viewModel: {
                            type: 'ppk-form',
                            data:{
                                record: record
                            }
                        }
                    }
                });
            },
            failure: function() {
                //TODO: handle this issue
            }
        });
    })
</script>