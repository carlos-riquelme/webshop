<%@page import="cn.shopping.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<% 
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    if(auth != null){

    	response.sendRedirect("index.jsp");
    } 
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
    	request.setAttribute("cart_list", cart_list);
    }
    %>
<!DOCTYPE html>
<html>
<head>

<title>Login</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
<%@include file="includes/navbar.jsp" %>"
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Login</div>
			<div class="card-body">
				<form action="user-login" method="post">

					<div class="form-group">
						<label>Email</label> <input type="email" class="form-control"
							name="login-email" placeholder="Su correo" required></input>
					</div>

					<div class="form-group">
						<label>Contraseña</label> <input type="password"
							class="form-control" name="login-password" required></input>
					</div>

					<div class="from-group text-center my-2">
						<button type="submit" class="btn btn-primary">Ok</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>