COPY ./fs/java-war-machine /
RUN <<CONFIGURE_WAR_MACHINE
    # Fix ownership & execution of service scripts
    sv-fix-perms
CONFIGURE_WAR_MACHINE