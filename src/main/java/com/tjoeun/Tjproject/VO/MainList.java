package com.tjoeun.Tjproject.VO;

import java.util.ArrayList;

public class MainList {

	private int currentPage = 1;
	private int startNo = 0;
	private int endNo = 0;  
	private int startPage = 0;
	private int endPage = 0; 
	private int totalCount = 0;
	private int totalPage = 0; 
	private int pageSize = 10;
	private ArrayList<MainVO> list = new ArrayList<MainVO>();
	
	
	public MainList() {}
	
	public void initMainList(int pageSize, int totalCount, int currentPage) {
		this.pageSize = pageSize;
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		calculator();
	}
	
	
	private void calculator() {
		totalPage = (totalCount - 1) / pageSize + 1;
		currentPage = currentPage > totalPage ? totalPage : currentPage;
		startNo = (currentPage - 1) * pageSize + 1;
		endNo = startNo + pageSize - 1;
		endNo = endNo > totalCount ? totalCount : endNo;
		startPage = (currentPage - 1) / 10 * 10 + 1;
		endPage = startPage + 9;
		endPage = endPage > totalPage ? totalPage : endPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
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
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public ArrayList<MainVO> getList() {
		return list;
	}
	public void setList(ArrayList<MainVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "MainList [currentPage=" + currentPage + ", startNo=" + startNo + ", endNo=" + endNo + ", startPage="
				+ startPage + ", endPage=" + endPage + ", totalCount=" + totalCount + ", totalPage=" + totalPage
				+ ", pageSize=" + pageSize + ", list=" + list + "]";
	}
}