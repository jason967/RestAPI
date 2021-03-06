package com.ssafy.mapper;

/**
 * 페이징 처리하는 컨트롤러
 * @author choi
 * 
 */
public class PageCriteria {

	private int pageNum;
	private int amount;

	public PageCriteria() {
		this(1, 10);
	}

	public PageCriteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "PageCriteria [pageNum=" + pageNum + ", amount=" + amount + "]";
	}

}
