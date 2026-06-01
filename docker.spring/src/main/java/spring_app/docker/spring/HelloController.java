package spring_app.docker.spring; // Match the package name

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
public class HelloController {

    @GetMapping("/") // This means when you hit the main URL, it runs this method
    public String hello() {
        return "Dockerize Spring Boot Application";
    }
}
