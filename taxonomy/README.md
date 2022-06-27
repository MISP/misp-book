<!-- toc -->

## Taxonomies

In MISP 2.4.X, a flexible mechanism has been introduced to support various [taxonomy of classification](https://github.com/MISP/misp-taxonomies).

You can access the taxonomy by going into 'Event Actions' and select 'List Taxonomies'. For fresh install, make sure to click 'Update Taxonomies' to view available taxonomies.

A [complete list of the available taxonomies](https://www.misp-project.org/taxonomies.html) [PDF](https://www.misp-project.org/taxonomies.pdf) are available on the MISP project website.


![MISP Taxonomy index](./figures/taxonomies-index.png)

The following taxonomies can be used in MISP (as local or distributed tags) or in other tools willing to share common taxonomies among security information sharing tools.

![Overview of the MISP taxonomies](./figures/taxonomy-explanation.png)

1. [Admiralty Scale](https://github.com/MISP/misp-taxonomies/tree/master/admiralty-scale): The Admiralty Scale (also called the NATO System) is used to rank the reliability of a source and the credibility of an information.

2. [adversary](https://github.com/MISP/misp-taxonomies/tree/master/adversary) An overview and description of the adversary infrastructure.

3. CIRCL [Taxonomy - Schemes of Classification in Incident Response and Detection](https://github.com/MISP/misp-taxonomies/tree/master/circl) CIRCL Taxonomy is a simple scheme for incident classification and area topic where the incident took place.

4. [Cyber Kill Chain](https://github.com/MISP/misp-taxonomies/tree/master/kill-chain) from Lockheed Martin as described in [Intelligence-Driven Computer Network Defense Informed by Analysis of Adversary Campaigns and Intrusion Kill Chains](http://www.lockheedmartin.com/content/dam/lockheed/data/corporate/documents/LM-White-Paper-Intel-Driven-Defense.pdf).

5. DE German (DE) [Government classification markings (VS)](https://github.com/MISP/misp-taxonomies/tree/master/de-vs) Taxonomy for the handling of protectively marked information in MISP with German (DE) Government classification markings (VS).

6. [DHS CIIP Sectors](https://github.com/MISP/misp-taxonomies/tree/master/dhs-ciip-sectors) DHS critical sectors as described in https://www.dhs.gov/critical-infrastructure-sectors.

7. [Diamond Model for Intrusion Analysis](https://github.com/MISP/misp-taxonomies/tree/master/diamond-model), a phase-based model developed by Lockheed Martin, aims to help categorise and identify the stage of an attack.

8. [Domain Name Abuse](https://github.com/MISP/misp-taxonomies/tree/master/domain-abuse) - taxonomy to tag domain names used for cybercrime. Use europol-incident to tag abuse-activity

9. [eCSIRT](https://github.com/MISP/misp-taxonomies/tree/master/ecsirt) eCSIRT incident classification Appendix C of the eCSIRT EU project including IntelMQ updates.

10. [ENISA](https://github.com/MISP/misp-taxonomies/tree/master/enisa) ENISA Threat Taxonomy - A tool for structuring threat information [as published](https://www.enisa.europa.eu/topics/threat-risk-management/threats-and-trends/enisa-threat-landscape/etl2015/enisa-threat-taxonomy-a-tool-for-structuring-threat-information)

11. [Estimative Language](https://github.com/MISP/misp-taxonomies/tree/master/estimative-language) Estimative language - including likelihood or probability of event based on the Intelligence Community Directive 203 (ICD 203) (6.2.(a)).

12. [EU Marketop and Publicadmin][EU critical sectors](https://github.com/MISP/misp-taxonomies/tree/master/eu-marketop-and-publicadmin) Market operators and public administrations that must comply to some notifications requirements under EU NIS directive.

13. [EUCI](https://github.com/MISP/misp-taxonomies/tree/master/euci) EU classified information (EUCI) means any information or material designated by a EU security classification, the unauthorised disclosure of which could cause varying degrees of prejudice to the interests of the European Union or of one or more of the Member States [as described](http://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:32013D0488&from=EN).

14. [Europol Incident](https://github.com/MISP/misp-taxonomies/tree/master/europol-incident) EUROPOL class of incident taxonomy

15. [Europol Events](https://github.com/MISP/misp-taxonomies/tree/master/europol-event) - EUROPOL type of events taxonomy

16. [FIRST CSIRT Case](https://github.com/MISP/misp-taxonomies/tree/master/csirt_case_classification) FIRST CSIRT Case Classification.

17. [FIRST Information Exchange Policy (IEP)](https://github.com/MISP/misp-taxonomies/tree/master/iep) framework

18. [French gov information classification system](https://github.com/MISP/misp-taxonomies/tree/master/fr-classif)

19. [Information Security Indicators](https://github.com/MISP/misp-taxonomies/tree/master/information-security-indicators) Information security indicators have been standardized by the [ETSI Industrial Specification Group (ISG) ISI](http://www.etsi.org/technologies-clusters/technologies/information-security-indicators). These indicators provide the basis to switch from a qualitative to a quantitative culture in IT Security Scope of measurements: External and internal threats (attempt and success), user's deviant behaviours, nonconformities and/or vulnerabilities (software, configuration, behavioural, general security framework).

20. [Information Security Marking Metadata](https://github.com/MISP/misp-taxonomies/tree/master/dni-ism) (ISM)  [V13](http://www.dni.gov/index.php/about/organization/chief-information-officer/information-security-marking-metadata) as described by DNI.gov.

21. [Malware](https://github.com/MISP/misp-taxonomies/tree/master/malware_classification) classification based on different categories. Based on a [SANS whitepaper about malware](https://www.sans.org/reading-room/whitepapers/incident/malware-101-viruses-32848).

22. Malware Type and Platform classification based on Microsoft's implementation of the [Computer Antivirus Research Organization (CARO)](https://github.com/MISP/misp-taxonomies/tree/master/ms-caro-malware-full) Naming Scheme and Malware Terminology. Based on [Microsoft Malware naming conventions](https://www.microsoft.com/en-us/security/portal/mmpc/shared/malwarenaming.aspx), [Microsoft Glossary](https://www.microsoft.com/security/portal/mmpc/shared/glossary.aspx), [Microsoft Objective Criteria](https://www.microsoft.com/security/portal/mmpc/shared/objectivecriteria.aspx), and [CARO's definitions](http://www.caro.org/definitions/index.html). Malware families are extracted from Microsoft SIRs since 2008 based on [Microsoft Malware, virus, and threat encyclopedia](https://www.microsoft.com/en-us/security/portal/threat/threats.aspx). Note that SIRs do NOT include all Microsoft malware families.

23. [MISP taxonomy](https://github.com/MISP/misp-taxonomies/tree/master/misp) to infer with MISP behavior or operation.

24. [ms-caro-malware](https://github.com/MISP/misp-taxonomies/tree/master/ms-caro-malware) Malware Type and Platform classification based on Microsoft's implementation of the Computer Antivirus Research Organization (CARO) Naming Scheme and Malware Terminology.

25. [NATO Classification Marking](https://github.com/MISP/misp-taxonomies/tree/master/nato) Marking of Classified and Unclassified materials as described by the North Atlantic Treaty Organization, NATO.

26. [Open Threat Taxonomy v1.1 (SANS)](https://github.com/MISP/misp-taxonomies/tree/master/open_threat) based on James Tarala of SANS (http://www.auditscripts.com/resources/open_threat_taxonomy_v1.1a.pdf).

27. [OSINT Open Source Intelligence - Classification](https://github.com/MISP/misp-taxonomies/tree/master/osint)

28. [The Permissible Actions Protocol - or short: PAP](https://github.com/MISP/misp-taxonomies/tree/master/PAP) PAP was designed to indicate how the received information can be used. It's a protocol/taxonomy similar to TLP informing the recipients of information what they can do with the received information.

29. Status of events used in [Request Tracker](https://github.com/MISP/misp-taxonomies/tree/master/rt_event_status).

30. Classification based on [malware stealth](https://github.com/MISP/misp-taxonomies/tree/master/stealth_malware) techniques. Described in [Introducing Stealth Malware Taxonomy](https://vxheaven.org/lib/pdf/Introducing%20Stealth%20Malware%20Taxonomy.pdf)

31. [TLP - Traffic Light Protocol](https://github.com/MISP/misp-taxonomies/tree/master/tlp) The Traffic Light Protocol - or short: TLP - was designed with the objective to create a favorable classification scheme for sharing sensitive information while keeping the control over its distribution at the same time.

32. Vocabulary for Event Recording and Incident Sharing [VERIS](https://github.com/MISP/misp-taxonomies/tree/master/veris)

A taxonomy contains a series of tags that can be used as normal tags in your MISP instance.

Tagging is a simple way to attach a classification to an event. In the early version of MISP, tagging was local to an instance. Classification must be globally used to be efficient. After evaluating different solutions of classification, we build a new scheme using the concept of machine tags.

Taxonomy is a classification of informations. Taxonomies are implemented in a simple JSON format. Anyone can create their own taxonomy or reuse an existing one.

Taxonomies are in an [independent git repository](https://github.com/MISP/misp-taxonomies). 

These can be **freely reused** and **integrated** in other threat intel tools.

The advantage is that you can set a specific tag as being
exportable. This means that you can **export** your classification with other MISP instance and **share** the same taxonomies. Tagging is a simple way to attach a classification to an event.

**Classification must be globally used to be efficient.**

If you want to enable a specific taxonomy, you can click on the cross to enable it.

![enableTaxonomy](./figures/enableTaxonomy.png)

Then you can even cherry-pick the tags you want to use on the system. If you want to use the whole taxonomy, select all and then click on the cross in the top left.

## Contributing to Taxonomy

It is quite easy. Create a JSON file describing your taxonomy as triple tags.

![](./figures/writeTaxonomy.png)

![](./figures/writeTaxonomy2.png)

 (e.g. check an existing one like [Admiralty Scale](https://github.com/MISP/misp-taxonomies/tree/master/admiralty-scale)), create a directory matching your name space, put your machinetag file in the directory and pull your request. Publishing your taxonomy is as easy as a simple git pull request on misp-taxonomies (https://github.com/MISP/misp-taxonomies). That's it. Everyone can benefit from your taxonomy and can be automatically enabled in information sharing tools like [MISP](https://www.github.com/MISP/MISP).


## Reserved Taxonomy

 The following taxonomy namespaces are reserved and used internally to MISP.

 - [galaxy](../galaxy/) mapping taxonomy with cluster:element:"value".

## Adding Taxonomy in MISP

How are taxonomies integrated in MISP?

MISP administrators have only to import (or even cherry pick) the namespace or predicates they want to use as tags.

Tags can be exported to other instances.

Tags are also accessible via the MISP REST API.

For more information, "[Information Sharing and Taxonomies Practical Classification of Threat Indicators using MISP](https://www.circl.lu/assets/files/misp-training/first2016/2-MISP-Taxonomies.pdf)" presentation given to the last MISP training in Luxembourg.

## Adding a private taxonomy

~~~~ shell
$ cd /var/www/MISP/app/files/taxonomies/
$ mkdir privatetaxonomy
$ cd privatetaxonomy
$ vi machinetag.json
~~~~

Create a JSON file describing your taxonomy as triple tags.

~~~~ shell
For example :
mkdir sample
cd sample
vim machinetag.json
~~~~

Sample JSON with triple tags. You can use the JSON validator to be sure that there is no syntax error.

~~~~ shell
{
  "namespace": "sample",
  "description": "Some descriptive words",
  "version": 1,
  "predicates": [
    {
      "value": "my-predicate",
      "expanded": "my-predicate"
    }
  ],
  "values": [
    {
      "predicate": "my-predicate",
      "entry": [
        {
          "value": "a-value",
          "expanded": "A value"
        }
      ]
    }
  ]
}
~~~~

Go to MISP Web GUI taxonomies/index and update the taxonomies once you are happy with your file. The newly created taxonomy should be visible. Now you need to activate the tags within your taxonomy.

## How to use Taxonomy in MISP

### Filtering the distribution of events among MISP instances

Applying rules for distribution based on tags:

### MISP Taxonomies - tools

- [machinetag.py](https://github.com/MISP/misp-taxonomies/blob/master/tools/machinetag.py) is a parsing tool to dump taxonomies expressed in Machine Tags (Triple Tags) and list all valid tags from a specific taxonomy.

~~~~shell
% cd tools
% python machinetag.py
        admiralty-scale:source-reliability="a"
        admiralty-scale:source-reliability="b"
        admiralty-scale:source-reliability="c"
        admiralty-scale:source-reliability="d"
        admiralty-scale:source-reliability="e"
        admiralty-scale:source-reliability="f"
        admiralty-scale:information-credibility="1"
        admiralty-scale:information-credibility="2"
        admiralty-scale:information-credibility="3"
        admiralty-scale:information-credibility="4"
        admiralty-scale:information-credibility="5"
        admiralty-scale:information-credibility="6"
        ...
~~~~

- [PyTaxonomies](https://github.com/MISP/PyTaxonomies) - Python module to use the MISP Taxonomies

### Other use cases using MISP taxonomies

Tags can be used to:

* Set events for further processing by external tools (e.g. VirusTotal auto-expansion using Viper).

* Ensure a classification manager classes the events before release (e.g. release of information from air-gapped/classified networks).

* Enrich IDS export with tags to fit your NIDS deployment.

## Future functionalities related to MISP taxonomies

- Sighting support (thanks to NCSC-NL) is integrated in MISP allowing to auto expire IOC based on user detection.

- Adjusting taxonomies (adding/removing tags) based on their score or visibility via sighting.

- Simple taxonomy editors to help non-technical users to create their
taxonomies.

- Filtering mechanisms in MISP to rename or replace taxonomies/tags at pull and push synchronisation.

- More public taxonomies to be included
