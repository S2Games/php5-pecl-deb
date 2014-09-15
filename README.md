php5-pecl-deb
=============

Configs debian builds of php5 pecl modules to have useful postinst, prerm, etc. scripts.

Why
---

`dh-make-pecl` does not include sane postinst, prerm, etc. maintainer scripts. The dotdeb packages include scripts that enable/disable the module as it gets installed/removed. That's where this tool comes in, it puts those scripts into the package.

Use
---

Replace `[module]` with the module you want to build (e.g. redis).

```bash
dh-make-pecl --phpversion 5 --prefix php5- [module]
cd php5-[module]
/path/to/config.sh [module] ./debian
./debian/rules binary
```

Thanks
------

Thanks to [Guillaume Plessis](https://github.com/gplessis/) for his awesome work with [dotdeb](http://www.dotdeb.org) and creating the scripts these are based off.
