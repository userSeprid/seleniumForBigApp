package com.siriuscrm.account;

import org.hibernate.engine.jdbc.connections.internal.DatasourceConnectionProviderImpl;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by asolod on 10/22/2017.
 */
public class PostgresSchemaConnectionProvider extends DatasourceConnectionProviderImpl {

    @Override
    public Connection getConnection() throws SQLException {
        Connection connection = super.getConnection();
        try {
            Statement statement = connection.createStatement();
            statement.execute("SET SCHEMA public");
        } catch (SQLException e) {
            System.out.print(e);
        }
        return connection;
    }

    @Override
    public DataSource getDataSource() {
        return super.getDataSource();
    }
}
