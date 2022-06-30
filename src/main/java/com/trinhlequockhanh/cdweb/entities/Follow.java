package com.trinhlequockhanh.cdweb.entities;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "follow")
public class Follow {
	@Id
	private String id;
	private String iduser;
	private String idfollower;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIduser() {
		return iduser;
	}

	public void setIduser(String iduser) {
		this.iduser = iduser;
	}

	public String getIdfollower() {
		return idfollower;
	}

	public void setIdfollower(String idfollower) {
		this.idfollower = idfollower;
	}

	@Override
	public String toString() {
		return "Follow [id=" + id + ", iduser=" + iduser + ", idfollower=" + idfollower + "]";
	}

}