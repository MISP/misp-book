<!-- toc -->

## Taxonomies

In MISP 2.4, a flexible mechanism has been introduced to support various [taxonomy of classification](https://github.com/MISP/misp-taxonomies).

You can access the taxonomy by going into 'Event Actions' and select 'List Taxonomies'.

![MISP Taxonomy index](./figures/taxonomies-index.png)

12 default taxonomies are available:

- [Admiralty Scale](./admiralty-scale)
- CIRCL [Taxonomy - Schemes of Classification in Incident Response and Detection](./circl)
- DE German (DE) [Government classification markings (VS)](./de-vs)
- [eCSIRT](./ecsirt) and IntelMQ incident classification
- [EUCI](./euci) - EU classified information marking
- [FIRST CSIRT Case](./first_csirt_case_classification) classification
- [Information Security Marking Metadata](./dni-ism) from DNI (Director of National Intelligence - US)
- [Malware](./malware) classification based on a SANS document
- [NATO Classification Marking](./nato)
- [OSINT Open Source Intelligence - Classification](./osint)
- [TLP - Traffic Light Protocol](./tlp)
- Vocabulary for Event Recording and Incident Sharing [VERIS](./veris)

A taxonomy contains a series of tags that can use as normal tags in your MISP instance. The advantage is that you even set a specific tag as being
exportable. This means that you can export your classification with other MISP instance and share the same taxonomies.

If you want to enable a specific taxonomy, you can click on the cross to enable it. Then you can even cherry-pick the tags you want to use on the system. If you want to use the whole taxonomy, select all and then click on the cross in the top left.

## Contributing taxonimies

It is quite easy. Create a JSON file describing your taxonomy as triple tags (e.g. check an existing one like [Admiralty Scale](https://github.com/MISP/misp-taxonomies/admiralty-scale)), create a directory matching your name space, put your machinetag file in the directory and pull your request. That's it. Everyone can benefit from your taxonomy and can be automatically enabled in information sharing tools like [MISP](https://www.github.com/MISP/MISP).

## Adding a private taxonomy

~~~~ shell
$ cd /var/www/MISP/app/files/taxonomies/
$ mkdir privatetaxonomy
$ vi machinetag.json
~~~~

Create a JSON file Create a JSON file describing your taxonomy as triple tags.

Once you are happy with your file go to MISP Web GUI taxonomies/index and update the taxonomies, the newly created taxonomy should be visible, now you need to activate the tags within your taxonomy.


