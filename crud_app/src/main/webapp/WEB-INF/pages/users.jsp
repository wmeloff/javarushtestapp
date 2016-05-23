<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>

<head>

    <title>Users Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>

<h1>User List</h1>

<c:if test="${!empty listUsers}">
    <table class="tg">
        <tr>
            <th width="80">ID</th>
            <th width="120">Name</th>
            <th width="120">Age</th>
            <th width="120">isAdmin</th>
            <th width="120">createdDate</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>

        <c:forEach items="${listUsers}" var="user">
            <tr>
                <td>${user.id}</td>
                <td><a href="/userdata/${user.id}" target="_blank">${user.name}</a></td>
                <td>${user.age}</td>
                <td>${user.admin}</td>
                <td>${user.createdDate}</td>
                <td><a href="<c:url value='/edit/${user.id}?start=${param.start}&end=${param.end}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>
        <tfoot>
            <c:set var="count" value="${0}" scope="page" />
            <c:set var="start" value="${0}" scope="page" />
            <c:set var="startcount" value="${param.start == null ? 0 : param.start}" scope="page" />

            <c:set var="endcount" value="${param.end == null ? pagesize : param.end}" scope="page" />
            <c:set var="allend" value="${totalCount}" scope="page" />
            <c:set var="stepcount" value="${1}" scope="page" />

            <c:if test="${endcount>allend}">
                <c:set var="endcount" value="${allend}" scope="page" />
            </c:if>
            <tr>
            <c:forEach var="counter" begin="${startcount}" end="${endcount}" step="${stepcount}">
                <c:if test="${count < allend/pagesize}">

                    <c:set var="count" value="${count + 1}" scope="page" />
                    <c:set var="end" value="${counter+count-1}" scope="page" />
                    <c:set var="start" value="${counter}" scope="page" />
                </c:if>
            </c:forEach>
                <td>Записей на странице: ${pagesize} Всего записей:${totalCount}</td>
            <c:if test="${endcount>allend}">
                <c:set var="start" value="${1}" scope="page" />
                <c:set var="end" value="${allend}" scope="page" />
            </c:if>

            <c:if test="${endcount!=allend}">
                <td><a href="users?start=${(count==1)?1:start}&end=${end}">NEXT</a></td>
            </c:if>
            <c:if test="${startcount>0}">
                <td><a href="users?start=${startcount-pagesize}&end=${startcount}">PREVIOUS</a></td>
            </c:if>
            </tr>
        </tfoot>
    </table>
</c:if>


<h1>Add / Update user</h1>

<c:url var="addAction" value="/users/add"/>

<form:form action="${addAction}" commandName="user">
    <table>
        <c:if test="${!empty user.name}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="name">
                    <spring:message text="Name"/>
                </form:label>
            </td>
            <td>
                <form:input path="name"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="age">
                    <spring:message text="Age"/>
                </form:label>
            </td>
            <td>
                <form:input path="age"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="admin">
                    <spring:message text="Admin"/>
                </form:label>
            </td>
            <td>
                <form:input path="admin"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <c:if test="${!empty user.name}">
                    <input type="submit"
                           value="<spring:message text="Edit user"/>"/>
                </c:if>
                <c:if test="${empty user.name}">
                    <input type="submit"
                           value="<spring:message text="Add user"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>




<h1>Search user by id</h1>

<c:url var="ActionSearch" value="/search"/>

<form:form action="${ActionSearch}" commandName="user" method="GET">

    <tr>
        <td>
            <form:label path="id">
                <spring:message text="ID"/>
            </form:label>
        </td>
        <td>
            <form:input path="id" />
        </td>
    </tr>
    <tr>
        <td>
            <input type="submit"
                   value="<spring:message text="Search by id"/>"/>
        </td>
    </tr>


</form:form>

</body>
</html>
