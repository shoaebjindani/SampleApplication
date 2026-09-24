package com.crystal;

import java.io.IOException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class SpringBootServletJspApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(SpringBootServletJspApplication.class, args);

	}

}