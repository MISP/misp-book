<!-- toc -->

## Taxonomies

In MISP 2.4, a flexible mechanism has been introduced to support various taxonomy of classification.

You can access the taxonomy by going into 'Event Actions' and select 'List Taxonomies'.

![MISP Taxonomy index](./figures/taxonomies-index.png)

8 default taxonomies are available:

- [Admiralty Scale](https://github.com/MISP/misp-taxonomies/admiralty-scale)
- CIRCL [Taxonomy - Schemes of Classification in Incident Response and Detection](https://github.com/MISP/misp-taxonomies/circl)
- [eCSIRT](https://github.com/MISP/misp-taxonomies/ecsirt) and IntelMQ incident classification
- [EUCI](https://github.com/MISP/misp-taxonomies/euci) - EU classified information marking
- [Information Security Marking Metadata](https://github.com/MISP/misp-taxonomies//dni-ism) from DNI (Director of National Intelligence - US)
- [TLP - Traffic Light Protocol](https://github.com/MISP/misp-taxonomies/tlp)
- Vocabulary for Event Recording and Incident Sharing [VERIS](https://github.com/MISP/misp-taxonomies/veris)

A taxonomy contains a series of tags that can use as normal tags in your MISP instance. The advantage is that you even set a specific tag as being
exportable. This means that you can export your classification with other MISP instance and share the same taxonomies.

If you want to enable a specific taxonomy, you can click on the cross to enable it. Then you can even cherry-pick the tags you want to use on the system. If you want to use the whole taxonomy, select all and then click on the cross in the top left.


