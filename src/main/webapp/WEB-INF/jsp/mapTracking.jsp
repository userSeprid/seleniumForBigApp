<%--
<script src="/javascript/article_admin.js"></script>
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsf/core" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>

<%--<jsp:include page="utils/contractUtils.jsp"/>--%>
<script type="text/javascript" src="/resources/js/app/view/layout/Viewport.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSnOVT_XFr-pTfdKrDl20KcUtFuY9YUN4"></script>
<script type="text/javascript">

    Ext.require(['App.view.map.MapTrackingForm']);

    Ext.Loader.setConfig({enabled: true});
    Ext.Loader.setPath('Ext.ux', '/resources/js/ux');

    Ext.require([
        'Ext.window.*',
        'Ext.ux.GMapPanel'
    ]);

    Ext.onReady(function () {

        Ext.create('App.view.layout.Viewport', {
            item: {
                layout: 'fit',
                xtype: 'map-tracking-form',
            }
        });
    });
</script>