
package com.trinhlequockhanh.cdweb.repository;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.trinhlequockhanh.cdweb.entities.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, String> {

	public List<Product> findByidshop(String idshop);
	@Query(value = "select p from Product p join Cart c on p.id = c.idproduct where p.idshop = :id_shop and c.delivereddate IS NOT NULL")
	List<Object> report(@Param("id_shop") String id_shop);

	@Query(value = "select p.name from Product p where p.id = :id")
	Optional<String> getName(@Param("id") String id);

	@Query(value = "select p.total from Product p where p.id = :id")
	Optional<Integer> getTotal(@Param("id") String id);

	@Query(value = "select p from Product p where p.brand = :brand")
	List<Product> getProductByBrand(@Param("brand") String brand);

	@Query(value = "select p from Product p where p.cost<50000")
	List<Product> getProductByCostL();

	@Query(value = "select p from Product p where p.cost between 50000 and 100000")
	List<Product> getProductByCostAVG();

	@Query(value = "select p from Product p where p.cost>100000")
	List<Product> getProductByCostG();

	@Query(value = "select distinct p.brand from Product p")
	List<String> getBrand();

	@Query(value = "select sum(c.total*p.cost) from Product p join Cart c on p.id = c.idproduct where p.idshop = :id_shop and c.orderdate IS NOT NULL and c.delivereddate between :date_start and :date_end")
	BigDecimal reportByTime(@Param("id_shop") String id_shop, @Param("date_start") Date date_start,
			@Param("date_end") Date date_end);

	@Query(value = "select DISTINCT p.name from Product p")
	List<Object> getNameList();

	@Query(value = "select DISTINCT p.type from Product p")
	List<Object> getTypeList();

	// Danh sách sản phẩm bán chạy
	@Query(value = "select p from Product p join Cart c on p.id = c.idproduct order by c.total DESC")
	List<Object> getProductBestSales();

	// Danh sách sản phẩm được xem nhiều nhất
	@Query(value = "select p from Product p order by p.views DESC")
	List<Object> getProductMostView();

	// Danh sách sản phẩm mới nhất
	@Query(value = "select p from Product p order by p.date_add DESC")
	List<Object> getProductNew();

	// Danh sách sản phẩm mới nhất
	@Query(value = "select p from Product p where p.description like %:search% order by p.date_add DESC")
	List<Object> getSearch(@Param("search") String search);

	// Danh sách sản phẩm theo giá tăng dần
	@Query(value = "select p from Product p order by p.cost")
	List<Product> getProductASC();

	// Danh sách sản phẩm theo giá giảm dần
	@Query(value = "select p from Product p order by p.cost DESC")
	List<Product> getProductDESC();

	// Danh sách sản phẩm theo lượt mua giảm dần
	@Query(value = "select p from Product p join Cart c on p.id = c.idproduct where c.orderdate IS NOT NULL and c.delivereddate IS NOT NULL order by c.total DESC")
	List<Product> getProductSaleDESC();

	// Danh sách sản phẩm theo lượt mua tăng dần
	@Query(value = "select p from Product p join Cart c on p.id = c.idproduct where c.orderdate IS NOT NULL and c.delivereddate IS NOT NULL order by c.total")
	List<Product> getProductSaleASC();

	// Số lượt bán
	@Query(value = "select c.total from  Cart c join Product p on p.id = c.idproduct where p.id=:id and c.orderdate IS NOT NULL and c.delivereddate IS NOT NULL")
	List<Integer> getProductSaledById(@Param("id") String id);

}
