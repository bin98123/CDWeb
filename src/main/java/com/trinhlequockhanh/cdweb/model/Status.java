package com.trinhlequockhanh.cdweb.model;

public enum Status {
	WAITING_ORDER,WAITING_CONFIRM, WAITING_DELIVERING, CANCEL, DELIVERIED;
	@Override
	public String toString() {
		switch (this) {
		case WAITING_ORDER:
			return "CÒN TRONG GIỎ HÀNG";
		case WAITING_CONFIRM:
			return "CHỜ XÁC NHẬN";
		case WAITING_DELIVERING:
			return "CHỜ NHẬN HÀNG";
		case CANCEL:
			return "ĐÃ HỦY";
		case DELIVERIED:
			return "ĐÃ NHẬN";
		}

		return super.toString();

	}
}
