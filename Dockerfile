FROM centos:7
RUN yum update -y 
RUN yum install java openjdk -y 
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.100/bin/apache-tomcat-8.5.100.tar.gz /opt
WORKDIR /opt
RUN tar -xzvf apache-tomcat-8.5.100.tar.gz -C /opt
WORKDIR /opt/apache-tomcat-8.5.100/bin/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war /opt/apache-tomcat-8.5.100/webapps/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar /opt/apache-tomcat-8.5.100/lib/
COPY context.xml /opt/apache-tomcat-8.5.100/conf/
ENV Name="Studentapp"
EXPOSE 8080
CMD [ "./catalina.sh","run" ]