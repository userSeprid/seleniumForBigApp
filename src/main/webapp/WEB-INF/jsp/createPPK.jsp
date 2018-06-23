<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="resources/js/app/view/layout/Viewport.js"></script>
<script type="text/javascript">

    Ext.require(['App.view.ppk.PPKForm', 'App.model.PPK']);

    Ext.onReady(function () {

        Ext.create('App.view.layout.Viewport', {
            item: {
                xtype: 'ppk-form',
                layout: 'fit',
                viewModel: {
                    type: 'ppk-form',
                    data:
                        {
                            record: Ext.create('App.model.PPK',
                                {
/*
                                    persons: [],
                                    requisites: 'requisites',
                                    dashboardTypeId: 47,
                                    dashboardNumber: 0,
                                    dashboardCell: -1,
                                    regionId: 21,
                                    companyId: 45,
                                    objectTypeId: 77,
                                    description: "description",
                                    reactionTime: 20,
                                    paymentNote: 15,
                                    increase: 'increase',
                                    history: 'history',
                                    techHistory: 'techHistory',
                                    managerId: 70,
                                    documents: 'documents',
                                    instrument: "instrument",
                                    managerCompanyId: 67,
                                    note: 'note',
                                    payTillDay: 11,
                                    latitude: 50.450100,
                                    longitude: 30.523400,
                                    balance: 12.12
*/
                                }
                            )
                        }
                }
            }
        });
    })
</script>