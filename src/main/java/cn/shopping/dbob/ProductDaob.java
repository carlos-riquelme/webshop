package cn.shopping.dbob;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

import cn.shopping.model.Cart;
import cn.shopping.model.Product;

public class ProductDaob {
	
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	
	public ProductDaob(Connection con) {
		this.con = con;
	} 

	public List<Product> getAllProducts(){
		List<Product> products = new ArrayList<Product>();
		
		try {
			query = "SELECT * FROM PRODUCTS";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getInt("price"));
				row.setImage(rs.getString("image"));
				
				products.add(row);
			}
	} catch(Exception e) {
		e.printStackTrace();
	}
		
		return products;
	}
	
	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
		
		List<Cart> products = new ArrayList<Cart>();
		
		try {
			if(cartList.size()>0) {
				for(Cart item:cartList) {
					query = "Select * from products where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					
					while(rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setCategory(rs.getString("category"));
						row.setCantidad(item.getCantidad());
						row.setPrice(rs.getInt("price")*item.getCantidad());
						
						products.add(row);
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());

		}
		
		return products;
		
	}
	
	public int getTotalCartPrice(ArrayList<Cart> cartList) {
		int sum = 0;
		try {
			if(cartList.size()>0) {
				for(Cart item:cartList) {
					query = "Select price from products where id = ?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					
					while(rs.next()) {
						sum+=rs.getInt("price")*item.getCantidad();
					}
				}
			}
			
		} catch (Exception e) {
			
		}
		
		return sum;
	}
}
