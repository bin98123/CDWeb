package com.trinhlequockhanh.cdweb.model;

public enum Filter {
	BRAND, COST, TYPE, KIND;
	@Override
	public String toString() {
		switch (this) {
		case BRAND:
			return "Thương hiệu";
		case COST:
			return "Giá";
		case TYPE:
			return "Loại";
		case KIND:
			return "Độ tuổi";
		}
		return super.toString();

	}
}
