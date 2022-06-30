package com.trinhlequockhanh.cdweb.entities;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "img")
public class Img {
	@Id
	private String id;
	private String idimg;
	private String idproduct;
	private String srcimg;

	public String getIdimg() {
		return idimg;
	}

	public void setIdimg(String idimg) {
		this.idimg = idimg;
	}

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

	public String getSrcimg() {
		return srcimg;
	}

	public void setSrcimg(String srcimg) {
		this.srcimg = srcimg;
	}

	@Override
	public String toString() {
		return "Img [id=" + id + ", idimg=" + idimg + ", idproduct=" + idproduct + ", srcimg=" + srcimg + "]";
	}

}
