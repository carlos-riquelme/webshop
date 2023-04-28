<%@page import="cn.shopping.connection.DbCon"%>
<%@page import="cn.shopping.model.*"%>
<%@page import="cn.shopping.dbob.ProductDaob"%>
<%@page import="cn.shopping.model.Product"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
UserModel auth = (UserModel) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ProductDaob pd = new ProductDaob(DbCon.getConnection());
List<Product> products = pd.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>

<title>Eva2</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-3">Todos los productos</div>
		<div class="row">
		<%
			if( !products.isEmpty()){
				for (Product p:products){%>
					<div class="col-md-3 my-3">
					<div class="card w-100" style="width: 18rem;">
						<img src="product-image/<%= p.getImage() %>" class="card-img-top" alt="product">
						<div class="card-body">
							<h5 class="card-title"><%= p.getName() %></h5>
							<h6 class="price">Precio: $<%= p.getPrice() %></h6>
							<h6 class="category">Categoría: <%= p.getCategory() %></h6>
							<div class="mt-3 d-flex justify-content-between">
							<a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-dark">Añadir al carro</a>
							<a href="#" class="btn btn-primary">Comprar ahora</a>
							</div>
						</div>
					</div>
				</div>
				<%}
			}
		%>
			
		</div>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>