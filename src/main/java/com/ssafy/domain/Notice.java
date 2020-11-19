package com.ssafy.domain;

public class Notice {

	private String idx;
	private String title;
	private String content;
	private String watch;

	public Notice() {
	}

	public Notice(String idx, String title, String content, String watch) {
		super();
		this.idx = idx;
		this.title = title;
		this.content = content;
		this.watch = watch;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWatch() {
		return watch;
	}

	public void setWatch(String watch) {
		this.watch = watch;
	}
}
