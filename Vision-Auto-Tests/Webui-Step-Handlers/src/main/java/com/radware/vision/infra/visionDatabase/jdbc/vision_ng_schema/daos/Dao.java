package com.radware.vision.infra.visionDatabase.jdbc.vision_ng_schema.daos;

import java.util.List;
import java.util.Optional;

public interface Dao<ENTITY, KEY_TYPE> {

    Optional<ENTITY> get(KEY_TYPE key);
    List<ENTITY> getAll();
    void save(ENTITY entity);
    void update (ENTITY entity);
    void delete(ENTITY entity) ;
}
