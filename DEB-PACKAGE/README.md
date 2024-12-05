# ___Binary deb package___

## ___Description___

This is a binary deb package for AppArmor.

## ___Features___

- ```DEBIAN``` - include files that describe the structure of the deb package.
    - DEBIAN/control - include the package name, version, maintainer, and other information.
    - DEBIAN/changelog - include the changelog of the package.
    - DEBIAN/copyright - include the copyright information of the package.
    - DEBIAN/postinst - include the post-installation script of the package.
    - DEBIAN/postrm - include the post-removal script of the package. 
    - DEBIAN/preinst - include the pre-installation script of the package.
- ```etc```- include the configuration files of the package.
    - etc/apparmor.d - include the AppArmor configuration files.

## ___Installation___

In order to build a deb package, you need to follow these steps

```bash
fakeroot dpkg-deb --build DEB-PACKAGE
```

The created package must be renamed to match the naming order of the *.deb packages: 
```bash
<package name>_<version>_<architecture>.deb
```

Our deb package can be installed for all the supported architectures:

```bash
mv ./DEB-PACKAGE.deb ./apparmor-profiles-1.0.1-main-all.deb
```

After that, we can install the package with the following command:

```bash
apt-get install apparmor-profiles-1.0.1-main-all.deb
```


## ___Other___

For more information, please refer to the official documentation of the deb package.

Also, you can find more information about the deb package in [web-site](https://habr.com/ru/articles/78094/?code=335a2372b164ab8acd94d321654f48bb&state=ihNXbMEXXxWuzP0zlDiioiGD&hl=ru).
