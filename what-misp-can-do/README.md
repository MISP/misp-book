#  What misp can do
Here are some interesting features you might want to find in a threat intelligence platform.
Some of these features are fully supported by MISP (~ 80% of it). Each feature is introduced as a question `Is MISP capable of  ...` 
The answers will try to both say if it's currently supported and then describe how in practice this feature is available (how to proceed to get things up). 
The list is not exhaustive of course but it's a good start and should be filled out as new features is added.
Everyone can [contribute] (https://github.com/MISP/misp-book) by proposing new features, or add additional info on an existing feature. 

_Answers labbeled with_ [**NOT DONE**] _tag need to be completed as they do not give much detail about the way in practice to get this feature up. After the label, there are complementary informations/suggestions to precise what other infos should be added to make the process clearer._

> Is MISP capable of applying custom taxonomies to threat data in a predefined or manual way? 

Yes, MISP has already [144](https://www.misp-project.org/taxonomies.html "144") different [taxonomies](https://www.circl.lu/doc/misp/GLOSSARY.html#misp-taxonomies "taxonomies") that gathered 951 [predicates](https://github.com/MISP/misp-taxonomies). But if none of them suit you, you can add your own: Just read [this guide](https://www.circl.lu/doc/misp/taxonomy/#adding-taxonomy-in-misp) or [this one](https://www.circl.lu/assets/files/misp-training/first2016/2-MISP-Taxonomies.pdf). It explains you step by step how to create your own. 

Once you have defined a set of tags to use, you can attach them to MISP entities ([Events/Objects/Attributes](https://www.misp-project.org/misp-training/handout/a.11-misp-data-model_handout.pdf)) in a predefined way through [MISP Workflow](https://www.misp-project.org/misp-training/a.12-misp-workflows.pdf):

This feature enables you to add tags when specific events are triggered such as:
- _After an Attribute/Event has been saved to the database_
- _After an Event has been pulled/published_
- _After enrichement process has been done_
- _Full list of trigger module is available [here](https://localhost/workflows/triggers)_

You can as well attach tags to sepecific set of data such as  (specfic attribute type/category/value/etc...)

All worflow modules and triggers are available at the MISP_URL/Workflow/triggers ou MISP_URL/Workflow/modules.

>  Can theses taxonomies remain local and not shared? 

Yes, 

Firstly, you can restrict the way information is being shared by applying [distribution setting](https://www.circl.lu/doc/misp/sharing/#distribution-settings)

Secondly, you can apply synchronisation [filtering rules](https://www.circl.lu/doc/misp/sharing/#rules) that block certain event/attribute pushed if they got sepcific tag or belong to specific organisation.

Finally, you can use the MISP workflow feature to block certain tags to be published by combining the Event publish trigger module with a IF :: Tag filtering module blocking module and see (e.g: [Blueprints examples](https://github.com/MISP/misp-workflow-blueprints)).

> Is MISP capable of providing automatic classification of information?

Depends on your definition of automatic. We script it using MISP APIs normally. 

[**NOT DONE**]
==> **Need to be developp with some high level examples in order to be more understandable. (What MISP API query or PyMISP fuction enable us to make classification of information in a automative way. How to use them in order to classify information in an automative way ? Give few examples)
**

> Does MISP have the capability to manage marking and confidence information, e.g. TLP?

Yes, it can manage marking information through the [tlp]( https://www.misp-project.org/taxonomies.html#_tlp_2) and [pap]( https://www.misp-project.org/taxonomies.html#_pap) taxonomies. If other tags exist regarding marking information just check on [taxonomies]( https://www.misp-project.org/taxonomies.html)

For confidence information...

> Does MISP have the capability to apply marking, tagging and confidence at event, attribute, feed and source levels in a predefined way?

Yes, this can be done in a predifined way through [MISP worflow](https://www.misp-project.org/misp-training/misp-worflows-first-cti.pdf). 
A rich set of taxonomies exist to characterize and contextualize informations. Thus, Marking (TLP, PAP) and confidence can be express through tags. These tags can be attach at the Event/Attribute/Feed/Source level in the following way:
 
- **Attribute level**:
By choosing the ***Attribut After Save*** trigger  (is called after an Attribute has been saved in the database)  or ***Event After Save***  trigger (is called after an Event or any of its elements has been saved in the database) you can then use the ***Tag operation*** module that allows you to ***Add or remove tags on Event or Attributes***.
- **Event level**: 
By choosing the ***Event After Save New*** trigger (is called after a new Event has been saved in the database) you can then ***Add or remove tags on Event or Attributes*** .
- **Feed level**: When you add a new feed via the GUI you can set a default tag that would labelled all event that came up from that feed.
- **Source level**: Tags exists (e.g [admiralty-scale:source-reliability](https://www.misp-project.org/taxonomies.html#_source_reliability), enisa:unintentional-damage="using-information-from-an-unreliable-source") that precise the degree of trust we place in the information source. 

All worflow modules and triggers are available at the MISP_URL/Workflow/triggers ou MISP_URL/Workflow/modules.

Furthermore there is a `default_event_tag_collection` settings  that you can set in order to have all event created with a specific tag id. 
`sudo -Hu www-data /var/www/MISP/app/Console/cake Admin setSetting "MISP.default_event_tag_collection" tag_id`


> Does MISP have the capability to match and link imported intelligence against custom rules and signatures (e.g. regular expressions, whitelists, blacklists, Yara rules, etc.) and apply subsequent predefined actions (e.g. identify internal IP addresses and do not tag them as indicators)?

Yes with whitelists and maybe other signature types. 
 You can create [warninglists](https://github.com/MISP/misp-warninglists) (lists of well-known indicators that can be associated to potential false positives, errors or mistakes) containing all the IPs you want to ignore/get notified. Doing so will allow you to:
 - Filter out these IPs if they are contained in an event by passing the [enforceWarninglist]( https://www.circl.lu/doc/misp/warninglists/#warninglists-and-data-export) parameter
 - Get a UI notification if these IPs are contained in an event and have the to_ids flag set
Note that it will not prevent you to add these IPs to an event.

You could extend the whitelist to other types of signatures (regular expressions, blacklists, Yara rules) by creating your own action modules that integrate/import a custom signature list. 

You can define predefined actions with [MISP worflow](https://www.misp-project.org/misp-training/misp-worflows-first-cti.pdf) feature. 
***
these actions are triggered when specific events comming (pull event, save attributes in an event, save a new event, feed fetch and so on).  These events are called triggered. the full available  list is available to this url: MISP_URL/workflows/triggers. the triggers are not customized and you cannot add new ones but  you have action and logic modules that can be customized (this [video](https://youtu.be/OyLE2g4zii0?t=1599) show you how to do it) [worflow training slides](https://www.misp-project.org/misp-training/handout/a.12-misp-workflows_handout.pdf). You can handle specific items from the one being manipulated (trigger) by using [filtering module](https://youtu.be/OyLE2g4zii0?t=3285)
***
> Taking into account the complexity of the cyber domain, Is MISP able to (automatically) link brand new data to already existing data via complex bindings such as aggregation, composition, generalization or realization?

The linking happens via something we call correlation, but it's not nearly that complex. the correlation can be complete (1-to-1 value matches) or partial (fuzzy hashing, CIDR block matching). An important work has be done lately (2022-08-22) to improve the correlation engine. [correlation engine changement](https://github.com/MISP/MISP/blob/2.4/docs/correlations.rework.md). You can astablish investigation pivot to the events correlated. 

> Is MISP able to generate warnings based on custom signatures and rules, before and after data enrichment?

Yes, warnings are expressed basicaly through email or chat message format. 
**Before MISP workflow**: it was possible to trigger email notification through auto-alerts feature. This one if enable for a user allow the system to send e-mail notifications about any new public events entered into the system by other users and private events added by members of your organisation. To turn this on, navigate to the Edit profile view (My profile on the left navigation menu -> Edit profile in the top right corner). Tick the auto-alert checkbox and click submit to enable this feature.
**With MISP workflow**: It's possible to send email/teams/chat message that could be personnalized with MISP workflow. (see above question to see links to know how it works)

> Does MISP have the capability to determine provenance and confidence information from different perspectives?

There is specific taxonomies that indicate **the provenance**: (example: [information security data source](https://www.misp-project.org/taxonomies.html#_information_security_data_source), [cssa-origin](https://www.misp-project.org/taxonomies.html#_cssa), [osint-source-type:](https://www.misp-project.org/taxonomies.html#_osint), [phishing: report origin](https://www.misp-project.org/taxonomies.html#_report_origin), ect)

For **confindance information** as well, we can characterize them with the following taxonomies: [estimative language taxonomie](https://www.misp-project.org/taxonomies.html#_estimative_language), [admiralty-scale](https://www.misp-project.org/taxonomies.html#_source_reliability), [misp confidence level](https://www.misp-project.org/taxonomies.html#_confidence_level)
that associate a score to the data. 

The tools exist to convey and label the information, but external tools are used in the decision process.
[**NOT DONE**]
==> **Need to be more specific which internal/external tools (give some examples)?**


> Does MISP allow analysts building custom workflows?

Yes, through misp workflow (see above answers to know more about it)

> Does MISP can have custom workflows that will enable multi-step approval for actions affecting sensitive data? e.g: information sharing of sensitive data.

No 
MISP worflow can trigger actions based on very precise information filtering. Basicaly (thanks to [hash extract](https://book.cakephp.org/3/fr/core-libraries/hash.html)) all informations contains in an  object/attribute/event can be used to convey a certain action to happend. In addition, within an object, several pieces of information can  indicate a sensitive data. (Tags, ...). I'm not sure about (multi-step approval), i don't think there is rules that if condition are met on the object handled (meaning sensitive data), another user can interfere in the action process.
But you can prevent an action from happening based on specific criteria, but no action that bring another user in the process...

> Does MISP have the capability and tools to enable collaboration with internal and external stakeholders on threat triage, analysis and response? Iterative processes should also be able to be established so that each individual can provide his/her perspective and feedback.

Yes, We have specifically separated the publishing duties from information creation duties for this reason.
[**NOT DONE**]
==> **I'm not convinced with the answer given if you could develop that would be really appreciated**


> Does MISP have the tasking capability, alerting on task deadline and logging analysts’ activities (so that changes can be tracked).


No, this is currently not in scope, MISP is hovered linked with case management (IRIS, The Hive) and ticketing systems (RTIR).


> Does MISP provide a human interface that will be customizable for data visualisations (visual graph-based representation).

Data embedded in the format of event/object/attributes can be represent graphically through different interfaces: 

- event graph: each object (event attributes or event objects) in MISP can **reference** another object in order to outline a logical link between these 2 objects. these links can be observed graphically. In addition we have access to the componants (attributes) of each objects that compose the event. The event graph view is customizable through multiple aspect like filtering on Attribute/Tag Presence/Value.
 

- Timeline graph: This is the view of the attribute lifetime based on firstseen and lastseen attribute settings.
  
- Correlation graph: Visual links between events that got similar attribute values.

- Custom Dashboarding: See next question answer to get more info about this topic.

> Does MISP have the provide the capability to visualise trend information over the data and other characteristics via data exploration.
MISP propose different interface to see data charachteristics: 

MISP propose different interfaces to have an overview of trends about threat information stored: 

- **2 Dashboards**: 
    - [Built-in dashboard](https://www.misp-project.org/misp-training/a.a-widget-dev.pdf):
    -- **Pros**:
        1) Allows to actively search the full historic datasets
        2) Use all the functionalities / advantages of the MISP internals
        3) ACL aware, all members of the community can use it
        4) Additionally allows for a lot of visualisation of non-data metrics (logs, users, system health, etc)
        5) Highly customisable / user, saveable templating, etc
            
        -- **Cons**:
        1) One dashoard for each instance
        2) Can be more resource intensive
    - [ZMQ dashboard](https://github.com/MISP/misp-dashboard) (Some [ slides](https://www.misp-project.org/misp-training/6.0-misp-dashboard.pdf)):
    -- **Pros:**
      
        1) Passively feeds on the dataset, no strain on misp's load (need more info)
        2) Allows the aggregation of multiple instances
    
        -- **Cons:**
        1) No ACL means it's for internal dashboards only
        2) Only sees what comes down the ZMQ pipe (outages, historic data, data out of scope for ZMQ are missed)
            

- **User statistics trends** (https://Nolink):
    - Mitre Attack galaxy techniques heathmap that can be filtered per organisation/time-window/Framework/etc... 
    **URL**: _MISP_URL/users/statistics/galaxyMatrix_
    - Heatmap showing user activity for each day during this month and the 4 months that preceded it. Use the buttons below to only show the heatmap of a specific organisation.
    **URL**: _MISP_URL/users/statistics/data_
    - Attributes types per organisation render through a colorized histogramm. **URL**: _MISP_URL/users/statistics/attributehistogram_
    - A treemap of the currently used event tags. (Very ugly <=> no color)
    **URL**: _MISP_URL/users/statistics/tags_

**These informations can also get retrieve [through API](https://github.com/MISP/MISP/issues/670) in order to set up your own dashboard** 
- **Periodic review** (https://NoLink): 
    - Top 10 MItre ATT&CK techniques see in the event with their respective occurence number
    - Top attribute type used with their respective  occurence number
    - Top object type used with their respective occurence number
    - Top 10 tags used with their respective occurence number
    - extract of event list 
    - Tag trendings dashboard (1 week period)
    - Context summary: All the tags and taxonomies observed through  events
    - Galaxy used, ...)
    **URL**: MISP_URL/users/viewPeriodicSummary/weekly

Yes, via the dashboarding, heatmap visualisations, etc

> Does MISP provide the capability of effective tactical indicator management with assurance that information is of relevant quality and fit for purpose.

Yes, via the decaying system which is a customizable model that attach a reliability score of the data. This model is very flexible You can customize the way the reliability score decrease with time, set a treshold score where the data is not reliable anymore, set an expiration time, set customize base score based on tags/taxonomies/attribute type. There is as well the possibility to simulate the decaying model.
([training link 1](https://www.misp-project.org/misp-training/a.5-decaying-indicators.pdf) | [training link 2](https://www.misp-project.org/2019/09/12/Decaying-Of-Indicators.html/))
**URL**: MISP_URL/decayingModel/decayingTool

> Does MISP allows analysts to prioritize IoCs and threats by helping them determine intelligence relevance based on technical constructs and organizational input. This could be achieved via rule-based or heuristics-based recommendation engines for threat information processing.

Yes, via the [decaying / scoring system](https://www.misp-project.org/2019/09/12/Decaying-Of-Indicators.html/)

[**NOT DONE**]
==> **Need to be more precise (with examples), i can see how decaying model can help determine the intelligence revelance of indicators. However, I  don't see how decaying/scoring system is based on technical construct and organizational input... And what about the rule-based or heuristics-based recommendation engines for threat information processing ?** 

> Does MISP have the Capability to automate or semi-automated threat triage.

Yes by connecting it to external tools via the enrichment system.
[**NOT DONE**]
==> **Need to be more precise (with examples), i don't see how enrichement modules can lead to the triage of threat**


> Does MISP have the capability to enrich the data with confidence scores, ratings, tags, prioritizations, annotations, etc.

- MISP directly no. However, via enrichment modules and external reputation services.

[**NOT DONE**]
==> **Can you site which external reputation service enable that ? And how the confidence is establish (by score/tags/annotation/ratings ? Does MISP has integration available with this external reputation service ?)** 


> Does MISP provide the capability for analysts to easily maintain their watchlists (e.g. domain resolution watchlist) and provide alerting based on predefined criteria.

Alerting can be done through MISP workflow (Email module action/ Teams module action) 
Only in very basic ways with warning list.

> Does MISP use statistics methods and present them to the analysts so that trends can be identified and data analysis would be simplified.

There is the following API Get requests that enable to retrieve some general statistics: 
- https://<misp url>/users/statistics/tags.json
- https://<misp url>/users/statistics.json
- https://<misp url>/users/statistics/attributehistogram.json
- https://<misp url>/users/statistics/orgs.json
- https://<misp url>/attributes/attributeStatistics/[context]/[percentage]

An example of statistics obtained from the above API request: 
- attribute categories/types percentage or count. 
- Event/Attribut count per month, Correlation count, User count, etc...  

Some PyMISP script (`stats.py`,`tagstatistics.py`, `attribute_treemap.py`, `tags_*`) exist to retrieve these information.
Full list is available in [MISP Book](https://www.circl.lu/doc/misp/book.pdf#page=249) at page 247.

> Is MISP able to collect metrics on usage of threat data to enable ranking of feeds and sources.
MISP can collect the data but it will not use it to rank feeds/sources based on usage. However, the information can be made available for external aggregation.

No
Only within the platform, since MISP networks can be large peer to peer networks the audit trail ends once the data leaves the instance.

> Is MISP able to sanitize and anonymize information before being shared with the rest of the stakeholders where appropriate.

Sanitise, Anonymise, only partially. 

Sanitization might be done with [Regex Input filters](): "Site administrators can define regular expression replacements and blocklists for certain values in addition to blocking certain values from being exportable." This can be used to replace sensitive value that have a specific pattern like ... 

MISP has also a functionality called [delegation request](https://www.circl.lu/doc/misp/delegation/) which completely remove the binding between the information shared and its organisation. If you want to publish an event without you or your organisation being tied to it, you can delegate the publication to an other organisation. 


In addition, you can create your own  Action Module in misp workflow that maybe can 

Furthermore you can prevent specific attribute that can hold sensitive information (such as passeport-number attribute) from being shared.
This is made possible with [misp-guard](https://www.misp-project.org/2022/09/13/misp-guard.html/) which is a mitmproxy addon that inspects and blocks outgoing events to external MISP instances via sync mechanisms (PULL/PUSH) based on a set of customizable block rules.


> Does MISP provide the mechanisms for the organisation to identify sensitive data and replace them with privacy protected label before being shared.

It has a subsystem that allows organisations to build rules for detecting sensitive data and warning the users about the impact of sharing them, the labelling is then up to the user / automation scripts.
This feature is called [noticelist](https://www.circl.lu/doc/misp/noticelists/) and got an example with [GDPR conformity](https://github.com/MISP/misp-noticelist/blob/main/lists/gdpr/list.json).

> Does MISP have the capability to provide granular access policies e.g. an intelligence product can have different parts that are TLP RED while the other parts may be TLP Amber.

Yes, 
MISP Sharing/Access policies can be expressed through the marking tags TLP/PAP.
These tags and all the possible tags can be attach at any level of the MISP data model (Attributes/Object/Events).
Thus an event can have different objects/attributes that doesn't have the same marking. 

> What MISP propose for being legal and policy compliant?    

Yes, a set of legal and policy compliance analyses are available to ensure compliance while using the software, documents or libraries contained within the MISP project. You will find [here](https://www.misp-project.org/compliance/) all the ressources about this topic


> Can MISP incorporate collaboration, iteration, and feedback between threat intelligence analysts.

Collaboration and feedback can be done in multiple ways: 
- Discussion: There are forum threads where you can discuss with other user of the community about non-event related topics 
- [Shadow Attributes/Proposal](https://www.circl.lu/doc/misp/general-concepts/#proposals): suggestions made by users to modify/create an event components (attributes/object). 
- [Sightings](https://www.circl.lu/doc/misp/sightings/): They are a means to convey that a data point has been seen under a given set of conditions. The sighting can include the organisation who sighted the attribute or can be anonymised. Different type exist:
	- Sighting type 0, the default sighting type using the default STIX interpretation of a sighting.
	- Sighting type 1, a false-positive sighting which means this sighting has been interpreted as a false-positive by the organisation.
	- Sighting type 2, an expiration sighting which defines when the sighted attributes is to be expired.
	- Sighting type 3, TTPs from the ATT&CK framework that have been identified. ([ATT&CK sightings](https://attack.mitre.org/resources/sightings/))  

You can as well tag your events with taxonomies to specify what analysis step are you into, what are the actions to be performed by one or    process  a step during the threat analysis: 
- [Workflow](https://www.misp-project.org/taxonomies.html#_workflow): Common language to support intelligence analysts to perform their analysis on data and information. Allow 
- [CTI](https://www.misp-project.org/taxonomies.html#_cti), 
- [Incident_disposition](https://www.misp-project.org/taxonomies.html#_incident_disposition): Define how an incident is classified in its process to be resolved.
- [MISP workflow](https://www.misp-project.org/taxonomies.html#_misp_workflow)

If you want to know more about how you can use MISP to callaborate, have feedback and iterate over analysis process, have a look at the [user personas](https://www.circl.lu/doc/misp/user-personas/).

