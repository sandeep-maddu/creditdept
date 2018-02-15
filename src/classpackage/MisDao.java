package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class MisDao {

	private Connection conn=null;
	
	public MisDao() throws SQLException {
		
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
}

	public List<Mis> get_all_mis() throws Exception {
		List<Mis> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from mis order by aid");
			while (rs.next()) {
				
				Mis tempMis = convertRowToMis(rs);
				list.add(tempMis);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Mis get_a_mis(int aid) throws Exception {
			
			Mis tempMis=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from mis where aid= ? ");
				stmt.setInt(1, aid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					
					tempMis = convertRowToMis(rs);
					
				}
				return tempMis;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		
	
	public void add_mis(Mis mis) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into mis (aid,takeover,restructured,cgtmse,pmegp,corporate_loan,foreign_currency_loan,export_credit_limit,pledge_shares,msme_category,composite_loan,forward_contract,buyers_credit,food_processing,sick_unit,rbi_divergent,critical_account,trader,retail_credit_category,sod_category,lc_devolvements,bg_invocations,rent_receivables,rice_mill,commercial_real_estate,hotel,educational_institution,public_sector_psu,credit_card_receivables,imp_customer) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setInt(1, mis.getAid());
			stmt.setString(2,mis.getTakeover());
			stmt.setString(3,mis.getRestructured());
			stmt.setString(4,mis.getCgtmse());
			stmt.setString(5,mis.getPmegp());
			stmt.setString(6,mis.getCorporate_loan());
			stmt.setString(7,mis.getForeign_currency_loan());
			stmt.setString(8,mis.getExport_credit_limit());
			stmt.setString(9,mis.getPledge_shares());
			stmt.setString(10,mis.getMsme_category());
			stmt.setString(11,mis.getComposite_loan());
			stmt.setString(12,mis.getForward_contract());
			stmt.setString(13,mis.getBuyers_credit());
			stmt.setString(14,mis.getFood_processing());
			stmt.setString(15,mis.getSick_unit());
			stmt.setString(16,mis.getRbi_divergent());
			stmt.setString(17,mis.getCritical_account());
			stmt.setString(18,mis.getTrader());
			stmt.setString(19,mis.getRetail_credit_category());
			stmt.setString(20,mis.getSod_category());
			stmt.setString(21,mis.getLc_devolvements());
			stmt.setString(22,mis.getBg_invocations());
			stmt.setString(23,mis.getRent_receivables());
			stmt.setString(24,mis.getRice_mill());
			stmt.setString(25,mis.getCommercial_real_estate());
			stmt.setString(26,mis.getHotel());
			stmt.setString(27,mis.getEducational_institution());
			stmt.setString(28,mis.getPublic_sector_psu());
			stmt.setString(29,mis.getCredit_card_receivables());
			stmt.setString(30,mis.getImp_customer());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}





	public void delete_mis(int aid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from mis where aid=?");
			stmt.setInt(1, aid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_mis(Mis mis) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update mis set aid=?,takeover=?,restructured=?,cgtmse=?,pmegp=?,corporate_loan=?,foreign_currency_loan=?,export_credit_limit=?,pledge_shares=?,msme_category=?,composite_loan=?,forward_contract=?,buyers_credit=?,food_processing=?,sick_unit=?,rbi_divergent=?,critical_account=?,trader=?,retail_credit_category=?,sod_category=?,lc_devolvements=?,bg_invocations=?,rent_receivables=?,rice_mill=?,commercial_real_estate=?,hotel=?,educational_institution=?,public_sector_psu=?,credit_card_receivables=?,imp_customer=? where aid=?");
			stmt.setInt(1, mis.getAid());
			stmt.setString(2,mis.getTakeover());
			stmt.setString(3,mis.getRestructured());
			stmt.setString(4,mis.getCgtmse());
			stmt.setString(5,mis.getPmegp());
			stmt.setString(6,mis.getCorporate_loan());
			stmt.setString(7,mis.getForeign_currency_loan());
			stmt.setString(8,mis.getExport_credit_limit());
			stmt.setString(9,mis.getPledge_shares());
			stmt.setString(10,mis.getMsme_category());
			stmt.setString(11,mis.getComposite_loan());
			stmt.setString(12,mis.getForward_contract());
			stmt.setString(13,mis.getBuyers_credit());
			stmt.setString(14,mis.getFood_processing());
			stmt.setString(15,mis.getSick_unit());
			stmt.setString(16,mis.getRbi_divergent());
			stmt.setString(17,mis.getCritical_account());
			stmt.setString(18,mis.getTrader());
			stmt.setString(19,mis.getRetail_credit_category());
			stmt.setString(20,mis.getSod_category());
			stmt.setString(21,mis.getLc_devolvements());
			stmt.setString(22,mis.getBg_invocations());
			stmt.setString(23,mis.getRent_receivables());
			stmt.setString(24,mis.getRice_mill());
			stmt.setString(25,mis.getCommercial_real_estate());
			stmt.setString(26,mis.getHotel());
			stmt.setString(27,mis.getEducational_institution());
			stmt.setString(28,mis.getPublic_sector_psu());
			stmt.setString(29,mis.getCredit_card_receivables());
			stmt.setString(30,mis.getImp_customer());
			stmt.setInt(31, mis.getAid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}



	private Mis convertRowToMis(ResultSet rs) throws SQLException {
			
		int aid=rs.getInt("aid");	
		String takeover = rs.getString("takeover");
		String restructured = rs.getString("restructured");
		String cgtmse = rs.getString("cgtmse");
		String pmegp = rs.getString("pmegp");
		String corporate_loan = rs.getString("corporate_loan");
		String foreign_currency_loan = rs.getString("foreign_currency_loan");
		String export_credit_limit = rs.getString("export_credit_limit");
		String pledge_shares = rs.getString("pledge_shares");
		String msme_category = rs.getString("msme_category");
		String composite_loan = rs.getString("composite_loan");
		String forward_contract = rs.getString("forward_contract");
		String buyers_credit = rs.getString("buyers_credit");
		String food_processing = rs.getString("food_processing");
		String sick_unit = rs.getString("sick_unit");
		String rbi_divergent = rs.getString("rbi_divergent");
		String critical_account = rs.getString("critical_account");
		String trader = rs.getString("trader");
		String retail_credit_category = rs.getString("retail_credit_category");
		String sod_category = rs.getString("sod_category");
		String lc_devolvements = rs.getString("lc_devolvements");
		String bg_invocations = rs.getString("bg_invocations");
		String rent_receivables = rs.getString("rent_receivables");
		String rice_mill = rs.getString("rice_mill");
		String commercial_real_estate = rs.getString("commercial_real_estate");
		String hotel = rs.getString("hotel");
		String educational_institution = rs.getString("educational_institution");
		String public_sector_psu = rs.getString("public_sector_psu");
		String credit_card_receivables = rs.getString("credit_card_receivables");
		String imp_customer = rs.getString("imp_customer");
			

			Mis tempMis = new Mis(aid,takeover,restructured,cgtmse,pmegp,corporate_loan,foreign_currency_loan,export_credit_limit,pledge_shares,msme_category,composite_loan,forward_contract,buyers_credit,food_processing,sick_unit,rbi_divergent,critical_account,trader,retail_credit_category,sod_category,lc_devolvements,bg_invocations,rent_receivables,rice_mill,commercial_real_estate,hotel,educational_institution,public_sector_psu,credit_card_receivables,imp_customer);
			
			return tempMis;
		}
}
