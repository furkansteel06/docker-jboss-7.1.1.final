# This is the Dockerfile for JBOSS AS 7.1.1.Final

FROM jboss/base:latest
LABEL maintainer="furkan.com.tr"

# Define JBOSS admin user and password
ENV ADMIN_USER admin
ENV ADMIN_PASSWORD furkan3

# User root user to install software
USER root

# Install necessary packages
RUN yum -y install java-1.6.0-openjdk
RUN yum clean all
COPY jboss-as-7.1.1.Finalv1.zip jboss-as-7.1.1.Finalv1.zip

# Switch back to jboss user
USER jboss

# Add the jboss as distribution
RUN cd $HOME \
    && unzip jboss-as-7.1.1.Finalv1.zip \
    && rm jboss-as-7.1.1.Finalv1.zip 

# Add admin user
RUN chmod +x /opt/jboss/jboss-as-7.1.1.Final/bin/add-user.sh
RUN /opt/jboss/jboss-as-7.1.1.Final/bin/add-user.sh --silent=true $ADMIN_USER $ADMIN_PASSWORD

# Expose ports   
EXPOSE 8080
EXPOSE 9990
RUN chmod +x /opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh
CMD ["/opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b=0.0.0.0", "-bmanagement=0.0.0.0"]
