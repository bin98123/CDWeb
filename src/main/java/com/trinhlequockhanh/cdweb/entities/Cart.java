package com.trinhlequockhanh.cdweb.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cart")
public class Cart {
	@Id
	private String id;
	private String idproduct;
	private String iduser;
	private int total;
	private String status;
	private Date orderdate;
	private Date delivereddate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdproduct() {
		return idproduct;
	}

	public void setIdproduct(String idproduct) {
		this.idproduct = idproduct;
	}

	public String getIduser() {
		return iduser;
	}

	public void setIduser(String iduser) {
		this.iduser = iduser;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public Date getDelivereddate() {
		return delivereddate;
	}

	public void setDelivereddate(Date delivereddate) {
		this.delivereddate = delivereddate;
	}


}
