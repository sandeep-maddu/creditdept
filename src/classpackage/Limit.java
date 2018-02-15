package classpackage;
import java.util.Date;

public class Limit {
	
	private int lid,aid,nfb_period;
	private float limit,dp,fb_roi_pct,spread_pct,term_premium,nfb_fee_pct;
	private String facility_name,sub_name,cbs_no,sanction_ref,sub_limit,branch,roc_status,basis,finer,sight_or_usance;
	private Date sanction_date,due_date;
	
	public Limit() {
	    super();
	}

	public Limit(int lid, int aid, String facility_name, String sub_name,float limit,String cbs_no,String sanction_ref,Date sanction_date,Date due_date,String sub_limit,String branch,float dp,String roc_status,float fb_roi_pct,String basis,float spread_pct, float term_premium,String finer,float nfb_fee_pct,String sight_or_usance,int nfb_period) {
		this.lid = lid;
		this.aid = aid;
		this.cbs_no = cbs_no;
		this.nfb_period = nfb_period;
		this.limit = limit;
		this.dp = dp;
		this.fb_roi_pct = fb_roi_pct;
		this.spread_pct = spread_pct;
		this.term_premium = term_premium;
		this.nfb_fee_pct = nfb_fee_pct;
		this.facility_name = facility_name;
		this.sub_name = sub_name;
		this.sanction_ref = sanction_ref;
		this.sub_limit = sub_limit;
		this.branch = branch;
		this.roc_status = roc_status;
		this.basis = basis;
		this.finer = finer;
		this.sight_or_usance = sight_or_usance;
		this.sanction_date = sanction_date;
		this.due_date = due_date;
	}

	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getCbs_no() {
		return cbs_no;
	}

	public void setCbs_no(String cbs_no) {
		this.cbs_no = cbs_no;
	}

	public int getNfb_period() {
		return nfb_period;
	}

	public void setNfb_period(int nfb_period) {
		this.nfb_period = nfb_period;
	}

	public float getLimit() {
		return limit;
	}

	public void setLimit(float limit) {
		this.limit = limit;
	}

	public float getDp() {
		return dp;
	}

	public void setDp(float dp) {
		this.dp = dp;
	}

	public float getFb_roi_pct() {
		return fb_roi_pct;
	}

	public void setFb_roi_pct(float fb_roi_pct) {
		this.fb_roi_pct = fb_roi_pct;
	}

	public float getSpread_pct() {
		return spread_pct;
	}

	public void setSpread_pct(float spread_pct) {
		this.spread_pct = spread_pct;
	}

	public float getTerm_premium() {
		return term_premium;
	}

	public void setTerm_premium(float term_premium) {
		this.term_premium = term_premium;
	}

	public float getNfb_fee_pct() {
		return nfb_fee_pct;
	}

	public void setNfb_fee_pct(float nfb_fee_pct) {
		this.nfb_fee_pct = nfb_fee_pct;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getSub_name() {
		return sub_name;
	}

	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}

	public String getSanction_ref() {
		return sanction_ref;
	}

	public void setSanction_ref(String sanction_ref) {
		this.sanction_ref = sanction_ref;
	}

	public String getSub_limit() {
		return sub_limit;
	}

	public void setSub_limit(String sub_limit) {
		this.sub_limit = sub_limit;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getRoc_status() {
		return roc_status;
	}

	public void setRoc_status(String roc_status) {
		this.roc_status = roc_status;
	}

	public String getBasis() {
		return basis;
	}

	public void setBasis(String basis) {
		this.basis = basis;
	}

	public String getFiner() {
		return finer;
	}

	public void setFiner(String finer) {
		this.finer = finer;
	}

	public String getSight_or_usance() {
		return sight_or_usance;
	}

	public void setSight_or_usance(String sight_or_usance) {
		this.sight_or_usance = sight_or_usance;
	}

	public Date getSanction_date() {
		return sanction_date;
	}

	public void setSanction_date(Date sanction_date) {
		this.sanction_date = sanction_date;
	}

	public Date getDue_date() {
		return due_date;
	}

	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}

	}
