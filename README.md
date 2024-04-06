## Deploying Studentapp on Docker Using Amazon RDS Mysql Database

This App basic workflow is in which one student can register and his data is stored in mysql database ...

## 1.Clone This Repo
```bash
https://github.com/VishalRepoWizard/Deployement-studentapp-docker.git
```

## 2.Launch a RDS instance with mysql put username and password

- Then install mysql and docker in your instance
```bash
sudo apt-get update -y
sudo apt install mysql-server -y
```
- Install docker using offical docker documentation https://docs.docker.com/engine/install

## 3.When RDS database is Active then click on 
Actions
- Then click on Set up EC2 connection
- Then select the instance which you are using 
- Click ok 
- Now You can access mysql using below command
```bash
mysql -h <mention_rds_databse_endpoint_link> -u admin -p
```
- Then enter password you have used to create RDS instance

## 4.Make changes

- make change as mention below in context.xml
  - Replace your database username where i have "admin"
  - Replace your database password where i have "admin123"
  - Replace your database name up here where i have "studentapp"
  - Replace your database endpoint where i have placed "<database-1.cp86kgyw8hi1.ap-south-1.rds.amazonaws.com" [hint see line starting with "url=" ]

```bash
<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource"
         username="<admin>"   
         password="<admin123>" 
         driverClassName="com.mysql.jdbc.Driver"     
         url="jdbc:mysql://"<database-1.cp86kgyw8hi1.ap-south-1.rds.amazonaws.com>":3306/ "studentapp"?useUnicode=true&amp;characterEncoding=utf8" 
         maxTotal="25"
         maxIdle="10"
         defaultTransactionIsolation="READ_COMMITTED"
         validationQuery="Select 1" />
```
Update the context.xml

## 5.Execute the below step

1.first go in clone git repository

```bash
cd docker-studentapp-docker
```
2.then Create a docker image out of it using command
```bash
sudo docker build -t studentapp . 
```
3.then check images
```bash
sudo docker images
```
- output of above command
image name studentapp will be created   
REPOSITORY   TAG       IMAGE ID     CREATED         SIZE

studentapp  latest    f88107ad7dee   6 seconds ago   1.03GB

4.now run conatiner using the studentapp image
```bash
sudo docker run -d -P studentapp
```
5.then check for which random port we should access the app using 
```bash
sudo docker ps
```
- output of above command
CONTAINER ID   IMAGE COMMAND   CREATED  STATUS   PORTS     NAMES

683b8da32d04   studentapp   "./catalina.sh run"      21 minutes ago   Up 21 minutes   0.0.0.0:32770->8080/tcp, :::32770->8080/tcp   sad_dhawan

it is showing external port as 32770 

6.just take public ip of your instance 
```bash
<ip-of-your-instance>:32770
```
Then you will be able to see your app 

7.after this you can push your studentapp images to dockerhub
```bash
sudo docker login
```
8.retag the studentapp image  using
```bash
sudo docker tag studentapp <username-of-your-dokcerhub>/studentapp:v1
```

9.check images using
```bash
sudo docker images
``` 

- IMPORATNT TO REMEMBER:- THE IMAGE NAME AND DOCKER HUB REPOSITORY NAME SHOULD BE SAME THEN ONLY IT WILL PUSH IMAGE TO DOCKERHUB ......

10.push docker image to dockerhub using
```bash
sudo docker push <username-of-your-dokcerhub>/studentapp:v1
```

- then login to docker hub and see the new image studentapp is present under the repository 
name "vishalrajput0502/studentapp"

- After your project is completed delete the RDS instance 
