package classpackage;
import java.util.Date;

public class BankingArrangement {
	
	private int bid,aid,number_banks;
	private String facility_name,type,leader_bank,diligence_report,credit_information_exchange;
	private Date latest_consortium_meeting;
	
	public BankingArrangement() {
	    super();
	}

	public BankingArrangement(int bid, int aid, String facility_name, String type, int number_banks, String leader_bank, Date latest_consortium_meeting,String diligence_report, String credit_information_exchange) {
		this.bid = bid;
		this.aid = aid;
		this.number_banks = number_banks;
		this.facility_name = facility_name;
		this.type = type;
		this.leader_bank = leader_bank;
		this.diligence_report = diligence_report;
		this.credit_information_exchange = credit_information_exchange;
		this.latest_consortium_meeting = latest_consortium_meeting;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public int getNumber_banks() {
		return number_banks;
	}

	public void setNumber_banks(int number_banks) {
		this.number_banks = number_banks;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLeader_bank() {
		return leader_bank;
	}

	public void setLeader_bank(String leader_bank) {
		this.leader_bank = leader_bank;
	}

	public String getDiligence_report() {
		return diligence_report;
	}

	public void setDiligence_report(String diligence_report) {
		this.diligence_report = diligence_report;
	}

	public String getCredit_information_exchange() {
		return credit_information_exchange;
	}

	public void setCredit_information_exchange(String credit_information_exchange) {
		this.credit_information_exchange = credit_information_exchange;
	}

	public Date getLatest_consortium_meeting() {
		return latest_consortium_meeting;
	}

	public void setLatest_consortium_meeting(Date latest_consortium_meeting) {
		this.latest_consortium_meeting = latest_consortium_meeting;
	}

}
