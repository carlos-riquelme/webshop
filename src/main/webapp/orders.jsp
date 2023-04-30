<%@page import="cn.shopping.connection.DbCon"%>
<%@page import="cn.shopping.model.*"%>
<%@page import="cn.shopping.dbob.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% 
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    if(auth != null){
    	request.setAttribute("auth", auth);
    	orders = new OrderDaob(DbCon.getConnection()).userOrders(auth.getId());
    } else {
    	response.sendRedirect("login.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
    	request.setAttribute("cart_list", cart_list);
    }
    %>
<!DOCTYPE html>
<html>
<head>

<title>Orders</title>
<%@include file="includes/header.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp" %>"
<div class="container">
		<div class="card-header my-3">All Orders</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Fecha</th>
					<th scope="col">Nombre</th>
					<th scope="col">Categoría</th>
					<th scope="col">Cantidad</th>
					<th scope="col">Precio</th>
					<th scope="col">Cancelar</th>
				</tr>
			</thead>
			<tbody>
			
			<%
			if(orders != null){
				for(Order o:orders){%>
					<tr>
						<td><%=o.getDate() %></td>
						<td><%=o.getName() %></td>
						<td><%=o.getCategory() %></td>
						<td><%=o.getQuantity() %></td>
						<td>$ <%=o.getPrice() %></td>
						<td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%=o.getOrderId()%>">Cancelar Orden</a></td>
					</tr>
				<%}
			}
			%>
			
			</tbody>
		</table>
	</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>