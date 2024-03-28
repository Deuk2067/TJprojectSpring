package com.tjoeun.Tjproject.VO;

public class MemberVO {

	private String id;
	private String pw;
	private String name;
	private String nick;
	private String email;

	public MemberVO() {
		
	}
	
	
	public MemberVO(String id, String pw) {
		super();
		this.id = id;
		this.pw = pw;
	}


	public MemberVO(String id, String pw, String name, String nick, String email) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nick = nick;
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", pw=" + pw + ", name=" + name + ", nick=" + nick + ", email=" + email + "]";
	}
	
}
