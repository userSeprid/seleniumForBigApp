<%--
<script src="/javascript/article_admin.js"></script>
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsf/core" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>

<%--<jsp:include page="utils/contractUtils.jsp"/>--%>
<script type="text/javascript" src="resources/js/app/view/layout/Viewport.js"></script>
<script type="text/javascript">
    Ext.require('App.view.ppk.list.Grid');

    Ext.onReady(function() {
        Ext.create('App.view.layout.Viewport', {
            item: {
                xtype: 'ppk-grid',
                layout: 'fit'
            }
        });
    })
</script>

