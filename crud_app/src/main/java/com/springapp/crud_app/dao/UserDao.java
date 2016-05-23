package com.springapp.crud_app.dao;

import com.springapp.crud_app.model.User;

import java.util.List;

public interface UserDao {
    public void addUser(User user);

    public void updateUser(User user);

    public void removeUser(int id);

    public User getUserById(int id);

    public List<User> listUsers();

    public User searchUserById(int id);
}
