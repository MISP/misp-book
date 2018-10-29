# MISP Instance requirements

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

### Tool assisted sizing

During a hackathon [misp-sizer](https://www.misp-project.org/MISP-sizer/) was conceived. ([code](https://github.com/MISP/MISP-sizer))
This can give you a very rough estimate and needs some more [improvements](https://github.com/MISP/MISP-sizer/issues).

