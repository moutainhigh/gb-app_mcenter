package so.wwb.gamebox.test;

import junit.framework.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;


/**
 * Created by Kevice on 2015/1/29.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:conf/*-appCtx.xml")
@Transactional
public abstract class BaseTestCase extends Mockito {

	@Test
	public void test() {

	}

	public static void main(String[] args) {
		String ss = "abc";
		String gg = "abc";
		if (ss==gg) {
			System.out.println("eeee");
		}
	}
}
