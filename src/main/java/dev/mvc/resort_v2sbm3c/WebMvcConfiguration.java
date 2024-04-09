package dev.mvc.resort_v2sbm3c;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import dev.mvc.creates.Creates;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer {
  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
      // Windows: path = "C:/kd/deploy/resort_v2sbm3c_blog/creates/storage";
      // ▶ file:///C:/kd/deploy/resort_v2sbm3c_blog/creates/storage
    
      // Ubuntu: path = "/home/ubuntu/deploy/resort_v2sbm3c_blog/creates/storage";
      // ▶ file:////home/ubuntu/deploy/resort_v2sbm3c_blog/creates/storage
    
      // JSP 인식되는 경로: http://localhost:9092/creates/storage";
      registry.addResourceHandler("/creates/storage/**").addResourceLocations("file:///" +  Creates.getUploadDir());
      
      // JSP 인식되는 경로: http://localhost:9092/attachfile/storage";
      // registry.addResourceHandler("/attachfile/storage/**").addResourceLocations("file:///" +  Tool.getOSPath() + "/attachfile/storage/");
      
      // JSP 인식되는 경로: http://localhost:9092/crew/storage";
      // registry.addResourceHandler("/crew/storage/**").addResourceLocations("file:///" +  Tool.getOSPath() + "/crew/storage/");
  }
}
