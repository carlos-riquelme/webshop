package cn.shopping.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import cn.shopping.model.*;
import cn.shopping.connection.DbCon;
import cn.shopping.dbob.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OrderNowServlet
 */
@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public OrderNowServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try(PrintWriter out = response.getWriter()){
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			
			Date date = new Date();
			
			
			UserModel auth = (UserModel) request.getSession().getAttribute("auth");
			if(auth != null ) {
				
				String productId = request.getParameter("id");
				int productCantidad = Integer.parseInt(request.getParameter("cantidad"));
				if(productCantidad <= 0) {
					productCantidad = 1;
				}
				
				Order order = new Order();
				order.setId(Integer.parseInt(productId));
				order.setUid(auth.getId());
				order.setQuantity(productCantidad);
				order.setDate(formatter.format(date));
				
				OrderDaob orderDaob;
				try {
					orderDaob = new OrderDaob(DbCon.getConnection());
					boolean result = orderDaob.insertOrder(order);
					
					if(result) {
						ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
						if(cart_list != null) {
							for(Cart c:cart_list) {
								if(c.getId()==Integer.parseInt(productId)) {
									cart_list.remove(cart_list.indexOf(c));
									break;
								}
							}
						}
						response.sendRedirect("orders.jsp");
					} else {
						out.print("order failed");
					}
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			} else {
				response.sendRedirect("login.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
