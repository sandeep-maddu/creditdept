package classpackage;
import java.util.Date;

public class Account {
	
	private int aid,subdept,powers,concerned_officer;
	private String cust_id,account_name,file_no,asset_classf,constitution,chief_exec,close_status,activity_name;
	private Date incorp_date,dealing_since;
	
	public Account() {
	    super();
	}

	public Account(int aid,int subdept,int powers,int concerned_officer, String cust_id, String account_name, String file_no, String asset_classf,String constitution, String chief_exec,String close_status,String activity_name,Date incorp_date, Date dealing_since) {
		this.aid=aid;
		this.subdept=subdept;
		this.powers=powers;
		this.concerned_officer=concerned_officer;
		this.cust_id=cust_id;
		this.account_name=account_name;
		this.file_no=file_no;
		this.asset_classf=asset_classf;
		this.constitution=constitution;
		this.chief_exec=chief_exec;
		this.close_status=close_status;
		this.activity_name=activity_name;
		this.incorp_date=incorp_date;
		this.dealing_since=dealing_since;
		}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public int getSubdept() {
		return subdept;
	}

	public void setSubdept(int subdept) {
		this.subdept = subdept;
	}

	public int getPowers() {
		return powers;
	}

	public void setPowers(int powers) {
		this.powers = powers;
	}

	public int getConcerned_officer() {
		return concerned_officer;
	}

	public void setConcerned_officer(int concerned_officer) {
		this.concerned_officer = concerned_officer;
	}

	public String getCust_id() {
		return cust_id;
	}

	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}

	public String getAccount_name() {
		return account_name;
	}

	public void setAccount_name(String account_name) {
		this.account_name = account_name;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getAsset_classf() {
		return asset_classf;
	}

	public void setAsset_classf(String asset_classf) {
		this.asset_classf = asset_classf;
	}

	public String getConstitution() {
		return constitution;
	}

	public void setConstitution(String constitution) {
		this.constitution = constitution;
	}

	public String getChief_exec() {
		return chief_exec;
	}

	public void setChief_exec(String chief_exec) {
		this.chief_exec = chief_exec;
	}

	public String getClose_status() {
		return close_status;
	}

	public void setClose_status(String close_status) {
		this.close_status = close_status;
	}

	public String getActivity_name() {
		return activity_name;
	}

	public void setActivity_name(String activity_name) {
		this.activity_name = activity_name;
	}

	public Date getIncorp_date() {
		return incorp_date;
	}

	public void setIncorp_date(Date incorp_date) {
		this.incorp_date = incorp_date;
	}

	public Date getDealing_since() {
		return dealing_since;
	}

	public void setDealing_since(Date dealing_since) {
		this.dealing_since = dealing_since;
	}

}
