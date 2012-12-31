package com.deformity.common.baseService;

import com.deformity.common.FileBean;
import com.ibatis.sqlmap.client.SqlMapClient;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service("baseService")
public class BaseServiceImpl implements BaseService {
    @Resource(name = "jdbcTemplate")
    private JdbcTemplate jdbcTemplate;

    @Resource(name = "sqlMapClient")
    private SqlMapClient sqlMapClient;


    @SuppressWarnings("unchecked")
    public List findList(String sqlName, Map<String, Object> condition)
            throws SQLException {
        return sqlMapClient.queryForList(sqlName, condition);
    }

    public Object findById(String sqlName, Map<String, Object> condition)
            throws SQLException {
        return sqlMapClient.queryForObject(sqlName, condition);
    }

    public Long findListTotal(String sqlName, Map<String, Object> condition)
            throws SQLException {
        return (Long) sqlMapClient.queryForObject(sqlName, condition);
    }

    public void updateObject(final String sqlName,
                             final Map<String, Object> condition) throws SQLException {
        sqlMapClient.update(sqlName, condition);
    }

    public void addObject(final String sqlName,
                          final Map<String, Object> condition) throws SQLException {
        sqlMapClient.insert(sqlName, condition);
    }

    public void delObject(final String sqlName,
                          final Map<String, Object> condition) throws SQLException {
        sqlMapClient.delete(sqlName, condition);
    }

    public Long getFileSeq(String sqlName) throws SQLException {
        return (Long) sqlMapClient.queryForObject(sqlName);
    }

    @SuppressWarnings("unchecked")
    public void attachInsert(final FileBean condition) throws DataAccessException {
        jdbcTemplate
                .execute(
                        "INSERT INTO ATTACH_FILE(file_id,file_name,state,state_date,attach_file_data)\n"
                                + "               values(?,?,'10A',sysdate,?)",
                        new PreparedStatementCallback() {
                            public Object doInPreparedStatement(PreparedStatement stmt)
                                    throws SQLException {
                                stmt.setObject(1, condition.getFile_id());
                                stmt.setObject(2, condition.getFile_name()[0]);
                                try {
                                    FileInputStream fi = new FileInputStream(
                                            condition.getFiles()[0]);
                                    stmt.setBinaryStream(3, fi, (int) condition
                                            .getFiles()[0].length());
                                } catch (IOException ignored) {
                                }
                                stmt.execute();
                                return null;
                            }
                        });

    }

    @SuppressWarnings("unchecked")
    public void attachUpdate(final FileBean condition) throws DataAccessException {

        jdbcTemplate.execute("UPDATE ATTACH_FILE\n"
                + "        SET file_name = ?,\n"
                + "           attach_file_data = ?\n"
                + "        WHERE file_id = ?", new PreparedStatementCallback() {
            public Object doInPreparedStatement(PreparedStatement stmt)
                    throws SQLException {

                stmt.setObject(1, condition.getFile_name()[0]);
                try {
                    FileInputStream fi = new FileInputStream(condition
                            .getFiles()[0]);
                    stmt.setBinaryStream(2, fi, (int) condition.getFiles()[0]
                            .length());
                } catch (IOException ignored) {
                }
                stmt.setObject(3, condition.getFile_id());
                stmt.execute();
                return null;
            }
        });
    }

    @SuppressWarnings("unchecked")
    public InputStream attachDown(final String id) throws DataAccessException {
        String sql = "select attach_file_data from attach_file where file_id="
                + id;
        final InputStream[] inputStream = {null};
        this.jdbcTemplate.execute(sql, new CallableStatementCallback() {
            public Object doInCallableStatement(CallableStatement stmt) throws SQLException {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    // Blob blob = rs.getbi("content");
                    inputStream[0] = rs.getBinaryStream("attach_file_data");// 读取数据库Binary流
                }
                return null;
            }
        });
        return inputStream[0];
    }
}
