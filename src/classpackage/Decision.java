package classpackage;

import java.util.Date;

public class Decision {

	private int did,approving_authority,review_authority,aid;
	private String letter_ref;
	private Date decision_date,received_on;
	
	public Decision() {
	    super();
	}
	
	public Decision(int did,Date decision_date,int approving_authority,int aid,String letter_ref,Date received_on,int review_authority) {
		this.did=did;
		this.decision_date=decision_date;
		this.approving_authority=approving_authority;
		this.aid=aid;
		this.letter_ref=letter_ref;
		this.received_on=received_on;
		this.review_authority=review_authority;
		}

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public int getApproving_authority() {
		return approving_authority;
	}

	public void setApproving_authority(int approving_authority) {
		this.approving_authority = approving_authority;
	}

	public int getReview_authority() {
		return review_authority;
	}

	public void setReview_authority(int review_authority) {
		this.review_authority = review_authority;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getLetter_ref() {
		return letter_ref;
	}

	public void setLetter_ref(String letter_ref) {
		this.letter_ref = letter_ref;
	}

	public Date getDecision_date() {
		return decision_date;
	}

	public void setDecision_date(Date decision_date) {
		this.decision_date = decision_date;
	}

	public Date getReceived_on() {
		return received_on;
	}

	public void setReceived_on(Date received_on) {
		this.received_on = received_on;
	}

	}
