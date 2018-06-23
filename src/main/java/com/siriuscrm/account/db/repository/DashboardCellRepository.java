package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.Cell;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DashboardCellRepository extends JpaRepository<Cell, Long> {


    @Query(nativeQuery = true, value = "SELECT lpad(cell || '', 3, '0') as cell_number " +
            "FROM (SELECT generate_series(1, 999) AS cell) AS cells " +
            "WHERE lpad(cell || '', 3, '0') NOT IN (SELECT dashboard_cell " +
            "                                        FROM ppk " +
            "                                        WHERE " +
            "                                          dashboard_type_id = :dashboardTypeId AND dashboard_subtype_id = :dashboardSubtypeId AND dashboard_number = :dashboardNumber " +
            ")")
    List<Cell> getAllEmptyCells(@Param(value = "dashboardTypeId") Integer dashboardTypeId, @Param(value = "dashboardSubtypeId") Integer dashboardSubtypeId,
                                  @Param(value = "dashboardNumber") Integer dashboardNumber);
}
