zabbix-freebsd-iostat
=======================

Zabbix template for disks monitoring by iostat.

Installation
------------
1. Copy iostat.conf to a directory /usr/local/zabbix/etc/zabbix_agentd.conf.d
2. Copy iostat.conf and scripts to a directory /usr/local/zabbix/libexec/zabbix-extensions
3. Make sure the scripts can be executed.
4. Add a line to zabbix_agentd.conf: "Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/*.conf".
5. 
5. Import iostat-template.xml as zabbix template.

Testing
-------
```
zabbix_get -s hostname -k iostat.discovery
zabbix_get -s hostname -k iostat.collect
zabbix_get -s hostname -k iostat.metric['<device name>',<parameter>]
```

Items
-----
* r/s - read	operations per second
* w/s - write operations per	second
* kr/s - kilobytes read per second
* kw/s - kilobytes write per second
* qlen - transactions	queue length
* svc_t - average duration of transactions, in	milliseconds
* %b - % of	time the device	had one	or more	outstanding transactions
