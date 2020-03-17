package com.hixqz.store.controller;

import java.io.Console;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.CharUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.util.StringUtil;
import com.hixqz.store.Utils.DateUtil;
import com.hixqz.store.chat.ChatUtil;
import com.hixqz.store.chat.MyWebSocket;
import com.hixqz.store.pojo.Category;
import com.hixqz.store.pojo.Order;
import com.hixqz.store.pojo.OrderItem;
import com.hixqz.store.pojo.Product;
import com.hixqz.store.pojo.PropertyValue;
import com.hixqz.store.pojo.Review;
import com.hixqz.store.pojo.User;
import com.hixqz.store.service.CategoryService;
import com.hixqz.store.service.OrderItemService;
import com.hixqz.store.service.OrderService;
import com.hixqz.store.service.ProductService;
import com.hixqz.store.service.PropertyValueService;
import com.hixqz.store.service.ReviewService;
import com.hixqz.store.service.UserService;
import com.sun.tools.javac.util.StringUtils;

@Controller
public class ForeController extends BaseForeController{
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	@Autowired
	PropertyValueService propertyValueService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	UserService userService;
	@Autowired
	OrderItemService orderItemService;
	@Autowired
	OrderService orderService;
	@RequestMapping(value = "login",method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	@ResponseBody
	@RequestMapping(value = "login",method = RequestMethod.POST)
	public String login(User checkUser,HttpSession session) {
		User user = userService.checkUser(checkUser);
		if(null!=user) {
			session.setAttribute("user", user);
			String role = null;
			try {
				role = ChatUtil.encrypt_Base64("role="+user.getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("role", role);
			return "success";
		}
		return "failure";
	}
	@RequestMapping(value = "register",method = RequestMethod.GET)
	public String register() {
		return "register";
	}
	@RequestMapping(value = "register",method = RequestMethod.POST)
	public String register(User user,HttpSession session) {
		//�ٴ��ж��û����Ƿ���ڣ���ֹ�ظ��ύ��
		if(userService.existUserName(user.getName())) 
			return "registerSuccess";
		userService.add(user);
		String role = null;
		try {
			role = ChatUtil.encrypt_Base64("role="+user.getId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("role", role);
		session.setAttribute("user", user);
		return "registerSuccess";
		
	}
	@ResponseBody
	@RequestMapping(value = "existUserName",method = RequestMethod.POST)
	public String existUserName(String name) {
		if(userService.existUserName(name))
			return "failure";
		else return "success";
	}
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if(null!=user) {
			session.removeAttribute("user");
			return "redirect:login";
		}
		return "redirect:login";
	}
	//��ҳ
	@RequestMapping(value = {"home","/"})//��home��/��ӳ�䵽�˷���
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		List<Category> categories = categoryService.list();
		productService.fillByRow(categories);//��Ʒ��ÿ��5����ʾ
		mav.addObject("cs",categories);
		mav.setViewName("home");
		return mav;
	}
	//��Ʒҳ
	@RequestMapping(value = "product",method = RequestMethod.GET)
	public ModelAndView product(int pid) {
		ModelAndView mav = new ModelAndView();
		Product product = productService.get(pid);
		productService.setProductSingleImages(product);
		productService.setProductDetailImages(product);
		List<PropertyValue> PropertyValues = propertyValueService.list(pid);
		List<Review> reviews = reviewService.list(pid);
		mav.addObject("pvs", PropertyValues);
		mav.addObject("reviews", reviews);
		mav.addObject("product", product);
		mav.setViewName("product");
		return mav;
	}
	
	//����
	@RequestMapping("search")
	public ModelAndView search(String keyword,String sort) {
		List<Product> products = productService.search(keyword);
		if(null!=sort) {
			productService.sort(products, sort);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("ps", products);
		mav.setViewName("searchResult");
		return mav;
	}
	//���빺�ﳵ����������
	@ResponseBody
	@RequestMapping(value = "buyone",method = RequestMethod.POST)
	public String buyone(OrderItem orderItem,HttpSession session) {
		User user = (User) session.getAttribute("user");
		orderItem.setUid(user.getId());
		orderItemService.add(orderItem);
		return "buy?oiid="+orderItem.getId();
	}
	@RequestMapping(value = "buy",method = RequestMethod.GET)
	public String buy(String[] oiid,HttpSession session) {
		ArrayList<OrderItem> orderItems = new ArrayList<OrderItem>();
		for(int i = 0;i < oiid.length;i++) {
			OrderItem orderItem = orderItemService.get(Integer.parseInt(oiid[i]));
			orderItems.add(orderItem);
		}	
		String total = (String) orderItemService.getTotal(orderItems).get("total");//�����ܼ�
		session.setAttribute("ois", orderItems);
		session.setAttribute("total", total);
		return "buy";
	}
	//���ﳵ
	@RequestMapping(value = "cart",method=RequestMethod.GET)
	public ModelAndView cart(HttpSession session) {
		User user = (User) session.getAttribute("user");
		List<OrderItem> orderItems = orderItemService.listByUser(user);
		ModelAndView mav = new ModelAndView();
		mav.addObject("ois", orderItems);
		mav.setViewName("cart");
		return mav;
	}
	//��ȡ���ﳵ��Ʒ����--���ڶ���top��
	@ResponseBody
	@RequestMapping(value = "getCartNumber",method = RequestMethod.POST)
	public String getCartNumber(HttpSession session) {
		User user = (User) session.getAttribute("user");
		String cartNumber = orderItemService.getCartNumber(user);
		return cartNumber;
	}
	//���ﳵ��ɾ��������
	@ResponseBody
	@RequestMapping(value = "deleteOrderItem",method = RequestMethod.POST)
	public String deleteOrderItem(int oiid) {
		try {
			orderItemService.delete(oiid);
		} catch (Exception e) {
			// TODO: handle exception
			return "failed";
		}
		return "success";	
	}
	//���ﳵ�޸���Ʒ����
	@ResponseBody
	@RequestMapping(value = "changeOrderItem",method = RequestMethod.POST)
	public String changeOrderItem(OrderItem orderItem) {
		int number = orderItem.getNumber();
		orderItem = orderItemService.get(orderItem.getId());
		orderItem.setNumber(number);
		orderItemService.update(orderItem);
		return "success";
	}
	@RequestMapping(value = "createOrder",method = RequestMethod.POST)
	public String createOrder(Order order,HttpSession session) {
		//order.setStatus(Order.waitPay);
		User user = (User) session.getAttribute("user");
		order.setOrderCode(orderService.createOrderCode());
		order.setCreateDate(DateUtil.DateTurnTimestamp(new Date()));
		order.setUser(user);
		order.setStatus(Order.waitPay);
		orderService.add(order);
		ArrayList<OrderItem> orderItems = (ArrayList<OrderItem>) session.getAttribute("ois");
		orderItemService.setOrder(orderItems, order.getId());
		session.setAttribute("oid", order.getId());
		session.removeAttribute("ois");
		return "redirect:alipay";
	}
	@RequestMapping(value = "alipay",method = RequestMethod.GET)
	public String alipay(@RequestParam(value="oid",required=false) Integer oid,@RequestParam(value="total",required=false) String total,HttpSession session) {
		if(null!=oid&&null!=total) {
			session.removeAttribute("total");
			session.removeAttribute("oid");
			session.setAttribute("total", total);
			session.setAttribute("oid", oid);
			return "redirect:payLeter";
		}
		return "alipay";
	}
	@RequestMapping(value = "payLeter",method = RequestMethod.GET)
	public String payLeter() {
		return "alipay";
	}
	@RequestMapping(value = "payed",method = RequestMethod.GET)
	public ModelAndView payed(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		int oid = (int) session.getAttribute("oid");
		Order order = orderService.get(oid);
		order.setStatus(Order.waitDelivery);
		orderService.updateStatus(order);
		SimpleDateFormat sf = new SimpleDateFormat("YYYY-MM-dd");
		String dateOfService = sf.format(new Date(order.getPayDate().getTime()+1000*60*60*24*3));//���ڼ�3����ΪԤ���ʹ�����
		mav.addObject("order", order);
		mav.addObject("dateOfService", dateOfService);
		mav.setViewName("payed");
		session.removeAttribute("oid");
		return mav;
	}
	@RequestMapping(value = "myOrder",method = RequestMethod.GET)
	public ModelAndView myOrder(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("user");
		List<Order> orders = orderService.listByUser(user);
		mav.addObject("orders", orders);
		mav.setViewName("myOrder");
		return mav;
	}
	@ResponseBody
	@RequestMapping(value = "deleteOrder",method = RequestMethod.POST)
	public String deleteOrder(int oid) {
		Order order = orderService.get(oid);
		order.setStatus(Order.delete);
		orderService.updateStatus(order);
		return "success";	
	}
	//����
	@ResponseBody
	@RequestMapping(value = "delivery",method = RequestMethod.POST)
	public String delivery(Integer oid) {
		Order order = orderService.get(oid);
		order.setStatus(Order.waitConfirm);
		orderService.updateStatus(order);
		return "success";
	}
	//ȷ���ջ�
	@RequestMapping(value = "confirmReceive",method = RequestMethod.GET)
	public ModelAndView confirmReceive(int oid) {
		ModelAndView mav = new ModelAndView();
		Order order = orderService.get(oid);
		mav.addObject("order",order);
		mav.setViewName("confirmReceive");
		return mav;
	}
	@RequestMapping(value = "orderConfirmed",method = RequestMethod.GET)
	public String orderConfirmed(int oid) {
		Order order = orderService.get(oid);
		order.setStatus(Order.waitReview);
		orderService.updateStatus(order);
		return "orderConfirmed";
	}
	@RequestMapping(value = "review",method = RequestMethod.GET)
	public ModelAndView review(int oid) {
		ModelAndView mav = new ModelAndView();
		Order order = orderService.get(oid);
		mav.addObject("orderItem", order.getOrderItems().get(0));
		mav.addObject("oid", oid);
		mav.setViewName("review");
		return mav;
	}
	@RequestMapping(value = "review",method = RequestMethod.POST)
	public ModelAndView review(Review review,int oid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("user");
		review.setUser(user);
		Order order = orderService.get(oid);
		//������״̬Ϊ������ʱ�������ύ����
		if(order.getStatus().equals(Order.waitReview)) {
			reviewService.add(review);
			order.setStatus(Order.finish);
			orderService.updateStatus(order);
		}
		List<Review> reviews = reviewService.list(review.getPid());
		mav.addObject("orderItem", order.getOrderItems().get(0));
		mav.addObject("reviews", reviews);
		mav.addObject("showonly", "showonly");
		mav.setViewName("review");
		return mav;
	}
	@RequestMapping(value = "category",method = RequestMethod.GET)
	public ModelAndView category(int cid,String sort) {
		ModelAndView mav = new ModelAndView();
		Category category = categoryService.get(cid);
		if(sort!=null) {//���sort������Ϊ�գ�����������
			productService.sort(category.getProducts(), sort);
		}
		mav.addObject("ps", category.getProducts());
		mav.setViewName("category");
		return mav;
	}
}
