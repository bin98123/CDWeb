package com.trinhlequockhanh.cdweb.model;

public enum Sort {
	BY_COST_G, BY_COST_L, BY_SALE_G, BY_SALE_L;
	@Override
	public String toString() {
		switch (this) {
		case BY_COST_G:
			return "Giá tăng dần";
		case BY_COST_L:
			return "Giá giảm dần";
		case BY_SALE_G:
			return "Lượt mua tăng dần";
		case BY_SALE_L:
			return "Lượt mua giảm dần";
		}
		return super.toString();

	}
}
