<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title><tiles:insertAttribute name="title" ignore="true"/></title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/theme-neptune-all.css">
    <script type="text/javascript" src="/resources/js/ext-all-debug.js"></script>
    <script type="text/javascript">
        (function() {
            Ext.Loader.setConfig({
                enabled: true,
                paths: {
                    App: '/resources/js/app'
                }
            });
        })();
    </script>

</head>
<body>
<%--<div><tiles:insertAttribute name="header"/></div>--%>
<%--&lt;%&ndash;<div style="float:left;padding:10px;width:15%;"><tiles:insertAttribute name="menu"/></div>&ndash;%&gt;--%>
<%--<div style="float:left;padding:10px;width:100%;border-left:1px solid pink;">--%>
    <tiles:insertAttribute name="body"/></div>
<%--<div style="clear:both"><tiles:insertAttribute name="footer"/></div>--%>

</body>
</html>