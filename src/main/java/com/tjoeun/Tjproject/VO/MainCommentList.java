package com.tjoeun.Tjproject.VO;
import java.util.ArrayList;

public class MainCommentList {
	private ArrayList<MainCommentVO> list = new ArrayList<MainCommentVO>();

	public ArrayList<MainCommentVO> getList() {
		return list;
	}
	public void setList(ArrayList<MainCommentVO> list) {
		this.list = list;
	}
	
	@Override
	public String toString() {
		return "MainCommentList [list=" + list + "]";
	}
}
