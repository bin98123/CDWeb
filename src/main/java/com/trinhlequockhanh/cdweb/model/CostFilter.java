package com.trinhlequockhanh.cdweb.model;

public enum CostFilter {
	L, AVG, G;
	@Override
	public String toString() {
		switch (this) {
		case L:
			return "Dưới 50.000đ";
		case AVG:
			return "50.000đ-100.000đ";
		case G:
			return "Trên 100.000đ";
		}
		return super.toString();

	}
}
