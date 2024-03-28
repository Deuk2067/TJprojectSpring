package com.tjoeun.Tjproject.VO;

import java.util.Date;

public class MainCommentVO {
	private int idx;
	private String name;
	private String content;
	private Date writeDate;
	private int gup;
	private String deleted;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	@Override
	public String toString() {
		return "MainCommentVO [idx=" + idx + ", name=" + name + ", content=" + content + ", writeDate=" + writeDate
				+ ", gup=" + gup + ", deleted=" + deleted + "]";
	}
	
}
