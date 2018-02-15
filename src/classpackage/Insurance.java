package classpackage;
import java.util.Date;

public class Insurance {
	
	private int aid;
	private String policyid,agency;
	private float sum_assured;
	private Date policy_duedate;
	
	public Insurance() {
	    super();
	}

	public Insurance(String policyid, String agency, float sum_assured, Date policy_duedate,int aid) {
		this.aid = aid;
		this.policyid = policyid;
		this.agency = agency;
		this.sum_assured = sum_assured;
		this.policy_duedate = policy_duedate;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getPolicyid() {
		return policyid;
	}

	public void setPolicyid(String policyid) {
		this.policyid = policyid;
	}

	public String getAgency() {
		return agency;
	}

	public void setAgency(String agency) {
		this.agency = agency;
	}

	public float getSum_assured() {
		return sum_assured;
	}

	public void setSum_assured(float sum_assured) {
		this.sum_assured = sum_assured;
	}

	public Date getPolicy_duedate() {
		return policy_duedate;
	}

	public void setPolicy_duedate(Date policy_duedate) {
		this.policy_duedate = policy_duedate;
	}

	}
