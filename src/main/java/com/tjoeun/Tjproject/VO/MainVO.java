package com.tjoeun.Tjproject.VO;

import java.sql.Date;

public class MainVO {
	private int idx;
	private String subject;
	private String content;
	private int hit;
	private int good;
	private Date writeDate;
	private int gup;
	private String category;
	private String id;
	private String deleted;
	
	public MainVO() { }

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public int getGup() {
		return gup;
	}
	public void setGup(int gup) {
		this.gup = gup;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "MainVO [idx=" + idx + ", subject=" + subject + ", content=" + content + ", hit=" + hit + ", good="
				+ good + ", writeDate=" + writeDate + ", gup=" + gup + ", category=" + category + ", id=" + id
				+ ", deleted=" + deleted + "]";
	}
	
}