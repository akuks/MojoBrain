FROM perl
WORKDIR /opt/mojo_brain
COPY . .
RUN cpanm --installdeps -n .
EXPOSE 3000
CMD ./script/mojo_brain prefork
