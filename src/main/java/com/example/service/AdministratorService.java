package com.example.service;

import com.example.model.TeamAdministrator;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface AdministratorService {
    public List<TeamAdministrator> findAllAdministrators();

    public TeamAdministrator findAdministratorById(int id);

    public int setTemplePermission(int adminID);

    int setAllPermission(
            Boolean userPermission,
            Boolean publishAchievement,
            Boolean deleteAchievement,
            Boolean editAchievement,
            Boolean setAchievementStatus,
            Boolean publishArticle,
            Boolean deleteArticle,
            Boolean editArticle,
            Boolean setArticleStatus,
            int adminID
    );

    public boolean getUserManageAdministrator(int adminID); //获取团队管理员用户管理的权限
}


