package com.trinhlequockhanh.cdweb.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.trinhlequockhanh.cdweb.entities.Cart;
import com.trinhlequockhanh.cdweb.entities.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, String> {
	public List<Cart> findByiduser(String iduser);

	@Query(value = "select sum(c.total*p.cost) as totalcost  from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.orderdate IS NULL and c.delivereddate IS NULL and  c.iduser = :id")
	double getTotalCost(@Param("id") String idUser);

	@Query(value = "select (c.total*p.cost) as totalcost  from Cart c join Product p on c.idproduct = p.id  "
			+ " where  c.delivereddate IS NULL and c.iduser = :idUser and c.id = :id")
	double getCost(@Param("idUser") String idUser, @Param("id") String id);

	@Query(value = "select p.total from Cart c join Product p on c.idproduct = p.id  " + " where p.id = :id")
	Integer getTotalProduct(@Param("id") String id);

	@Query(value = "select c.idproduct from Cart c join Product p on c.idproduct = p.id  " + " where c.id = :id")
	String getIDProduct(@Param("id") String id);

	@Query(value = "select u from Cart c join User u on c.iduser = u.id  " + " where c.id = :id")
	User findIdUser(@Param("id") String id);

	@Query(value = "select c from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.orderdate IS NULL and c.delivereddate IS NULL and c.iduser = :idUser and c.id = :id order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	Optional<Object> getCart(@Param("idUser") String idUser, @Param("id") String id);

	@Query(value = "select c from Cart c join Product p on c.idproduct = p.id  "
			+ " where (c.status= :status0 or c.status= :status1) and c.id = :id order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	Optional<Object> getCartSubAjaxCancel(@Param("id") String id, @Param("status0") String status0,
			@Param("status1") String status1);

	@Query(value = "select c from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.status= :status and c.id = :id order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	Optional<Object> submitOrderAjax(@Param("id") String id, @Param("status") String status);

	@Query(value = "select c from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.status= :status and c.iduser= :id order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	List<Cart> getListCartWaitOrder(@Param("id") String id, @Param("status") String status);

	@Query(value = "select c from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.iduser = :idUser order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	List<Cart> getHistoryCart(@Param("idUser") String idUser);

	// cart for customer
	@Query(value = "select c from Cart c where c.orderdate IS NULL and c.delivereddate IS NULL and c.status= :status and c.iduser = :iduser")
	List<Cart> getPurchase(@Param("iduser") String iduser, @Param("status") String status);

	@Query(value = "select c from Cart c where (c.status= :status0 or c.status= :status1) and  c.iduser=:iduser order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	List<Cart> getCartMyCart(@Param("iduser") String iduser, @Param("status0") String status0,
			@Param("status1") String status1);

	@Query(value = "select c from Cart c join Product p on c.idproduct = p.id where c.status= :status and  p.idshop=:iduser order by DAY(c.orderdate),MONTH(c.orderdate),YEAR(c.orderdate) desc")
	List<Cart> getMyCartOrderShop(@Param("iduser") String iduser, @Param("status") String status);

	@Query(value = "select MONTH(c.delivereddate) as month, Year(c.delivereddate) as year, sum(c.total*p.cost) as totalcost  from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.delivereddate IS NOT NULL and  p.idshop = :idshop group by year, month" + " order by year asc")
	List<Object> getReport(@Param("idshop") String idshop);

	@Query(value = "select sum(c.total*p.cost) as totalcost  from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.delivereddate IS NOT NULL and  MONTH(c.delivereddate) = :month and  Year(c.delivereddate) = :year and  p.idshop = :idshop")
	Object getReportOfMonth(@Param("year") Integer year, @Param("month") Integer month, @Param("idshop") String idshop);

	@Query(value = "select p.name as name, sum(c.total*p.cost)/1000000 as totalcost  from Cart c join Product p on c.idproduct = p.id  "
			+ " where c.delivereddate IS NOT NULL and  MONTH(c.delivereddate) = :month and  Year(c.delivereddate) = :year and  p.idshop = :idshop group by name "
			+ "order by name")
	List<Object> getReportByBrand(@Param("year") Integer year, @Param("month") Integer month,
			@Param("idshop") String idshop);

	@Query(value = "select c  from Cart c " + " where c.idproduct = :id and  c.iduser = :id_user "
			+ "and  c.status= :status")
	Optional<Object> checkCart(@Param("id") String id, @Param("id_user") String id_user,
			@Param("status") String status);

}
