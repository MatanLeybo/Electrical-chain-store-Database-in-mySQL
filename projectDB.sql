CREATE SCHEMA electric_shop_data;
use electric_shop_data;


/*----------------------------------------------tables---------------------------------------------------*/ 

CREATE TABLE store (
  store_ID INT NOT NULL,
  city VARCHAR(100),
  streat VARCHAR(100),
  streat_num INT,
  OP_time time,
  CLS_time time,
  manager_ID INT,
  PRIMARY KEY (store_ID))
ENGINE = InnoDB;

CREATE TABLE warehouse (
 warehouse_ID INT NOT NULL,
 MNG_ID int,
 area float,
 SID INT,
  PRIMARY KEY (warehouse_ID),
  CONSTRAINT fk_SID FOREIGN KEY (SID) REFERENCES store (store_ID)
)ENGINE = InnoDB;

CREATE TABLE department (
 department_NUM INT NOT NULL,
 storeID INT,
 Dname VARCHAR(100),
 area float, 
  PRIMARY KEY (department_NUM,storeID),
    CONSTRAINT fk_storeID   FOREIGN KEY (storeID)  REFERENCES store (store_ID))
ENGINE = InnoDB;

CREATE TABLE store_sales_destination (
 SID INT NOT NULL,
 mon VARCHAR(10),
 dest float,
  PRIMARY KEY (SID,mon),
    CONSTRAINT fk_dest  FOREIGN KEY (SID)  REFERENCES store (store_ID))
ENGINE = InnoDB;


CREATE TABLE employee (
 employee_ID INT NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 city VARCHAR(100),
 streat VARCHAR(100),
 streat_num INT,
 DoB DATE,
 hire_date DATE,
 PNum int,
 position VARCHAR(20),
 salary float,
 storeID int,
  PRIMARY KEY (employee_ID),
    CONSTRAINT fk_storeEMP FOREIGN KEY (storeID)  REFERENCES store (store_ID)
)ENGINE = InnoDB;

CREATE TABLE salesman (
 salesmanID INT NOT NULL,
 DP_spc VARCHAR(50),
 BonusP float,
 PRIMARY KEY (salesmanID),
 CONSTRAINT fk_salesmanID FOREIGN KEY (salesmanID) REFERENCES employee (employee_ID)
 )ENGINE=InnoDB;
 
 CREATE TABLE warehouse_worker (
 wworkerID INT NOT NULL,
 wrank VARCHAR(10),
 PRIMARY KEY (wworkerID),
 CONSTRAINT fk_wworkerID FOREIGN KEY (wworkerID) REFERENCES employee (employee_ID)
 )ENGINE=InnoDB;
 
 CREATE TABLE supplier (
 supplier_ID INT NOT NULL,
 supplier_name VARCHAR(100),
 supplier_PNum INT,
 CO_date DATE,
 S_status VARCHAR(20),
 PRIMARY KEY (supplier_ID)
 )ENGINE=InnoDB;
 
 CREATE TABLE product (
  product_ID INT NOT NULL,
  product_name VARCHAR(100),
  product_type VARCHAR(100),
  price FLOAT,
  special_price FLOAT NULL DEFAULT NULL,
  occupancy float,
  manufacturer VARCHAR(100),
  SID INT,
  Dnum INT,
  supplierID INT,
  PRIMARY KEY (product_ID),
  CONSTRAINT fk_PDnum FOREIGN KEY (Dnum) REFERENCES department (department_NUM),
  CONSTRAINT fk_PSID FOREIGN KEY (SID) REFERENCES store (store_ID),
  CONSTRAINT fk_supplierID FOREIGN KEY (supplierID) REFERENCES supplier (supplier_ID)
)ENGINE = InnoDB;

CREATE TABLE stock_department (
Dnum INT NOT NULL,
SID INT NOT NULL,
PID INT NOT NULL,
check_date DATE NOT NULL,
quantity int,
PRIMARY KEY (Dnum,SID,PID,check_date),
CONSTRAINT fk_Dnum FOREIGN KEY (Dnum) REFERENCES department (department_num),
CONSTRAINT fk_stock_SID FOREIGN KEY (SID) REFERENCES store (store_ID),
CONSTRAINT fk_stock_PID FOREIGN KEY (PID) REFERENCES product (product_ID)
)ENGINE = InnoDB;

CREATE TABLE stock_warehouse (
WID INT NOT NULL,
PID INT NOT NULL,
check_date DATE NOT NULL,
quantity int,
PRIMARY KEY (WID,PID,check_date),
CONSTRAINT fk_PID FOREIGN KEY (PID) REFERENCES product (product_ID),
CONSTRAINT fk_stock_warehouse FOREIGN KEY (WID) REFERENCES warehouse (warehouse_ID)
)ENGINE = InnoDB;

CREATE TABLE order_supply (
 order_ID INT NOT NULL,
 date_of_order DATE,
 workerID INT,
 PRIMARY KEY (order_ID),
 CONSTRAINT chk_workerID check(workerID=304951492),
 CONSTRAINT fk_workerID FOREIGN KEY (workerID) REFERENCES warehouse_worker (wworkerID)
 )ENGINE=InnoDB;
 
 CREATE TABLE order_lines (
 order_ID INT NOT NULL,
 product_ID INT,
 quantity INT,
 supplier_ID INT,
 PRIMARY KEY (order_ID,product_ID),
   CONSTRAINT fk_order_ID  FOREIGN KEY (order_ID) REFERENCES order_supply (order_ID),
   CONSTRAINT fk_product_ID FOREIGN KEY (product_ID) REFERENCES product (product_ID),
    CONSTRAINT fk_supplier_ID FOREIGN KEY (supplier_ID) REFERENCES supplier (supplier_ID)
 )ENGINE=InnoDB;
 
 CREATE TABLE customer (
 customer_ID INT NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 city VARCHAR(100),
 streat VARCHAR(100),
 streat_num INT,
 PNum INT,
 PRIMARY KEY (customer_ID)
 )ENGINE=InnoDB;
 
 CREATE TABLE sale (
 sale_ID INT NOT NULL,
 DOSale DATE,
 customer_ID INT,
 salesmanID INT,
 PRIMARY KEY (sale_ID),
 CONSTRAINT fk_customer_ID FOREIGN KEY (customer_ID) REFERENCES customer (customer_ID),
  CONSTRAINT fk_SsalesmanID FOREIGN KEY (salesmanID) REFERENCES salesman (salesmanID)
 )ENGINE=InnoDB;
 
  CREATE TABLE sale_detail (
  sale_ID INT NOT NULL,
  product_ID INT NOT NULL,
  quantity INT,
  unit_price FLOAT,
  total_price FLOAT default null,
 PRIMARY KEY (sale_ID,product_ID),
 CONSTRAINT fk_sale_ID FOREIGN KEY (sale_ID) REFERENCES sale (sale_ID),
 CONSTRAINT fk_sale_product FOREIGN KEY (product_ID) REFERENCES product (product_ID)
 )ENGINE=InnoDB;
 

/*-----------------------------------------------------inserts--------------------------------------------------*/ 


/*store*/ 
INSERT INTO `electric_shop_data`.`store` (`store_ID`, `city`, `streat`, `streat_num`, `OP_time`, `CLS_time`, `manager_ID`) VALUES ('2020', 'tel-aviv', 'Haganim', '19', '09:00', '18:00', '20201'); 

/*store_dest*/ 
INSERT INTO `electric_shop_data`.`store_sales_destination` (`SID`, `mon`, `dest`) VALUES ('2020', 'JAN', '20000');
INSERT INTO `electric_shop_data`.`store_sales_destination` (`SID`, `mon`, `dest`) VALUES ('2020', 'FEB', '10000');
INSERT INTO `electric_shop_data`.`store_sales_destination` (`SID`, `mon`, `dest`) VALUES ('2020', 'MAR', '10000');
INSERT INTO `electric_shop_data`.`store_sales_destination` (`SID`, `mon`, `dest`) VALUES ('2020', 'APR', '30000');

/*department*/ 
INSERT INTO `electric_shop_data`.`department` (`department_NUM`, `storeID`, `Dname`, `area`) VALUES ('1', '2020', 'TV', '50');
INSERT INTO `electric_shop_data`.`department` (`department_NUM`, `storeID`, `Dname`, `area`) VALUES ('2', '2020', 'Smartphones', '30');
INSERT INTO `electric_shop_data`.`department` (`department_NUM`, `storeID`, `Dname`, `area`) VALUES ('3', '2020', 'Kitchen', '100');
INSERT INTO `electric_shop_data`.`department` (`department_NUM`, `storeID`, `Dname`, `area`) VALUES ('4', '2020', 'Laundry', '100');
INSERT INTO `electric_shop_data`.`department` (`department_NUM`, `storeID`, `Dname`, `area`) VALUES ('5', '2020', 'Gaming', '50');
INSERT INTO `electric_shop_data`.`department` (`department_NUM`, `storeID`, `Dname`, `area`) VALUES ('6', '2020', 'Sound', '40');



/*employee*/ 
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951486', 'YOSSI', 'COHEN', 'tel-aviv', 'florentin', '19', '1985/06/19', '2015/06/08', '8060', 'MNG', '24000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951487', 'BAROH', 'COHEN', 'petah-tikva', 'habrosh', '10', '1992/06/02', '2019/09/09', '888', 'salesman', '10000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951488', 'SHLOMI', 'LEVI', 'tel-aviv', 'alenbi', '109', '1990/04/9', '2020/12/01', '2090', 'salesman', '9000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951489', 'RAMI', 'ROBERTO', 'tel-aviv', 'fisherman', '1', '1994/12/11', '2021/01/02', '505', 'salesman', '12000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951490', 'DANIEL', 'ASULIN', 'rehovot', 'rabin', '88', '1990/01/12', '2020/01/12', '504', 'salesman', '6000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951491', 'MIRI', 'TOLOLO', 'tel-aviv', 'rotchild', '204', '1990/02/01', '2020/06/13', '30', 'salesman', '6000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951492', 'MOSHE', 'FRID', 'ramat-gan', 'dli', '7', '1985/01/16', '2014/06/20', '50204', 'warehouseMNG', '18000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951493', 'SHARON', 'GREENBERG', 'ramat-gan', 'samuel', '27', '1991/06/15', '2021/04/02', '4444', 'worker', '6000', '2020');
INSERT INTO `electric_shop_data`.`employee` (`employee_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `DoB`, `hire_date`, `PNum`, `position`, `salary`, `storeID`) VALUES ('304951494', 'MOTI', 'SALAMTAK', 'tel-aviv', 'bnei-efrahim', '111', '1989/11/04', '2021/04/02', '7425', 'worker', '6000', '2020');


/*salesman*/ 
INSERT INTO `electric_shop_data`.`salesman` (`salesmanID`, `DP_spc`, `BonusP`) VALUES ('304951487', 'TV and Sound', '0.06');
INSERT INTO `electric_shop_data`.`salesman` (`salesmanID`, `DP_spc`, `BonusP`) VALUES ('304951488', 'KITCHEN', '0.06');
INSERT INTO `electric_shop_data`.`salesman` (`salesmanID`, `DP_spc`, `BonusP`) VALUES ('304951489', 'Loundry', '0.06');
INSERT INTO `electric_shop_data`.`salesman` (`salesmanID`, `DP_spc`, `BonusP`) VALUES ('304951490', 'Gaming', '0.06');
INSERT INTO `electric_shop_data`.`salesman` (`salesmanID`, `DP_spc`, `BonusP`) VALUES ('304951491', 'Smartphones', '0.06');

/*warehouse*/ 
INSERT INTO `electric_shop_data`.`warehouse` (`warehouse_ID`, `MNG_ID`, `area`, `SID`) VALUES ('12020', '120205', '1000', '2020');


/*warehouse_worker*/ 
INSERT INTO `electric_shop_data`.`warehouse_worker` (`wworkerID`, `wrank`) VALUES ('304951492', 'MNG');
INSERT INTO `electric_shop_data`.`warehouse_worker` (`wworkerID`, `wrank`) VALUES ('304951493', 'worker');
INSERT INTO `electric_shop_data`.`warehouse_worker` (`wworkerID`, `wrank`) VALUES ('304951494', 'worker');
 
/*supplier*/ 
INSERT INTO `electric_shop_data`.`supplier` (`supplier_ID`, `supplier_name`, `supplier_PNum`, `CO_date`, `S_status`) VALUES ('3234', 'TAMUZ', '0394523', '2019/08/08', 'good');
INSERT INTO `electric_shop_data`.`supplier` (`supplier_ID`, `supplier_name`, `supplier_PNum`, `CO_date`, `S_status`) VALUES ('3235', 'GMS', '03958741', '2020/08/17', 'good');
INSERT INTO `electric_shop_data`.`supplier` (`supplier_ID`, `supplier_name`, `supplier_PNum`, `CO_date`, `S_status`) VALUES ('3236', 'sunny', '09777', '2016/01/01', 'conditional');
INSERT INTO `electric_shop_data`.`supplier` (`supplier_ID`, `supplier_name`, `supplier_PNum`, `CO_date`, `S_status`) VALUES ('3237', 'newpan', '5050505', '2020/02/04', 'good');

/*product*/ 
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('111', 'Samsung UE55TU8000 4K ‏55', 'LED', '2300', '2', 'SAM', '2020', '1', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('112', 'LG 55UP7550PVG 4K ‏55', 'LED', '2500', '2', 'LG', '2020', '1', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('113', 'Samsung QE50Q60T 4K ‏50', 'QLED', '2400', '1.5', 'SAM', '2020', '1', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('114', 'Xiaomi L43M5-5ASP 4K ‏43', 'LED', '1500', '1', 'XIA', '2020', '1', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `special_price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('115', 'LG OLED48C1PVB 4K ‏48', 'OLED', '5200', '5100', '1.8', 'LG', '2020', '1', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('116', 'Apple iPhone 12 Pro 128GB', 'Smartphone', '4300', '0.2', 'APP', '2020', '2', '3235');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `special_price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('117', 'Samsung Galaxy Z Fold3', 'Smartphone', '6300', '6100', '0.2', 'SAM', '2020', '2', '3236');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('118', 'ONEPLUS 9 Morning Mist 8+128GB', 'Smartphone', '3800', '0.2', 'ONE', '2020', '2', '3236');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('119', 'Asus ROG Phone 5 256GB', 'Smartphone', '4000', '0.2', 'ASS', '2020', '2', '3236');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('120', 'HAIER HRF-457FB 4 doors', 'refrigerator', '3300', '2', 'HAIER', '2020', '3', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('121', 'HBA3140S0 white bosh', 'oven', '1900', '1', 'bosh', '2020', '3', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `special_price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('122', 'Hamilton Beach 2 Slice Extra Wide', 'Toaster', '100', '70', '0.3', 'HAM', '2020', '3', '3237');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('123', 'Ninja BL610 Professional 72 Oz', 'Blender', '400', '0.4', 'NIN', '2020', '3', '3237');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('124', 'washing machine 7 kg WAJ2006GPL', 'washing machine', '1400', '0.7', 'bosh', '2020', '4', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('125', 'washing machine 8kg WAJ2009GPL', 'washing machine', '1800', '0.7', 'bosh', '2020', '4', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('126', 'T6DBG28W AEG 8 Kkg', 'Laundry Dryer', '1600', '0.7', 'AEG', '2020', '4', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('127', 'Professional Grade 1700W Steam Iron', 'Steam Iron', '500', '0.2', 'TFL', '2020', '4', '3237');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('128', 'xbox series X', 'console', '2000', '0.5', 'MICRO', '2020', '5', '3235');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('129', 'PS5', 'console', '3000', '0.5', 'SONY', '2020', '5', '3235');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('130', 'Acer Predator XB3', 'monitor', '3000', '1', 'ACR', '2020', '5', '3234');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('131', 'Samsung HW-A450', 'soundbar', '600', '1', 'SAM', '2020', '6', '3236');
INSERT INTO `electric_shop_data`.`product` (`product_ID`, `product_name`, `product_type`, `price`, `occupancy`, `manufacturer`, `SID`, `Dnum`, `supplierID`) VALUES ('132', 'JBL FLIP 4', 'speaker', '400', '0.3', 'JBL', '2020', '6', '3237');


/*stock_department*/ 
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('1', '2020', '111', '2021-04-04', '8');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('1', '2020', '112', '2021-04-04', '8');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('1', '2020', '113', '2021-04-04', '8');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('1', '2020', '114', '2021-04-04', '8');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('1', '2020', '115', '2021-04-04', '8');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('2', '2020', '116', '2021-04-03', '10');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('2', '2020', '117', '2021-04-03', '10');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('2', '2020', '118', '2021-04-03', '10');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('2', '2020', '119', '2021-04-03', '10');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('3', '2020', '120', '2021-04-04', '1');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('3', '2020', '121', '2021-04-04', '1');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('3', '2020', '122', '2021-04-04', '1');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('3', '2020', '123', '2021-04-04', '0');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('4', '2020', '124', '2021-04-04', '1');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('4', '2020', '125', '2021-04-04', '1');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('4', '2020', '126', '2021-04-04', '1');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('4', '2020', '127', '2021-04-04', '10');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('5', '2020', '128', '2021-04-04', '5');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('5', '2020', '129', '2021-04-04', '4');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('5', '2020', '130', '2021-04-04', '2');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('6', '2020', '131', '2021-04-04', '5');
INSERT INTO `electric_shop_data`.`stock_department` (`Dnum`, `SID`, `PID`, `check_date`, `quantity`) VALUES ('6', '2020', '132', '2021-04-04', '20');




/*stock_warehouse*/ 
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '111', '2021-4-3', '4');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '112', '2021-4-3', '10');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '113', '2021-4-3', '10');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '114', '2021-4-3', '10');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '115', '2021-4-3', '1');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '116', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '117', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '118', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '119', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '120', '2021-4-3', '5');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '121', '2021-4-3', '5');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '122', '2021-4-3', '50');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '123', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '124', '2021-4-3', '6');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '125', '2021-4-3', '6');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '126', '2021-4-3', '5');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '127', '2021-4-3', '60');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '128', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '129', '2021-4-3', '20');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '130', '2021-4-3', '10');
INSERT INTO `electric_shop_data`.`stock_warehouse` (`WID`, `PID`, `check_date`, `quantity`) VALUES ('12020', '131', '2021-4-3', '10');




/*customer*/  
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `PNum`) VALUES ('60001', 'DINA', 'LEYBO', 'tel-aviv', 'florentin', '22', '909');
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `PNum`) VALUES ('60002', 'MOSHE', 'SIX', 'tel-aviv', 'habrosh', '22', '505');
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `PNum`) VALUES ('60003', 'SETH', 'ROGAN', 'tel-aviv', 'alenbi', '155', '508');
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `PNum`) VALUES ('60004', 'MIRI', 'BEN-HEMO', 'tel-aviv', 'fisherman', '99', '507');
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `PNum`) VALUES ('60005', 'ABU', 'YOSEF', 'KVAR-YASIF', '5088');
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `PNum`) VALUES ('60006', 'KING', 'RICHARD', 'HOD-HASHARON', 'rotchild', '7', '5055');
INSERT INTO `electric_shop_data`.`customer` (`customer_ID`, `first_name`, `last_name`, `city`, `streat`, `streat_num`, `PNum`) VALUES ('60007', 'NILI', 'KEKLOVICH', 'HAIFA', 'dli', '14', '507');


/*sale*/  
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1818', '2021/01/01', '60001', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1819', '2021/01/01', '60002', '304951487');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1820', '2021/01/07', '60001', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1821', '2021/01/07', '60002', '304951487');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1822', '2021/01/07', '60003', '304951489');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1823', '2021/02/02', '60003', '304951490');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1824', '2021/02/04', '60004', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1825', '2021/02/04', '60005', '304951490');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1826', '2021/02/04', '60007', '304951491');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1827', '2021/03/02', '60005', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1828', '2021/03/02', '60007', '304951489');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1829', '2021/03/04', '60001', '304951491');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1830', '2021/03/12', '60002', '304951491');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1831', '2021/04/02', '60004', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1832', '2021/04/02', '60001', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1833', '2021/04/03', '60005', '304951489');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1834', '2021/04/03', '60006', '304951490');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1835', '2021/04/03', '60007', '304951490');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1836', '2021/04/03', '60004', '304951491');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1837', '2021/04/03', '60002', '304951488');
INSERT INTO `electric_shop_data`.`sale` (`sale_ID`, `DOSale`, `customer_ID`, `salesmanID`) VALUES ('1838', '2021/04/04', '60001', '304951487');



/*sale_detail*/  
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1818', '111', '2', '2300', '4600');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1818', '120', '1', '3300', '3300');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1819', '128', '1', '2000', '2000');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1820', '129', '2', '3000', '6000');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1821', '132', '4', '400', '1600');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1822', '118', '1', '3800', '3800');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1823', '124', '1', '1400', '1400');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1823', '125', '1', '1800', '1800');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1824', '115', '1', '5100', '5100');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1825', '131', '1', '600', '600');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1825', '118', '1', '3800', '3800');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1826', '113', '1', '2400', '2400');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1827', '112', '1', '2500', '2500');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1827', '130', '2', '3000', '6000');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1827', '123', '1', '400', '400');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1828', '121', '1', '1900', '1900');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1829', '121', '1', '1900', '1900');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1830', '121', '1', '1900', '1900');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1831', '128', '1', '2000', '2000');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1832', '117', '1', '6100', '6100');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1833', '128', '1', '2000', '2000');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1834', '122', '2', '100', '200');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1835', '122', '1', '100', '100');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1836', '122', '2', '100', '200');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1837', '121', '1', '1900', '1900');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1838', '115', '1', '5200', '5200');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1838', '117', '1', '6100', '6100');
INSERT INTO `electric_shop_data`.`sale_detail` (`sale_ID`, `product_ID`, `quantity`, `unit_price`, `total_price`) VALUES ('1838', '129', '2', '3000', '6000');



/*order_supply*/  
INSERT INTO `electric_shop_data`.`order_supply` (`order_ID`, `date_of_order`, `workerID`) VALUES ('2144', '21-4-4', '304951492');
INSERT INTO `electric_shop_data`.`order_supply` (`order_ID`, `date_of_order`, `workerID`) VALUES ('2143', '21-4-3', '304951492');
INSERT INTO `electric_shop_data`.`order_supply` (`order_ID`, `date_of_order`, `workerID`) VALUES ('2142', '21-4-2', '304951492');
INSERT INTO `electric_shop_data`.`order_supply` (`order_ID`, `date_of_order`, `workerID`) VALUES ('2141', '21-4-1', '304951492');
INSERT INTO `electric_shop_data`.`order_supply` (`order_ID`, `date_of_order`, `workerID`) VALUES ('21330', '21-3-30', '304951492');


/*order_lines*/  
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2144', '115', '8', '3234');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2144', '111', '6', '3234');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2144', '120', '1', '3234');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2144', '121', '1', '3234');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2143', '131', '10', '3237');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2142', '121', '3', '3234');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2142', '123', '10', '3237');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2142', '116', '10', '3235');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('2142', '128', '5', '3236');
INSERT INTO `electric_shop_data`.`order_lines` (`order_ID`, `product_ID`, `quantity`, `supplier_ID`) VALUES ('21330', '130', '2', '3234');





/*--------------------------------------------------SQL's-------------------------------------------*/


/*כמות המחלקות וכמות העובדים בחנות*/
SELECT S.store_id , count(distinct E.employee_ID) as employees_num
, count(distinct D.department_NUM) as departments_num
FROM employee E, store S, department D
where E.storeID=S.store_ID and D.storeID=S.store_ID;

/*המוצר היקר ביותר בכל מחלקה*/
SELECT Dnum, product_ID, product_name
FROM product
where price in (select max(price) from product group by Dnum);

/*אחוז העמלה שאותה מקבל איש המכירות ברוך כהן*/
select SM.BonusP
from salesman SM, employee E
where E.employee_ID = SM.salesmanID AND E.first_name like "%BAROH%"  AND E.last_name like "%COHEN%";

/* המוצרים הנמכרים ביותר בחודש אפריל בסדר יורד*/
 select P.product_ID,P.product_name, sum(SD.quantity) as units_sold
 from Sale S, sale_detail SD, product P 
 where S.sale_ID=SD.sale_ID and SD.product_ID=P.product_ID and month(S.DOsale) = 4 
 group by SD.product_ID
 order by units_sold desc;
 

 /* 3 אנשי המכירות שמכרו הכי הרבה בחודש אפריל*/
 select E.first_name,E.last_name , sum(SD.total_price) as total_sailes
 from sale_detail SD, sale S, salesman SM, product P, employee E  
 where S.sale_ID=SD.sale_ID and SD.product_ID=P.product_ID and SM.salesmanID=S.salesmanID 
 and SM.salesmanID=E.employee_ID  and month(S.DOsale) = 4
 group by SM.salesmanID
 order by total_sailes desc
 limit 3;

 /*רשימת הספקים שכרגע מבצעים יותר מהזמנה אחת והסטטוס שלהם תקין*/
SELECT S.supplier_ID, COUNT(OL.Order_ID) as numoforders
FROM order_supply OS, order_lines OL , supplier S, product P
where OS.order_ID = OL.order_ID and P.product_ID = OL.product_ID 
and S.supplier_ID = P.supplierID and S.s_status like "good"         
GROUP BY S.supplier_ID
HAVING COUNT(OL.Order_ID) > 1 ;


  /* אחוז יעד המכירות יחסית למכירות בפועל של חודש מרץ*/
 select distinct SSD.Mon, SSD.dest, sum(SD.total_price) as total_sales , ((sum(SD.total_price) *100)/SSD.dest) as precent_of_dest
 from store_sales_destination SSD, sale_detail SD, sale S
 where S.sale_ID=SD.sale_ID  and month(s.dosale) = 3 and SSD.mon like "mar"  and SSD.dest <
 (
 select sum(sd.total_price) 
 from sale_detail SD , sale S
 where SD.sale_id=S.sale_id and month(S.dosale) = 3
 group by month(S.dosale)
 );


 
/* כמה עמלה הרוויח העובד שמתמחה במוצרים למטבח בשני לרביעי*/ 
select E.employee_ID, E.first_name, E.last_name, round(sum(SD.total_price)*SM.BonusP, 2) as Bonus
from salesman SM, employee E, sale S, sale_detail SD
where E.employee_ID = SM.salesmanID AND S.sale_ID=SD.sale_ID and DP_spc like "KITCHEN" 
and DOsale = "2021-04-02";


SELECT City FROM Customer
union
SELECT City FROM employee
ORDER BY City;


/* כמה שטח במחסן משמש לאחסון מלאי*/
SELECT W.warehouse_ID, W.area, round(sum(P.occupancy*SW.quantity),2) as occuppied_area
from stock_warehouse SW, product P, warehouse W
where SW.WID=W.warehouse_ID and SW.PID=P.product_ID and (P.product_ID,P.occupancy) in
(
select product_ID , occupancy from product 
);

/* אילו מוצרים כרגע במבצע? כמה הנחה מקבלים?*/
 select product_ID, product_name, price, price - special_price as Discount 
 from product
 where special_price is not null;
 
 
 
 /* איזה לקוח קנה הכי הרבה פריטים בחנות מאז ומעולם*/
 select C.customer_ID, C.first_name, C.last_name, sum(quantity) as items_bought
 from customer C,sale S, sale_detail SD, product P 
 where S.sale_ID=SD.sale_ID and SD.product_ID=P.product_ID and C.customer_ID=S.customer_ID and S.customer_ID =
 (
 select S.customer_ID
 from customer C,sale S,sale_detail SD, product P 
 where S.sale_ID=SD.sale_ID and SD.product_ID=P.product_ID and C.customer_ID=S.customer_ID
 group by S.customer_ID, SD.quantity
 order by count(SD.product_ID) desc
 limit 1);


/*-----------------------------------------------------INSERT/UPDATE/DELETE--------------------------------------------------*/ 
 
/*למנהל*/ 
UPDATE product SET special_price = '2000' WHERE (product_ID = '129'); 
UPDATE salesman SET DP_spc = 'TV', BonusP = '0.07' WHERE (salesmanID = '304951487'); 

/*עובדים*/ 
/* נקבל פה שגיאה מכוונת מאחר ומי שהזמין הוא לא מנהל המחסן*/
INSERT INTO order_supply (order_ID, date_of_order, workerID) VALUES ('2146', '2021-04-05', '304951493');
/* כאן זה תקין*/
INSERT INTO order_supply (order_ID, date_of_order, workerID) VALUES ('2146', '2021-04-05', '304951492');
INSERT INTO order_lines (order_ID, product_ID, quantity, supplier_ID) VALUES ('2146', '131', '1','3237');

DELETE FROM sale_detail WHERE sale_id=1838 and product_id=117;
 
 
 
 



 
 

 
 
 
 
 
 
 
 
 