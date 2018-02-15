package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class RatingDao {

	private Connection conn=null;
	
	public RatingDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Rating> get_all_ratings() throws Exception {
	List<Rating> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from rating order by aid,rid");
		while (rs.next()) {
			Rating tempRating = convertRowToRating(rs);
			list.add(tempRating);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Rating get_a_rating(int rid) throws Exception {
		
		Rating tempRating=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from rating where rid= ? ");
			stmt.setInt(1, rid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempRating = convertRowToRating(rs);
				
			}
			return tempRating;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_rating(Rating rating) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into rating (rid,agency,facility_name,rating,rating_model,description, basedon_financials, basedon_audited,due_date,aid) values (rating_seq.nextval,?,?,?,?,?,?,?,?,?)");
			stmt.setString(1, rating.getAgency());
			stmt.setString(2, rating.getFacility_name());
			stmt.setString(3, rating.getRating());
			stmt.setString(4, rating.getRating_model());
			stmt.setString(5, rating.getDescription());
			stmt.setDate(6, new java.sql.Date(rating.getBasedon_financials().getTime()));
			stmt.setString(7, rating.getBasedon_audited());
			stmt.setDate(8, new java.sql.Date(rating.getDue_date().getTime()));
			stmt.setInt(9, rating.getAid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_rating(int rid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from rating where rid=?");
			stmt.setInt(1, rid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_rating(Rating rating) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update rating set rid=?,agency=?,facility_name=?,rating=?,rating_model=?,description=?, basedon_financials=?, basedon_audited=?,due_date=?,aid=? where rid=?");
			stmt.setInt(1, rating.getRid());
			stmt.setString(2, rating.getAgency());
			stmt.setString(3, rating.getFacility_name());
			stmt.setString(4, rating.getRating());
			stmt.setString(5, rating.getRating_model());
			stmt.setString(6, rating.getDescription());
			stmt.setDate(7, new java.sql.Date(rating.getBasedon_financials().getTime()));
			stmt.setString(8, rating.getBasedon_audited());
			stmt.setDate(9, new java.sql.Date(rating.getDue_date().getTime()));
			stmt.setInt(10, rating.getAid());
			stmt.setInt(11, rating.getRid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Rating convertRowToRating(ResultSet rs) throws SQLException {
		
		int rid = rs.getInt("rid");
		String agency = rs.getString("agency");
		String facility_name = rs.getString("facility_name");
		String rating = rs.getString("rating");
		String rating_model = rs.getString("rating_model");
		String description = rs.getString("description");
		Date basedon_financials=rs.getDate("basedon_financials");
		String basedon_audited = rs.getString("basedon_audited");
		Date due_date=rs.getDate("due_date");
		int aid = rs.getInt("aid");
				
		Rating tempRating = new Rating(rid,agency,facility_name,rating,rating_model,description, basedon_financials, basedon_audited,due_date,aid);
				return tempRating;
	}

}
