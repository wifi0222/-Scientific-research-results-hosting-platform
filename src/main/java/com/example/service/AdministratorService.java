package com.example.service;

import com.example.model.TeamAdministrator;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface AdministratorService {
    public List<TeamAdministrator> findAllAdministrators();
    public TeamAdministrator findAdministratorById(int id);
    public int setTemplePermission(int adminID);
    public int setAllPermission(
            Boolean userPermission,Boolean publishAchievement,Boolean deleteAchievement,Boolean editAchievement,Boolean setStatusAchievement,
            Boolean publishArticle,Boolean deleteArticle,Boolean editArticle,Boolean setStatusArticle,int adminID
    );
    public boolean getUserManageAdministrator(int adminID); //获取团队管理员用户管理的权限
    public int setUserManageAdministrator(int adminID);
    public int setResearchAdministrator(int adminID);
    public int setArticleAdministrator(int adminID);
}


