<%@page import="cn.shopping.connection.DbCon"%>
<%@page import="cn.shopping.model.*"%>
<%@page import="cn.shopping.dbob.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%

DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

UserModel auth = (UserModel) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDaob pDaob = new ProductDaob(DbCon.getConnection());
	cartProduct = pDaob.getCartProducts(cart_list);
	int total = pDaob.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>
<!DOCTYPE html>
<html>
<head>

<title>Carro</title>
<%@include file="includes/header.jsp"%>
<style type="text/css">
.table td tbody {
	vertical-align: middle;
}

.btn-incre, .btn-decre {
	box-shadow: none;
	font-size: 25px;
}
</style>

</head>
<body>
	<%@include file="includes/navbar.jsp"%>"
	<div class="container">
		<div class="d-flex py-3">
			<h3>Total $ ${ (total>0)?dcf.format(total):0 }</h3>
			<a class="mx-3 btn btn-primary" href="#">Pagar</a>


		</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Nombre</th>
					<th scope="col">Categoría</th>
					<th scope="col">Precio</th>
					<th scope="col">Comprar ahora</th>
					<th scope="col">Cancelar</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (cart_list != null) {
					for (Cart c:cartProduct) {
				%>
				<tr>
					<td><%= c.getName() %></td>
					<td><%= c.getCategory() %></td>
					<td>$ <%= dcf.format(c.getPrice()) %></td>
					<td>
						<form action="" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
							<div class="d-flex justify-content-between">
								<a href="quantity-inc-dec?action=dec&id=<%= c.getId() %>" class="btn btn-sm btn-decre"><i
									class="fas fa-minus-square"></i></a> <input type="text"
									name="cantidad" class="form-control" value="<%= c.getCantidad() %>" readonly>
								<a href="quantity-inc-dec?action=inc&id=<%= c.getId() %>" class="btn btn-sm btn-incre"><i
									class="fas fa-plus-square"></i></a>
							</div>
						</form>
					</td>
					<td><a href="remove-from-cart?id=<%= c.getId() %>" class="btn btn-sm btn-danger">Quitar</a></td>
				</tr>
				<%
				}
				}
				%>

			</tbody>
		</table>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>