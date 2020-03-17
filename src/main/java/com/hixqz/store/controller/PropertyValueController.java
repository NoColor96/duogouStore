package com.hixqz.store.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.Property;
import com.hixqz.store.pojo.PropertyValue;
import com.hixqz.store.service.ProductService;
import com.hixqz.store.service.PropertyService;
import com.hixqz.store.service.PropertyValueService;

@Controller
@RequestMapping("admin/categorys/{cid}/products/{pid}/propertyValues")
public class PropertyValueController extends BaseBackController{
	@Autowired
	PropertyValueService propertyValueService;
	@Autowired
	ProductService	productService;
	@Autowired
	PropertyService	propertyService;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(@PathVariable int pid,@PathVariable int cid) {
		ModelAndView mav = new ModelAndView();
		List<Property> properties = propertyValueService.listFillProperty(pid,cid);
		Product product = productService.get(pid);
		//mav.addObject("pvs", propertyValues);
		mav.addObject("p", product);
		mav.addObject("properties", properties);
		mav.setViewName("admin/editPropertyValue");
		return mav;
	}
	@ResponseBody
	@RequestMapping(value = "",method = RequestMethod.POST)
	public String add(PropertyValue propertyValue,Integer ptid) {
		propertyValue.setProperty(propertyService.get(ptid));
		System.out.println(propertyValue.getId());
		propertyValueService.add(propertyValue);
		System.out.println(propertyValue.getId());
		return ""+propertyValue.getId(); 
	}
	@ResponseBody
	@RequestMapping(value = "",method = RequestMethod.PUT)
	public String update(@RequestBody PropertyValue propertyValue){
		System.out.println(propertyValue.getValue()+","+propertyValue.getId());
		propertyValueService.update(propertyValue);
		return JSONObject.toJSONString(propertyValue);
	}
	@ResponseBody
	@RequestMapping(value = "{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int id) {
		propertyValueService.delete(id);
		return "success";
	}
}
