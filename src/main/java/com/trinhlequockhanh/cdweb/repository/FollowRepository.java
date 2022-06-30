package com.trinhlequockhanh.cdweb.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.trinhlequockhanh.cdweb.entities.Follow;

@Repository
public interface FollowRepository extends JpaRepository<Follow, String> {

}
