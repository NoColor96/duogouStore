package com.hixqz.store.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.pojo.Property;
import com.hixqz.store.service.CategoryService;
import com.hixqz.store.service.PropertyService;

@Controller
@RequestMapping("admin/categorys/{cid}/properties")
public class PropertyController extends BaseBackController{
	@Autowired
	PropertyService propertyService;
	@Autowired
	CategoryService categoryService;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(@PathVariable int cid,Page page) {
		ModelAndView mav = new ModelAndView();
		List<Property> properties = propertyService.list(cid,page);
		mav.addObject("cid",cid);
		mav.addObject("properties", properties);
		mav.setViewName("admin/listProperty");
		return mav;
	}
	@RequestMapping(value = "",method = RequestMethod.POST)
	public String add(Property property,Page page) {
		propertyService.add(property);
		//添加成功后跳转到最后一页
		int total = propertyService.getTotal(property.getCid());
		page.setTotal(total);
		return "redirect:./properties?start="+page.getLast();
	}
	@RequestMapping(value = "{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int id,Page page) {
		propertyService.delete(id);
		return "redirect:../properties?start="+page.getStart();
	}
	@RequestMapping(value = "{id}",method = RequestMethod.GET)
	public ModelAndView edit(@PathVariable int id) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/editProperty");
		mav.addObject("p",propertyService.get(id));
		return mav;
	}
	@RequestMapping(value = "",method = RequestMethod.PUT)
	public String update(Property property) {
		propertyService.update(property);
		return "redirect:properties";
	}
}
