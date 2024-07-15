<%-- 
    Document   : friendRequest
    Created on : Jul 7, 2024, 1:13:02 AM
    Author     : HELLO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Pending Friend Requests</h2>
        <c:forEach var="friendRequest" items="${pendingList}">
            <div>
                <c:set var="splitRequest" value="${fn:split(friendRequest, '.')}"/>
                <p>Friend Request from User: ${splitRequest[1]} ${splitRequest[2]}</p>
                <form action="friendRequestServlet" method="post" style="display:inline;">
                    <input type="hidden" name="userRequest" value="${splitRequest[0]}">
                    <button name="action" value="acceptFriend" type="submit">Accept</button>
                </form>
                <form action="friendRequestServlet" method="post" style="display:inline;">
                    <input type="hidden" name="userRequest" value="${splitRequest[0]}">
                    <button name="action" value="rejectFriend" type="submit">Reject</button>
                </form>
            </div>
        </c:forEach>

    </body>
</html>
