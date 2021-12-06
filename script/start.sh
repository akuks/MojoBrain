#!/bin/bash

# Start MySQL
/etc/init.d/mysql start

# Start Application
carton exec morbo script/mojo_brain &
