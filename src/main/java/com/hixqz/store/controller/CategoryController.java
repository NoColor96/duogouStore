package com.hixqz.store.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.mapper.PropertyMapper;
import com.hixqz.store.pojo.Category;
import com.hixqz.store.service.CategoryService;
@Controller
@RequestMapping("admin/categorys")
public class CategoryController extends BaseBackController{
	@Autowired
	CategoryService categoryService;
	@Autowired
	PropertyMapper propertyMapper;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(Page page) {
		ModelAndView mav = new ModelAndView();
		List<Category> categories = categoryService.listByPage(page);
		mav.addObject("cs",categories);
		mav.setViewName("admin/listCategory");
		return mav;
	}
	@RequestMapping(value = "",method = RequestMethod.POST)
	public String add(HttpServletRequest request,@RequestParam(value = "imageFile") MultipartFile imageFile,Category category,Page page) {
		categoryService.add(category,imageFile,request.getServletContext().getRealPath("img/category"));
		//跳转到最后一页
		page.setTotal(categoryService.getTotal());
		return "redirect:categorys?start="+page.getLast();
	}
	@RequestMapping(value = "{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int id,Page page,HttpServletRequest request) {
		//删除属性
		propertyMapper.deleteByCid(id);
		categoryService.delete(id, request.getServletContext().getRealPath("img/category"));
		return "redirect:../categorys?start="+page.getStart();
	}
	@RequestMapping(value = "{id}",method = RequestMethod.GET)
	public ModelAndView edit(@PathVariable int id) {
		ModelAndView mav = new ModelAndView();
		Category category = categoryService.getPure(id);
		mav.setViewName("admin/editCategory"); 
		mav.addObject("c",category);
		return mav;
	}
	@RequestMapping(value = "",method = RequestMethod.PUT)
	public String update(HttpServletRequest request,@RequestParam(value = "imageFile") MultipartFile imageFile,Category category) {
		categoryService.update(category, imageFile, request.getServletContext().getRealPath("img/category"));
		return "redirect:categorys"; 
	} 
}


