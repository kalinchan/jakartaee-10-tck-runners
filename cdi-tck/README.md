# How to Run
-- prerequisite
Install cdi-tck-ext-lib to glassfish/domains/domain1/lib/applib


-- asadmin
start-domain
create-jms-resource --restype jakarta.jms.Queue --property Name=queue_test queue_test
create-jms-resource --restype jakarta.jms.Topic --property Name=topic_test topic_test
set configs.config.server-config.cdi-service.enable-implicit-cdi=true
create-file-user --groups student --passwordfile password.txt student
create-file-user --groups printer --passwordfile password.txt printer
create-file-user --groups student:alarm --passwordfile password.txt alarm


-- system properties
cdiTckExcludeDummy=true

-- run
mvn clean verify
