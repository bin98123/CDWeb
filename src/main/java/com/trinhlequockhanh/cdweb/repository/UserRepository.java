package com.trinhlequockhanh.cdweb.repository;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.trinhlequockhanh.cdweb.entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

	public List<User> findByemail(String email);

	@Query(value = "select u.fullname from User u where u.email = :email and u.password = :password and u.actived=1")
	Optional<Object> login(@Param("email") String email, @Param("password") String password);

	@Query(value = "select u.password from User u where u.email = :email and u.actived=1")
	String getPassword(@Param("email") String email);

	@Query(value = "select u.id from User u where u.email = :email and u.actived=1")
	String getID(@Param("email") String email);

	@Query(value = "select u from User u where u.email = :email and u.actived=1")
	Optional<Object> checkExistMail(@Param("email") String email);

	@Query(value = "select u from User u where u.phonenumber = :phonenumber and u.actived=1")
	Optional<Object> checkExistPhone(@Param("phonenumber") String phonenumber);

	@Modifying
	@Query(value = "update User u set u.actived=1 where u.id= :id")
	@Transactional
	Optional<Object> getActive(@Param("id") String id);

	@Modifying
	@Query(value = "insert into User u (u.id, u.fullname , u.email, u.address, u.username, u.password,u.actived, u.birthday) VALUES ( :id, :fullname , :email, :address, :username, :password, :actived, :birthday)", nativeQuery = true)
	@Transactional
	int insertUser(@Param("id") String id, @Param("fullname") String fullname, @Param("email") String email,
			@Param("address") String address, @Param("username") String username, @Param("password") String password,
			@Param("actived") Boolean actived, @Param("birthday") Date birthday);
}
