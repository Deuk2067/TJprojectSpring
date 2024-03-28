package com.tjoeun.Tjproject.VO;

public class Param {
	private int startNo;
	private int endNo;
	private String category;
	private String searchVal;
	private String searchTag;
	
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSearchVal() {
		return searchVal;
	}
	public void setSearchVal(String searchVal) {
		this.searchVal = searchVal;
	}
	public String getSearchTag() {
		return searchTag;
	}
	public void setSearchTag(String searchTag) {
		this.searchTag = searchTag;
	}
	
	@Override
	public String toString() {
		return "Param [startNo=" + startNo + ", endNo=" + endNo + ", category=" + category + ", searchVal=" + searchVal
				+ ", searchTag=" + searchTag + "]";
	}
	
	
}
