# Liferay 7 development environment

Based on: <https://github.com/mimacom/liferay-puppet-deployment>

## Overview

This is an example project to showcase the automated installation of a Liferay development/test environment. It uses VirtualBox and Vagrant for VM management and Puppet for provisioning.

## Setup

1. Clone this project.
2. Install VirtualBox: <https://www.virtualbox.org>
3. Install Vagrant: <http://www.vagrantup.com>
4. Change into the directory where this project was cloned.
5. Enter 'vagrant up'.
6. After all puppet modules are finished the fresh installed Liferay portal is available at: <http://localhost:4040>
7. To access your ubuntu box from the command line, type "vagrant ssh"
8. Liferay is installed at /opt/liferay/liferay-portal-7.0-ce-m4/

## Content

This project will install the following artifacts on a Ubuntu 12.04 box:

1. OpenJDK 7
2. MySQL
3. Liferay 6.2 CE bundled with Tomcat

## Notes

- It may be necessary to enable hardware virtualization (VT-x for Intel, AMD-V for AMD processors).
