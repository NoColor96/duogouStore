package com.hixqz.store.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.ProductImage;
import com.hixqz.store.service.ProductImageService;
import com.hixqz.store.service.ProductService;

@Controller
@RequestMapping("admin/categorys/{cid}/products/{pid}/productImages")
public class ProductImageController extends BaseBackController{
	@Autowired
	ProductImageService productImageService;
	@Autowired
	ProductService productService;
	@RequestMapping(value = "",method = RequestMethod.GET)
	public ModelAndView list(@PathVariable int pid) {
		ModelAndView mav = new ModelAndView();
		Product product = productImageService.listToProduct(pid);
		mav.addObject("p", product);
		mav.setViewName("admin/listProductImage");
		return mav;
	}
	@RequestMapping(value = "",method = RequestMethod.POST)
	public String add(@RequestParam(value = "imageFile") MultipartFile imageFile,ProductImage productImage,@PathVariable int pid,HttpServletRequest request) {
		Product product = productService.get(pid);
		productImage.setProduct(product);
		productImageService.add(productImage, imageFile,request);
		return "redirect:productImages";
	}
	@RequestMapping(value = "{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int id,HttpServletRequest request) {
		productImageService.delete(id, request);
		return "redirect:../productImages";
	}
}
