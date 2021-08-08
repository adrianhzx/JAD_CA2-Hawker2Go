package model;

public class ProductSearch {
	
	private String CategoryName;
	private int CategoryId;

	/*
	public ProductSearch(String CategoryName, int CategoryId) {
		// TODO Auto-generated constructor stub
		this.CategoryName = CategoryName;
		this.CategoryId = CategoryId;
	}*/

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	public int getCategoryId() {
		return CategoryId;
	}

	public void setCategoryId(int categoryId) {
		CategoryId = categoryId;
	}

	

}
