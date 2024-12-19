package com.example.service;

import com.example.model.TeamAdministrator;

import java.util.List;

public interface AdministratorService {
    public List<TeamAdministrator> findAllAdministrators();
    public TeamAdministrator findAdministratorById(int id);
    public int setTemplePermission(int adminID);
    public int setAllPermission(Boolean publishPermission,Boolean userPermission,Boolean deletePermission, int adminID);
}
