package cn.shopping.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import cn.shopping.connection.DbCon;
import cn.shopping.model.*;
import cn.shopping.dbob.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try (PrintWriter out = response.getWriter()){
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			
			Date date = new Date();
			
			//Trae todos los productos del carro
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			UserModel auth = (UserModel) request.getSession().getAttribute("auth");
			if(cart_list != null && auth != null) {
				for(Cart c:cart_list) {
					Order order = new Order();
					order.setId(c.getId());
					order.setUid(auth.getId());
					order.setQuantity(c.getCantidad());
					order.setDate(formatter.format(date));
					
					OrderDaob orderdaob = new OrderDaob(DbCon.getConnection());
					boolean result = orderdaob.insertOrder(order);
					
					if(!result) break;
				}
				
				cart_list.clear();
				response.sendRedirect("orders.jsp");
			} else {
				if(auth == null) response.sendRedirect("login.jsp");
				response.sendRedirect("cart.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
