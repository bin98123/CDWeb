package com.trinhlequockhanh.cdweb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.trinhlequockhanh.cdweb.entities.Img;

@Repository
public interface ImgRepository extends JpaRepository<Img, String> {
	public List<Img> findByidproduct(String idproduct);
}
