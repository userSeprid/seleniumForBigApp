package com.siriuscrm.account.db.repository;

import com.siriuscrm.account.db.entity.ppk.PPKView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PPKViewRepository extends JpaRepository<PPKView, Long> {

    @Query(value = "SELECT * FROM ppk_view ORDER BY ppk_number ASC LIMIT :limit OFFSET :offset"
            , nativeQuery = true)
    List<PPKView> findAll(@Param("limit") Long limit, @Param("offset") Long offset);

    @Query(value = "SELECT count(*) FROM ppk_view"
            , nativeQuery = true)
    int findAllCount();


    @Query("SELECT ppkv from PPKView ppkv where" +
            " ppkv.locationStreet like :param" +
            " OR ppkv.description like :param" +
            " OR ppkv.ppkNumber like :param")
    List<PPKView> findByString(@Param("param") String param);

    @Query("SELECT count(*) from PPKView ppkv where" +
            " ppkv.locationStreet like :param" +
            " OR ppkv.description like :param" +
            " OR ppkv.ppkNumber like :param")
    int findByStringCountTotal(@Param("param") String param);

    @Query(nativeQuery = true,
            value = "SELECT * " +
            "FROM ppk_view pv " +
            "WHERE id IN ( " +
            "  SELECT ppk_id " +
            "  FROM ppk_person " +
            "  WHERE owner = TRUE AND person_id = (SELECT person_id " +
            "                                      FROM ppk_person " +
            "                                      WHERE ppk_id = :ppkId and owner = true) " +
            ") " +
            "and id <> :ppkId")
    List<PPKView> findAllSameOwner(@Param("ppkId") Long ppkId);

    @Query(nativeQuery = true,
            value = "SELECT * " +
                    "FROM ppk_view pv " +
                    "WHERE id IN ( " +
                    "  SELECT ppk_id " +
                    "  FROM ppk_person " +
                    "  WHERE advisor = TRUE AND person_id = (SELECT person_id " +
                    "                                      FROM ppk_person " +
                    "                                      WHERE ppk_id = :ppkId and owner = true) " +
                    ") " +
                    "and id <> :ppkId")
    List<PPKView> loadListByAdvisor(@Param("ppkId") Long ppkId);
}
