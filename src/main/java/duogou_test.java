import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hixqz.store.Utils.Page;
import com.hixqz.store.mapper.CategoryMapper;
import com.hixqz.store.mapper.OrderItemMapper;
import com.hixqz.store.mapper.PropertyMapper;
import com.hixqz.store.pojo.Property;
import com.hixqz.store.service.CategoryService;
import com.hixqz.store.service.OrderItemService;
import com.hixqz.store.service.OrderService;
import com.hixqz.store.service.ProductImageService;
import com.hixqz.store.service.ProductService;
import com.hixqz.store.service.PropertyService;
import com.hixqz.store.service.PropertyValueService;
import com.hixqz.store.service.ReviewService;
import com.hixqz.store.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class duogou_test {
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	
	@Autowired
	ProductImageService productImageService;
	
	@Autowired
	PropertyService propertyService;
	
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
	@Autowired
	OrderItemMapper orderItemMapper;
	
	@Autowired
	CategoryMapper categoryMapper;
	@Autowired
	PropertyMapper propertyMapper;
	@Test
	public void test() {
		//Category category = categoryService.get(83);
		//System.out.println(category.getProducts().get(0).getFirstProductImage().getType());
	//	System.out.println("image:"+category.getProducts().get(0).getFirstProductImage().getId());
		
/*	 	List<Category> categories = categoryService.list();
	 	productService.fillByRow(categories);
	 	List<List<Product>> productByRow = categories.get(0).getProductsByRow();
	 	System.out.println(productByRow);*/
		/*Product product = productService.get(732);
		System.out.println(product.getCategory().getName());*/
		/*Product product = new Product();
		product.setId(87);
		List<ProductImage> productImages = productImageService.getBySingle(product);
		System.out.println(productImages);*/
		//propertyService.list(60);
		/*
		List<PropertyValue> pvs = propertyValueService.list(87);
		System.out.println(pvs);*/
		/*List<Review> list = reviewService.list(89);
		System.out.println(list);*/
		/*User user = new User();
		user.setName("nocolorfq");
		user.setPassword("12313");*/
		/*userService.add(user);*/
	//	System.out.println("¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ¹þ"+userService.existUserName(user));
	/*	List<Product> products = productService.search("ÂíÍ°");
		System.out.println(products);*/
/*		OrderItem orderItem = new OrderItem();
		Product product = new Product();
		product.setId(88);
		orderItem.setProduct(product);
		orderItem.setNumber(333);
		orderItem.setUid(1);
		orderItem.setOid(123);
		orderItemService.add(orderItem);*/
/*		User user = new User();
		user.setId(1);
		List<OrderItem> orderItems = orderItemService.listByUser(user);
		System.out.println(orderItems.get(0).getProduct().getName());*/
		/*User user = new User();
		user.setId(10);*/
		/*List<OrderItem> orderItems = orderItemService.listByUser(user);
		System.out.println(orderItems);*/
		/*Order order = new Order();
		order.setUser(user);*/
		
		//orderService.add(order);
	/*	List<Order> orders = orderService.listByUser(user);
		System.out.println(orders.get(0).getUser().getId());*/
		/*Date date = new Date();
		System.out.println(date.getTime());*/
/*		SimpleDateFormat sf = new SimpleDateFormat("YYYYMMddHHmmssS");
		Random random = new Random();
		int rd = random.nextInt(10000);
		rd = rd < 1000?rd+1000:rd;
		System.out.println("Ê±¼ä"+rd);*/
/*		Date date = new Date();
		Order order = new Order();
		order.setPayDate(DateUtil.DateTurnTimestamp(date));
		System.out.println(order.getPayDate());
		System.out.println();*/
	/*	User user = new User();
		user.setId(10);
		List<Order> orders = orderService.listByUser(user);
		System.out.println(orders.get(0).getOrderItems().get(0).getProduct().getFirstProductImage().getType());*/
	//	System.out.println(orderService.get(2).getOrderItems().get(0).getProduct().getName());
	/*	Product product = new Product();
		product.setId(88);
		orderItemMapper.getSaleByProduct(product);*/
		/*int[] is = RandomUtil.RandomArray(4, 4);
		for(int i = 0;i < is.length;i++) {
			System.out.println(is[i]);
		}*/
/*		List<Category> randomCategorys = categoryService.getRandomCategorys(4);
		for(Category category : randomCategorys) {
			System.out.println(category.getId());
		}*/
/*		Page page = new Page();
		page.setStart(0);
		page.setCount(5);
		categoryService.listByPage(page);*/
/*		User user = new User();
		user.setName("Ëæ");
		System.out.println(user.getAnonymousName());*/
		//System.out.println(categoryMapper.getChildCount(85));
		//System.out.println(propertyService.list(83, new Page()).get(0).getCategory().getName());
		//System.out.println(productService.listByPage(83, new Page()).get(0).getCategory().getName());
		/*List<Property> list = propertyMapper.list(60);*/
		//List<Property> properties = propertyService.list(60, null);
		/*Page page = new Page();
		
		System.out.println(orderService.list(page).size());*/
/*		Page page = new Page();
		Page page2 = new Page();
		page2.setCount(3);
		System.out.println(page.getClass()==page2.getClass());*/
	}
}
