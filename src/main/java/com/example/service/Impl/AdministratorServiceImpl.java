package com.example.service.Impl;

import com.example.mapper.AdministratorMapper;
import com.example.mapper.UserMapper;
import com.example.model.TeamAdministrator;
import com.example.service.AdministratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdministratorServiceImpl implements AdministratorService {
    @Autowired
    AdministratorMapper administratorMapper;
    @Autowired
    UserMapper userMapper;

    @Override
    public List<TeamAdministrator> findAllAdministrators() {
        List<TeamAdministrator> list=administratorMapper.findAllAdministrators();
        //设置list里面的姓名和用户名
        if(list.size()>0) {
            for (TeamAdministrator teamAdministrator : list) {
                teamAdministrator.setAdminName(userMapper.findNameByUserID(teamAdministrator.getAdminID()));
                teamAdministrator.setAdminUsername(userMapper.findUsernameByUserID(teamAdministrator.getAdminID()));
            }
        }
        return list;
    }

    @Override
    public TeamAdministrator findAdministratorById(int id) {
        TeamAdministrator administrator=administratorMapper.findAdministratorById(id);
        if(administrator!=null) {
            administrator.setAdminName(userMapper.findNameByUserID(administrator.getAdminID()));
            administrator.setAdminUsername(administrator.getAdminUsername());
        }
        return administrator;
    }

    @Override
    public int setTemplePermission(int adminID) {
        return administratorMapper.setTemplePermission(adminID);
    }

    @Override
    public int setAllPermission(Boolean publishPermission, Boolean userPermission, Boolean deletePermission, int adminID) {
        return administratorMapper.setAllPermission(publishPermission, userPermission, deletePermission, adminID);
    }
}
