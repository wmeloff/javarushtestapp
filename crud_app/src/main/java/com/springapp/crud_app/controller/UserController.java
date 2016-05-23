package com.springapp.crud_app.controller;

import com.springapp.crud_app.model.User;
import com.springapp.crud_app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;


@Controller
public class UserController {
    private UserService userService;
    final private int PAGE_SIZE = 2;
    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String listUsers(int start, int end, Model model){
        model.addAttribute("user", new User());
        List<User> users = this.userService.listUsers();
        ArrayList<User> res = new ArrayList<User>();

        int n = users.size();

        for(int i=start; i<end; i++){
            if(i < n)
                res.add(users.get(i));
        }
        model.addAttribute("listUsers", res);
        model.addAttribute("totalCount", users.size());
        model.addAttribute("pagesize", PAGE_SIZE);

        return "users";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user){
        int n =0;
        int start = 0;
        if(user.getId() == 0){
            n =  this.userService.listUsers().size();
            start = n - PAGE_SIZE;
            this.userService.addUser(user);
            return "redirect:/users?start="+start+"&end="+n;
        }else {
            this.userService.updateUser(user);

            return "redirect:/users?start=0&end="+PAGE_SIZE;
            //TODO pagination (don't work correct)
            /*start = 1;
            for(User line : this.userService.listUsers()){
                if(line.getId() == user.getId() ) break;
                start++;
            }

            if(start % PAGE_SIZE == 0)
                start = start/PAGE_SIZE + 1;
            else
                start = start/PAGE_SIZE ;

            n = start + PAGE_SIZE;

            return "redirect:/users?start="+start+"&end="+n;
            */

        }

    }

    @RequestMapping("/remove/{id}")
    public String removeUser(@PathVariable("id") int id){
        this.userService.removeUser(id);

        return "redirect:/users?start=0&end="+PAGE_SIZE;
    }

    @RequestMapping("edit/{id}")
    public String editUser(@PathVariable("id") int id, int start, int end, Model model){
        List<User> users = this.userService.listUsers();
        ArrayList<User> res = new ArrayList<User>();

        int n = users.size();

        for(int i=start; i<end; i++){
            if(i < n)
                res.add(users.get(i));
        }

        model.addAttribute("user", this.userService.getUserById(id));
        model.addAttribute("listUsers", res);
        model.addAttribute("pagesize", PAGE_SIZE);

        return "users";
    }

    @RequestMapping("userdata/{id}")
    public String userData(@PathVariable("id") int id, Model model){
        model.addAttribute("user", this.userService.getUserById(id));

        return "userdata";
    }

    @RequestMapping(value ="search", method = RequestMethod.GET)
    public String searchUser(int id, Model model){
        model.addAttribute("searchedUser", this.userService.searchUserById(id));

        return "search";
    }
}
