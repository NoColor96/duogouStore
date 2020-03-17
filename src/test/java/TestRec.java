
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hixqz.store.pojo.Order;
import com.hixqz.store.pojo.User;
import com.hixqz.store.service.OrderService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestRec {
	@Autowired
	OrderService orderService;
	@Test
	public void test() {
		//System.out.println("132");
		User user = new User();
		user.setId(10);
		Order receiverByUser = orderService.getReceiverByUser(user);
		System.out.println(receiverByUser.getAddress());
	}
}
