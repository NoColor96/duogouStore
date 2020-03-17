package com.hixqz.store.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Category;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.service.CategoryService;
import com.hixqz.store.service.ProductImageService;
import com.hixqz.store.service.ProductService;
import com.hixqz.store.service.PropertyValueService;

@Controller
@RequestMapping("admin/categorys/{cid}/products")
public class ProductController extends BaseBackController{
	@Autowired
	ProductService productService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	PropertyValueService propertyValueService;
	@Autowired
	ProductImageService productImageService;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(@PathVariable int cid,Page page) {
		ModelAndView mav = new ModelAndView();
		List<Product> products = productService.listByPage(cid, page);
		mav.addObject("products", products);
		mav.setViewName("admin/listProduct");
		return mav;
	}
	@RequestMapping(value = "",method = RequestMethod.POST)
	public String add(Product product,@PathVariable int cid,Page page) {
		Category category = categoryService.getPure(cid);
		product.setCategory(category);
		product.setCreateDate(new Date());
		productService.add(product);
		page.setTotal(productService.getTotal(cid));
		return "redirect:products?start="+page.getLast();
	}
	@RequestMapping(value = "{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int id,Page page) {
		productImageService.deleteByPid(id);
		productService.delete(id);
		propertyValueService.deleteByPid(id);
		return "redirect:../products?start="+page.getStart();
	}
	@RequestMapping(value = "{id}",method = RequestMethod.GET)
	public ModelAndView get(@PathVariable int id) {
		ModelAndView mav = new ModelAndView();
		Product product = productService.get(id);
		mav.addObject("p", product);
		mav.setViewName("admin/editProduct");
		return mav;
	}
	@RequestMapping(value = "{id}",method = RequestMethod.PUT)
	public String update(Product product) {
		productService.update(product);
		return "redirect:../products";
	}
}
