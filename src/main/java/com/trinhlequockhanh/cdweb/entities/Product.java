package com.trinhlequockhanh.cdweb.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product")
public class Product {
	@Id
	private String id;
	private String idshop, name;
	private int total;
	private String description, type, made_in, idimg, kind, brand, color, size;
	private boolean male;
	private double cost;
	private Date date_add;
	private int views;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdshop() {
		return idshop;
	}

	public void setIdshop(String idshop) {
		this.idshop = idshop;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMade_in() {
		return made_in;
	}

	public void setMade_in(String made_in) {
		this.made_in = made_in;
	}

	public String getIdimg() {
		return idimg;
	}

	public void setIdimg(String idimg) {
		this.idimg = idimg;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public boolean isMale() {
		return male;
	}

	public void setMale(boolean male) {
		this.male = male;
	}

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	public Date getDate_add() {
		return date_add;
	}

	public void setDate_add(Date date_add) {
		this.date_add = date_add;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", idshop=" + idshop + ", name=" + name + ", total=" + total + ", description="
				+ description + ", type=" + type + ", made_in=" + made_in + ", idimg=" + idimg + ", kind=" + kind
				+ ", brand=" + brand + ", color=" + color + ", size=" + size + ", male=" + male + ", cost=" + cost
				+ ", date_add=" + date_add + ", views=" + views + "]";
	}

}
