## MISP Glossary
This glossary is meant as a quick lookup document in case of any need of clarification of any threat sharing, threat-intel lingo.
Be careful when adding terms to the glossary. Adding a generic term like: *MISP* will prevent terms like *MISP noticelist* to be addded. As a matter of definition please use the singular for any terms.
In case you use any CCBYSA licensed content, or other pieces that are subject to licensing, make sure to add it as a by-line at the end of the mention.

## API
MISP makes extensive use of its RESTful API (Application programming interface) both internally and provides an external API for automation, synchronisation or any other tasks requiring a machine to machine interface.
In general terms, it is a set of clearly defined methods of communication between various software components. A good [API](https://en.wikipedia.org/wiki/Application_programming_interface) makes it easier to develop a computer program by providing all the building blocks, which are then put together by the programmer. An API may be for a web-based system, operating system, database system, computer hardware or software library.
The de-facto standard for talking to MISP via an API is [PyMISP](https://github.com/MISP/PyMISP). Partial source ["API"](https://en.wikipedia.org/wiki/Application_programming_interface) - [CCBYSA](https://creativecommons.org/licenses/by-sa/3.0/).

## RESTful
Representational state transfer ([REST](https://en.wikipedia.org/wiki/Representational_state_transfer)) or RESTful web services are a way of providing interoperability between computer systems on the Internet. REST-compliant Web services allow requesting systems to access and manipulate textual representations of Web resources using a uniform and predefined set of stateless operations. Other forms of Web services exist which expose their own arbitrary sets of operations such as WSDL and SOAP. Source ["REST"](https://en.wikipedia.org/wiki/Representational_state_transfer) - [CCBYSA](https://creativecommons.org/licenses/by-sa/3.0/).

## Sharing groups
Sharing groups in MISP are a more granular way to create re-usable distribution lists for events/attributes that allow users to include organisations from their own instance (local organisations) as well as organisations from directly, or indirectly connected instances (external organisations).
[More about creating and managing sharing groups](https://www.circl.lu/doc/misp/using-the-system#create-and-manage-sharing-groups)

## Site admin
As an admin (not to be confused with Org Admin), you can set up new accounts for users, edit user profiles, delete them, or just have a look at all the viewers' profiles.
Site admins have access to every administrator feature for all the data located on the system including global features such as the creation and modification of user roles and instance links. You will also see all other organisations connected or setup in the instance. The site admin can be considered as a super-user of a MISP instance.

## Indicators
Indicators contain a pattern that can be used to detect suspicious or malicious cyber activity.

## IOC
Indicator of compromise (IOC or IoC) is an artefact observed on a network or in an operating system or information channel that could reference an intrusion or a reference to a technique used by an attacker. IoCs are a subset of indicators.

## NIDS
Network Intrusion Detection System eg. Snort, Suricata

## Malware Information Sharing Platform and Threat Sharing
Malware Information Sharing Platform and Threat Sharing. Commonly known simply as MISP.

## MISP Attribute
Attributes in MISP can be network indicators (e.g. IP address), system indicators (e.g. a string in memory) or even bank account details.
◦ A type (e.g. MD5, url) is how an attribute is described.
◦ An attribute is always in a category (e.g. Payload delivery) which puts it in a context.
• A category is what describes an attribute.
◦ An IDS flag on an attribute allows to determine if an attribute can be automated (such as being exported as an IDS ruleset or used for detection). If the IDS flag is not present, the attribute
can be useful for contextualisation only.

## Observable
Some other SIEMs or formats (STIX) use the term observable. This is the same as an attribute in MISP-speak. Usually an observable is a MISP attribute without the IDS flag set.

## MISP Event
MISP events are encapsulations for contextually related information represented as attribute and object.

## MISP Extended Events
MISP can now extend an event (starting from version 2.4.90). This allows users to build full blown events that extend an existing event, giving way to a combined event view that includes a sum total of the event along with all extending events.
[More](http://www.misp-project.org/2018/04/19/Extended-Events-Feature.html)

## MISP feeds
MISP includes a set of public OSINT feeds in its default configuration. The feeds can be used as a source of correlations for all of your events and attributes without the need to import them directly into your system. The MISP feed system allows for fast correlation but also a for quick comparisons of the feeds against one another.
To get started with MISP we advise to enable the CIRCL OSINT feed withing your MISP instance. This feed is generated with the PyMISP [feed-generator](https://github.com/CIRCL/PyMISP/tree/master/examples/feed-generator).
[More](http://www.misp-project.org/feeds/)

## MISP format
MISP formats are described in specification document based on the current implementation of MISP core and PyMISP. These specifications are available for other developers willing to develop their own tools or software supporting the [MISP format](https://github.com/MISP/misp-rfc/blob/master/misp-core-format/raw.md.txt).

## MISP Galaxy Cluster
MISP galaxy is a simple method to express a large object called cluster that can be attached to MISP events or attributes. A cluster can be composed of one or more elements. Elements are expressed as key-values. There are default vocabularies available in MISP galaxy but those can be overwritten, replaced or updated as you wish. Existing clusters and vocabularies can be used as-is or as a template. MISP distribution can be applied to each cluster to permit a limited or broader distribution scheme. The following document is generated from the machine-readable JSON describing the MISP galaxy.
There is a Python module available to work with Galaxy Cluster in a Pythonic way called [PyMISPGalaxies](https://github.com/MISP/PyMISPGalaxies).
[MISP galaxy GitHub Repo](https://github.com/MISP/misp-galaxy)
[More](https://www.misp-project.org/galaxy.html)

## MISP modules
MISP modules are autonomous modules that can be used for expansion and other services in MISP.
The modules are written in Python 3 following a simple API interface. The objective is to ease the extensions of MISP functionalities without modifying core components. The API is available via a simple REST API which is independent from MISP installation or configuration.
MISP modules support is included in MISP starting from version 2.4.28.
[More](https://www.circl.lu/assets/files/misp-training/switch2016/2-misp-modules.pdf)
[MISP modules GitHub Repo](https://github.com/MISP/misp-modules)

## MISP Instance
A MISP instance is an installation of the MISP software and the connected database. All the data visible to the users is stored locally in the database and data that is shareable (based on the distribution settings) can be synchronised with other instances via the Sync actions. The instance that you are reading this manual on will be referred to as "this instance" or "your instance". The instances that your instance synchronises with will be referred to as "remote instances".

## MISP Objects
MISP objects are used in MISP (starting from version 2.4.80) system and can be used by other information sharing tool. MISP objects are in addition to MISP attributes to allow advanced combinations of attributes. The creation of these objects and their associated attributes are based on real cyber security use-cases and existing practices in information sharing. The objects are just shared like any other attributes in MISP even if the other MISP instances don’t have the template of the object. The following document is generated from the machine-readable JSON describing the MISP objects.
[MISP objects GitHub Repo](https://github.com/MISP/misp-objects)
[More](https://www.misp-project.org/objects.html)

## MISP GnuPG Key
or GnuPG instance key is the GnuPG (Gnu Privacy Guard) key used by the MISP instance and which is only used to sign notification.
The GnuPG key used in the MISP instance must **not** be used anywhere else and should not be valuable.

## MISP Sightings
Basically, sighting is a system allowing people to react on attributes on an event. It was originally designed to provide an easy method for user to tell when they see a given attribute, giving it more credibility.

## MISP Taxonomies
[Taxonomy](https://en.wikipedia.org/wiki/Taxonomy_(general)) is the practice and science of classification. The word is also used as a count noun: a taxonomy, or taxonomic scheme, is a particular classification. The word finds its roots in the Greek language τάξις, taxis (meaning 'order', 'arrangement') and νόμος, nomos ('law' or 'science').
Taxonomies that can be used in MISP (2.4) and other information sharing tool and expressed in Machine Tags (Triple Tags). A machine tag is composed of a namespace (MUST), a predicate (MUST) and an (OPTIONAL) value. Machine tags are often called triple tag due to their format.
For more details on taxonomies and classification [the documentation](https://www.circl.lu/doc/misp-taxonomies/). Partial source ["Taxonomy_(general)"](https://en.wikipedia.org/wiki/Taxonomy_(general)) - [CCBYSA](https://creativecommons.org/licenses/by-sa/3.0/).
There is a Python module available to work with Taxonomies in a Pythonic way called [PyTaxonomies](https://github.com/MISP/PyTaxonomies).
[MISP taxonomies GitHub Repo](https://github.com/MISP/misp-taxonomies)

## MISP warninglists
MISP warninglists are lists of well-known indicators that can be associated to potential false positives, errors or mistakes.
There is a Python module available to work with warninglists in a Pythonic way called [PyMISPWarningLists](https://github.com/MISP/PyMISPWarningLists).
[MISP warninglists GitHub Repo](https://github.com/MISP/misp-warninglists)

## MISP noticelist
Notice lists to inform MISP users of the legal, privacy, policy or even technical implications of using specific attributes, categories or objects.
[MISP noticelist GitHub Repo](https://github.com/MISP/misp-noticelist)

## Org Admin
Organisation admins (Org Admin) are restricted to executing site-admin actions exclusively within their own organisation’s users only.
They can administer users, events and logs of their own respective organisations.

## OSINT
[Open-source intelligence](https://en.wikipedia.org/wiki/Open-source_intelligence) (OSINT) is data collected from publicly available sources to be used in an intelligence context.[1] In the intelligence community, the term "open" refers to overt, publicly available sources (as opposed to covert or clandestine sources). It is not related to open-source software or public intelligence.
OSINT under one name or another has been around for hundreds of years. With the advent of instant communications and rapid information transfer, a great deal of actionable and predictive intelligence can now be obtained from public, unclassified sources. Source ["Open-source intelligence"](https://en.wikipedia.org/wiki/Open-source_intelligence) - [CCBYSA](https://creativecommons.org/licenses/by-sa/3.0/).

## Pivot path
The (branching) path taken by a user from event to event while following correlation links. This is represented by the branching graph in the event view.

## Pivoting
The act of navigating from event to event through correlation links.

## Proposals
Each event can only be directly edited by users of the original creator organisation (and site admins). However, if another organisation would like to amend an event with extra information on an event, or if they'd like to correct a mistake in an attribute, they can create a Proposal. These proposals could then be accepted by the original creator organisation. These proposals can be pulled to another server, allowing users on connected instances to propose changes which then could be accepted by the original creators on another instance (and subsequently pushed back).

## Publishing
When an event is first created by a user, it is visible to everyone on the instance based on the access rights ("Your organisation only" events will not be visible to users of other organisations), but they will not be synchronised and they won't be exportable. For this, a user with publishing permission of the organisation that created the event has to publish the event. The system will then inform all the users of the instance that are subscribing to e-mail notifications and who have access to view the published event via an e-mail.

## Pull
Pulling is the process of using the configured sync user on a remote instance to REST GET all of the accessible data (based on the distribution rights) to your instance and store it.

## Push
Pushing is the process of using a configured instance link to send an event or all accessible events (limited by the distribution rights) through the REST interface to a remote instance.

## Roles
Roles are the central place where you can define ACL roles for your local users on your instance.
You can add new Roles depending on your use case. The following permissions can be given depending on which overall *Permission* the role inherits.

* Permission -> Read Only, Manage My Own Events, Manage Organization Events, Manage & Publish Organization Events
* Restricted To Site Admin
* Site Admin
* Org Admin
* Sync Action
* Audit Actions
* Auth key access
* Regex Actions
* Tagger
* Tag Editor
* Template Editor
* Sharing Group Editor
* Delegations Access
* Sighting Creator
* Object Template Editor
* Memory Limit
* Max Execution Time

## Scheduled Tasks
Certain common tasks can be scheduled for a later execution or for regular recurring executions. These tasks currently include caching all of the export formats, pulling from all eligible instances and pushing to all eligible instances.

## Standard MISP Install
Any MISP instance install that is strongly aligned with our [official install guides](https://misp.github.io/MISP/).
This is mostly to make sure you have a similar folder structure, /var/www/MISP for an Ubuntu Server Install.
It will also be easier to debug any Web Server issues or other system related problems.

## Sync User
A user of a role that grants sync permissions, these users (and their authentication keys) are used to serve as the points of connection between instances. Events pushed to an instance are pushed to a sync user, who then creates the events on the remote instance. Events pulled are added by the sync user that is used to connect the remote instance to your instance. As an administrator, keep in mind that a sync user needs auth key and publish permissions, has to have undergone the mandatory password change and has to have accepted the Terms of Use in order for the sync to work. Please make sure that all of these steps are taken before attempting to push or pull.

## Synchronisation
What we call synchronisation is an exchange of data between two (or more) MISP instances through our pull and push mechanisms.

## Tagging
Users with tagging rights can assigned various dynamically created tags to events, allowing an arbitrary link between events to be created. It is possible to filter events based on these tags and they can also be used to filter events for the automation.

## Templating
Users with templating rights can create easy to fill forms that help with the event creation process.
