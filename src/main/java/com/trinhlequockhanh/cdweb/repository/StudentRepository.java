package com.trinhlequockhanh.cdweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.trinhlequockhanh.cdweb.entities.Student;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {

}
