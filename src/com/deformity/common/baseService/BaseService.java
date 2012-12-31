package com.deformity.common.baseService;


import com.deformity.common.FileBean;
import org.springframework.dao.DataAccessException;

import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface BaseService {
	//List execute();

    /**
     * 查询列表
     * @param sqlName
     * @param condition
     * @return List
     * @throws SQLException 
     */
	List findList(String sqlName,Map<String, Object> condition) throws SQLException ;
    /**
     * 按照Id查询
     * @param sqlName
     * @param condition
     * @return List
     * @throws SQLException 
     */
	Object findById(String sqlName,Map<String, Object> condition) throws SQLException ;

    /**
     * 查询列表总条数
     * @param sqlName
     * @param condition
     * @return Object
     */
	Long findListTotal(String sqlName,Map<String, Object> condition) throws SQLException ;

    /**
     * 修改操作
     * @param sqlName
     * @param condition
     */
	void updateObject(String sqlName,Map<String, Object> condition) throws SQLException ;

    /**
     * 新增操作
     * @param sqlName
     * @param condition
     */
	void addObject(String sqlName,Map<String, Object> condition) throws SQLException ;
    /**
     * 删除操作
     * @param sqlName
     * @param condition
     */
	void delObject(String sqlName,Map<String, Object> condition) throws SQLException ;
    /**
     * 得到附件序列
     * @param sqlName
     * @throws SQLException 
     */
	Long getFileSeq(String sqlName) throws SQLException;
    /**
     * 附件新增
     * @param condition
     */
	void attachInsert(FileBean condition) throws DataAccessException;
    /**
     * 附件修改
     * @param condition
     */
	void attachUpdate(FileBean condition) throws DataAccessException;
    /**
     * 附件下载
     * @param id
     */
	InputStream attachDown(String id) throws DataAccessException;
}
