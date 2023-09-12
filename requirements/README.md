# MISP Instance requirements

<!-- toc -->

## Intro

There are various ways you can run a MISP instance.

- Virtualized with docker/ansible/packer etc
- VMware/Virtualbox/Xen etc
- Dedicated hardware
- Road warrior setups
- Air-gapped setups

Whilst there is never an ultimate answer to what specifications a system needs, we try to give an approximate answer depending on your use case.

## The biggie

Having millions of events with millions of attributes (indicators) will eventually result in sub-par performance.
Ideally you have millions of attributes and thousands of events. But this also depends on how you ingest the data.
With millions of attributes a bottleneck could be the correlation engine.
Especially if you have many duplicates in your events. (Use the feed matrix to see if feeds are massively overlapping)

# Sizing your MISP instance

Sizing a MISP instance highly depends on how the instance will be used. The number of users, data ingested, data points used, number of events, number of correlations and API usage are all parameters which should be considered while sizing your instance.

From a hardware perspective, MISP's requirements are quite humble, a web server with 2+ cores and 8-16 GB of memory should be plenty, though more is always better, of course. A lot of it depends on the data set and the number of users you are dealing with.

Some considerations for what might affect your requirements:

- How highly correlating your data is (correlations are generally memory and computation intensive), if you have a high correlation ratio, consider either lowering this with better management of the data (correlate flag on attributes) or by increasing the memory and CPU available;
- Number of samples and attachments directly affect the disk usage;
- Concurrent user counts affect the memory usage and CPU utilisation, especially if you have a list of API users querying MISP frequently;
- Number of remote feeds and servers cached and kept in memory will also increase the memory requirements of the system;
- The amount of logging / activity / longevity of the server can increase the disk requirements both on the database as well as the local log file stash;

To give some indications of some of the operational servers:

- 16GB memory and 2 vcpus are quite common for smaller sharing hubs and end-point MISPs;
- large sharing communities (such as the CIRCL private sector community) use 128 GB of memory with 32 physical CPU cores on modern Xeon CPUs;
- The COVID misp community (https://covid-19.iglocska.eu) runs on 8GB of memory with 4 vcpus and serves over a thousand users;
- The training instances we use, run on a meager 2GB of memory and a single vcpu (though we would not recommend using this for anything besides trainings / experimentation);

## Database

The main database of MISP relies on MariaDB. Using SSDs is highly recommended to ensure a low latency on the I/O and ensure an efficient access to the database. 

The type of storage used by MariaDB can also have an impact of the latency and disk space used. 

## Feed caching

Feed caching using RAM to store elements from the feeds enabled and cached. As an example, if you use the default available feeds, you can use up to 1.2Gb of memory if all feeds are enabled.
