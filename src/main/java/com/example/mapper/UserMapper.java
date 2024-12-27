package com.example.mapper;

import com.example.model.MemberReview;
import com.example.model.RegistrationReview;
import com.example.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    public List<User> findAllTeamAdmin();
    public List<User> findAllTeamMember();
    public List<User> findAllVisitor();
    User findByUserId(@Param("userId") int userId); // 根据 userID 查询
    User findByUsername(@Param("username") String username); // 根据 username 查询
    int checkUsernameAndEmail(@Param("username") String username, @Param("email") String email);
    int checkOldPassword(@Param("username") String username, @Param("password") String password);
    int updatePassword(@Param("username") String username, @Param("password") String password);
    void insertReview(User user);
    void updatePassword(User user);
    int checkDeactivationRequest(@Param("userID") int userID);
    void insertDeactivationRequest(@Param("userID") int userID);
    int updateTeamAdminInfo(User user);
    public int insertTeamAdminToUser(@Param("username") String username, @Param("password") String password,@Param("email")String email);
    public String findNameByUserID(int userID);
    public String findUsernameByUserID(int userID);
//    public int deleteUser(@Param("userID") int userID);
    public int addTeamMember(User user);
    public int updateTeamMember(User user);
    public int updateTeamMemberInfo(MemberReview memberReview);
    public int addNewUser(RegistrationReview registrationReview);
    public List<User> findTeamMemberAndVisitor();
    public int deleteById(int userID);
    public int ResetPassword(@Param("userID")int userID, @Param("password")String password);
    public List<User> searchUsers(@Param("username") String username,
                           @Param("roleType") String roleType,
                           @Param("status") Integer status,
                           @Param("registrationTime") String registrationTime,
                           @Param("email") String email);// 根据多个条件查询用户
    public int setStatus(@Param("userID") int userID);
}
