package com.trinhlequockhanh.cdweb.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.trinhlequockhanh.cdweb.entities.Shop;

@Repository
public interface ShopRepository extends JpaRepository<Shop, String> {
	public Shop findByiduser(String iduser);
}
