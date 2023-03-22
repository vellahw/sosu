package sosu;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import second.sosu.comment.service.CommentService;

@RunWith(SpringRunner.class)
@ContextConfiguration(
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
@Log4j
public class SampleTestController {
	
	@Setter(onMethod_ = @Autowired)
	private CommentService commentDAO;
	
	@Test
	public void testDAO() {
		log.info(commentDAO);
	}
}
