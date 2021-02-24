# Summary

<!-- toc -->

# Appendix A: External Authentication

#### The external authentication mechanism described

The external authentication allows a user or an external tool to authenticate with MISP using an arbitrary value passed along in a custom header. This authentication method overrides the regular authentication mechanisms and is customisable by a site-admin. 

It is possible to create a mixed mode MISP setup where certain users can go through the normal authentication mechanism and other users are required to use the external authentication method.

#### Setting up the external authentication mechanism

To change the authentication settings, navigate to Administration - Server settings - Plugin settings

The settings associated with the external authentication can be found by pressing the CustomAuth button as depicted below:

![The server settings relevant to the Custom Authentication system.](figures/a/settings.png)

To change a setting simply double click on the value to edit the field. Use the guidance provided by the setting tool to configure the external authentication. The accessible settings are as follows:

*   **enable**: Enable or disable external authentication (off by default)

*   **header**: The header which MISP will use to identify users

*   **required**: Enabling this setting will force all users to use the external authentication. Leave this disabled allows administrators to assign external authentication or regular authentication users.

*   **only_allow_source**: Setting a url / IP address here will only allow requests that originated from the given address

*   **name**: The name to be used for the authentication mechanism. This is reflected in the user creation / edit views, the logs and the error messages on failed logins.

*   **disable_logout**: Disable the default logout button. Using an external authentication mechanism that authenticates via the header with each requests makes the logout button obsolete. 

*   **custom_password_reset**: If your authentication system has a url that a user can access to reset his/her password, please specify the full url for it here. This will then be reused in the UI.

*   **custom_password_logout**: If your authentication system has a url that a user can access to logout, please specify the full url for it here. This will then be reused in the UI.

#### User management

Using a new setting, user self management can be disabled for all users that are not administrators via the MISP.disableUserSelfManagement setting, found in the MISP settings tab. Enabling this setting removes the ability of users to change their user settings and reset their authentication keys. All other functionality remains unchanged.

![Adding a user with the external authentication enabled.](figures/a/add_user.png)

To create an external authenticated user, simply tick the External authentication user checkbox, after which an external auth key field will appear. This will be used to identify the users via the passed along header. 

#### Logging

For a description of the logging facilities provided by this plugin, please refer to the "Logging of failed authentication attempts" section of the Administration section.

# Appendix B: ACL descriptors

#### Querying the ACL system

MISP allows site admins to query the ACL system for various types of data. This can be interesting when tuning for example WAF access to MISP. All applicable queries can be requested via /servers/queryACL

#### Getting a list of URLs accessible to a role

~~~~
https://<misp url>/servers/queryACL/printRoleAccess/<role id>
~~~~

The above URL will return a JSON with all accessible URLs for the given role ID. If no Role ID is provided, a JSON containing all roles and their access lists will be returned. 

Example:

~~~~json
{
    "3": {
        "name": "User",
        "urls": [
            "/*/restSearch",
            "/attributes/add",
            "/attributes/add_attachment",
            "/attributes/add_threatconnect",
            "/attributes/addTag",
            "/attributes/attributeReplace",
            "/attributes/attributeStatistics",
            "/attributes/bro",
            "/attributes/delete",
            "/attributes/deleteSelected",
            "/attributes/describeTypes",
            "/attributes/download",
            "/attributes/downloadAttachment",
            "/attributes/downloadSample",
            "/attributes/edit",
            "/attributes/editField",
            "/attributes/editSelected",
            "/attributes/exportSearch",
            "/attributes/fetchEditForm",
            "/attributes/fetchViewValue",
            "/attributes/getMassEditForm",
            "/attributes/hoverEnrichment",
            "/attributes/index",
            "/attributes/removeTag",
            "/attributes/restore",
            "/attributes/restSearch",
            "/attributes/returnAttributes",
            "/attributes/rpz",
            "/attributes/search",
            "/attributes/searchAlternate",
            "/attributes/toggleCorrelation",
            "/attributes/text",
            "/attributes/toggleToIDS",
            "/attributes/updateAttributeValues",
            "/attributes/view",
            "/attributes/viewPicture",
            "/authKeys/add",
            "/authKeys/delete",
            "/authKeys/edit",
            "/authKeys/index",
            "/authKeys/view",
            "/auth_keys/add",
            "/auth_keys/delete",
            "/auth_keys/edit",
            "/auth_keys/index",
            "/auth_keys/view",
            "/dashboards/getForm",
            "/dashboards/index",
            "/dashboards/updateSettings",
            "/dashboards/getEmptyWidget",
            "/dashboards/renderWidget",
            "/dashboards/listTemplates",
            "/dashboards/saveTemplate",
            "/dashboards/export",
            "/dashboards/import",
            "/dashboards/deleteTemplate",
            "/decayingModel/export",
            "/decayingModel/import",
            "/decayingModel/view",
            "/decayingModel/index",
            "/decayingModel/add",
            "/decayingModel/edit",
            "/decayingModel/delete",
            "/decayingModel/enable",
            "/decayingModel/disable",
            "/decayingModel/decayingTool",
            "/decayingModel/getAllDecayingModels",
            "/decayingModel/decayingToolBasescore",
            "/decayingModel/decayingToolSimulation",
            "/decayingModel/decayingToolRestSearch",
            "/decayingModel/decayingToolComputeSimulation",
            "/decaying_model/export",
            "/decaying_model/import",
            "/decaying_model/view",
            "/decaying_model/index",
            "/decaying_model/add",
            "/decaying_model/edit",
            "/decaying_model/delete",
            "/decaying_model/enable",
            "/decaying_model/disable",
            "/decaying_model/decayingTool",
            "/decaying_model/getAllDecayingModels",
            "/decaying_model/decayingToolBasescore",
            "/decaying_model/decayingToolSimulation",
            "/decaying_model/decayingToolRestSearch",
            "/decaying_model/decayingToolComputeSimulation",
            "/decayingModelMapping/viewAssociatedTypes",
            "/decayingModelMapping/linkAttributeTypeToModel",
            "/decaying_model_mapping/viewAssociatedTypes",
            "/decaying_model_mapping/linkAttributeTypeToModel",
            "/eventBlocklists/add",
            "/eventBlocklists/delete",
            "/eventBlocklists/edit",
            "/eventBlocklists/index",
            "/eventBlocklists/massDelete",
            "/event_blocklists/add",
            "/event_blocklists/delete",
            "/event_blocklists/edit",
            "/event_blocklists/index",
            "/event_blocklists/massDelete",
            "/eventReports/add",
            "/eventReports/view",
            "/eventReports/viewSummary",
            "/eventReports/edit",
            "/eventReports/delete",
            "/eventReports/reportFromEvent",
            "/eventReports/restore",
            "/eventReports/index",
            "/eventReports/getProxyMISPElements",
            "/eventReports/extractAllFromReport",
            "/eventReports/extractFromReport",
            "/eventReports/replaceSuggestionInReport",
            "/eventReports/importReportFromUrl",
            "/event_reports/add",
            "/event_reports/view",
            "/event_reports/viewSummary",
            "/event_reports/edit",
            "/event_reports/delete",
            "/event_reports/reportFromEvent",
            "/event_reports/restore",
            "/event_reports/index",
            "/event_reports/getProxyMISPElements",
            "/event_reports/extractAllFromReport",
            "/event_reports/extractFromReport",
            "/event_reports/replaceSuggestionInReport",
            "/event_reports/importReportFromUrl",
            "/events/add",
            "/events/addIOC",
            "/events/addTag",
            "/events/add_misp_export",
            "/events/automation",
            "/events/checkLocks",
            "/events/checkPublishedStatus",
            "/events/contact",
            "/events/csv",
            "/events/delegation_index",
            "/events/delete",
            "/events/deleteNode",
            "/events/downloadExport",
            "/events/downloadOpenIOCEvent",
            "/events/edit",
            "/events/enrichEvent",
            "/events/export",
            "/events/exportChoice",
            "/events/exportModule",
            "/events/filterEventIndex",
            "/events/freeTextImport",
            "/events/getEditStrategy",
            "/events/getEventInfoById",
            "/events/getEventGraphReferences",
            "/events/getEventGraphTags",
            "/events/getEventGraphGeneric",
            "/events/getEventTimeline",
            "/events/genDistributionGraph",
            "/events/getDistributionGraph",
            "/events/getReferenceData",
            "/events/getReferences",
            "/events/getObjectTemplate",
            "/events/handleModuleResults",
            "/events/hids",
            "/events/index",
            "/events/importChoice",
            "/events/importModule",
            "/events/merge",
            "/events/nids",
            "/events/proposalEventIndex",
            "/events/publishSightings",
            "/events/queryEnrichment",
            "/events/removePivot",
            "/events/removeTag",
            "/events/restSearch",
            "/events/runTaxonomyExclusivityCheck",
            "/events/saveFreeText",
            "/events/stix",
            "/events/stix2",
            "/events/toggleCorrelation",
            "/events/unpublish",
            "/events/updateGraph",
            "/events/upload_analysis_file",
            "/events/upload_sample",
            "/events/upload_stix",
            "/events/view",
            "/events/viewClusterRelations",
            "/events/viewEventAttributes",
            "/events/viewGraph",
            "/events/viewGalaxyMatrix",
            "/events/xml",
            "/favouriteTags/toggle",
            "/favouriteTags/getToggleField",
            "/favourite_tags/toggle",
            "/favourite_tags/getToggleField",
            "/feeds/compareFeeds",
            "/feeds/feedCoverage",
            "/feeds/index",
            "/feeds/previewEvent",
            "/feeds/previewIndex",
            "/feeds/searchCaches",
            "/feeds/view",
            "/galaxies/attachCluster",
            "/galaxies/attachMultipleClusters",
            "/galaxies/export",
            "/galaxies/forkTree",
            "/galaxies/index",
            "/galaxies/relationsGraph",
            "/galaxies/selectGalaxy",
            "/galaxies/selectGalaxyNamespace",
            "/galaxies/selectCluster",
            "/galaxies/showGalaxies",
            "/galaxies/view",
            "/galaxies/viewGraph",
            "/galaxyClusters/attachToEvent",
            "/galaxyClusters/detach",
            "/galaxyClusters/index",
            "/galaxyClusters/restSearch",
            "/galaxyClusters/view",
            "/galaxyClusters/viewGalaxyMatrix",
            "/galaxyClusters/viewRelations",
            "/galaxyClusters/viewRelationTree",
            "/galaxy_clusters/attachToEvent",
            "/galaxy_clusters/detach",
            "/galaxy_clusters/index",
            "/galaxy_clusters/restSearch",
            "/galaxy_clusters/view",
            "/galaxy_clusters/viewGalaxyMatrix",
            "/galaxy_clusters/viewRelations",
            "/galaxy_clusters/viewRelationTree",
            "/galaxyClusterRelations/index",
            "/galaxyClusterRelations/view",
            "/galaxy_cluster_relations/index",
            "/galaxy_cluster_relations/view",
            "/galaxyElements/index",
            "/galaxy_elements/index",
            "/jobs/cache",
            "/jobs/getGenerateCorrelationProgress",
            "/jobs/getProgress",
            "/logs/event_index",
            "/logs/returnDates",
            "/modules/index",
            "/modules/queryEnrichment",
            "/news/index",
            "/noticelists/index",
            "/noticelists/view",
            "/objects/add",
            "/objects/addValueField",
            "/objects/delete",
            "/objects/edit",
            "/objects/get_row",
            "/objects/editField",
            "/objects/fetchEditForm",
            "/objects/fetchViewValue",
            "/objects/quickAddAttributeForm",
            "/objects/quickFetchTemplateWithValidObjectAttributes",
            "/objects/restSearch",
            "/objects/proposeObjectsFromAttributes",
            "/objects/groupAttributesIntoObject",
            "/objects/revise_object",
            "/objects/view",
            "/objectReferences/add",
            "/objectReferences/delete",
            "/objectReferences/view",
            "/object_references/add",
            "/object_references/delete",
            "/object_references/view",
            "/objectTemplates/objectChoice",
            "/objectTemplates/objectMetaChoice",
            "/objectTemplates/view",
            "/objectTemplates/viewElements",
            "/objectTemplates/index",
            "/object_templates/objectChoice",
            "/object_templates/objectMetaChoice",
            "/object_templates/view",
            "/object_templates/viewElements",
            "/object_templates/index",
            "/objectTemplateElements/viewElements",
            "/object_template_elements/viewElements",
            "/organisations/fetchSGOrgRow",
            "/organisations/index",
            "/organisations/view",
            "/pages/display",
            "/posts/add",
            "/posts/delete",
            "/posts/edit",
            "/regexp/index",
            "/restClientHistory/delete",
            "/restClientHistory/index",
            "/rest_client_history/delete",
            "/rest_client_history/index",
            "/roles/index",
            "/roles/view",
            "/servers/getApiInfo",
            "/servers/getPyMISPVersion",
            "/servers/getVersion",
            "/servers/idTranslator",
            "/servers/postTest",
            "/servers/rest",
            "/shadowAttributes/accept",
            "/shadowAttributes/acceptSelected",
            "/shadowAttributes/add",
            "/shadowAttributes/add_attachment",
            "/shadowAttributes/delete",
            "/shadowAttributes/discard",
            "/shadowAttributes/discardSelected",
            "/shadowAttributes/download",
            "/shadowAttributes/edit",
            "/shadowAttributes/index",
            "/shadowAttributes/view",
            "/shadowAttributes/viewPicture",
            "/shadow_attributes/accept",
            "/shadow_attributes/acceptSelected",
            "/shadow_attributes/add",
            "/shadow_attributes/add_attachment",
            "/shadow_attributes/delete",
            "/shadow_attributes/discard",
            "/shadow_attributes/discardSelected",
            "/shadow_attributes/download",
            "/shadow_attributes/edit",
            "/shadow_attributes/index",
            "/shadow_attributes/view",
            "/shadow_attributes/viewPicture",
            "/sharingGroups/index",
            "/sharingGroups/view",
            "/sharing_groups/index",
            "/sharing_groups/view",
            "/sightings/add",
            "/sightings/restSearch",
            "/sightings/advanced",
            "/sightings/delete",
            "/sightings/index",
            "/sightings/listSightings",
            "/sightings/quickDelete",
            "/sightings/viewSightings",
            "/sightings/bulkSaveSightings",
            "/sightings/quickAdd",
            "/tagCollections/index",
            "/tagCollections/view",
            "/tag_collections/index",
            "/tag_collections/view",
            "/tags/attachTagToObject",
            "/tags/index",
            "/tags/removeTagFromObject",
            "/tags/search",
            "/tags/selectTag",
            "/tags/selectTaxonomy",
            "/tags/showEventTag",
            "/tags/showAttributeTag",
            "/tags/showTagControllerTag",
            "/tags/tagStatistics",
            "/tags/view",
            "/tags/viewGraph",
            "/tags/viewTag",
            "/taxonomies/index",
            "/taxonomies/taxonomyMassConfirmation",
            "/taxonomies/taxonomyMassHide",
            "/taxonomies/taxonomyMassUnhide",
            "/taxonomies/view",
            "/taxonomies/unhideTag",
            "/taxonomies/hideTag",
            "/templateElements/index",
            "/template_elements/index",
            "/templates/deleteTemporaryFile",
            "/templates/index",
            "/templates/populateEventFromTemplate",
            "/templates/submitEventPopulation",
            "/templates/templateChoices",
            "/templates/uploadFile",
            "/templates/view",
            "/threads/index",
            "/threads/view",
            "/threads/viewEvent",
            "/users/attributehistogram",
            "/users/change_pw",
            "/users/checkIfLoggedIn",
            "/users/dashboard",
            "/users/downloadTerms",
            "/users/edit",
            "/users/email_otp",
            "/users/searchGpgKey",
            "/users/fetchGpgKey",
            "/users/histogram",
            "/users/login",
            "/users/logout",
            "/users/register",
            "/users/resetauthkey",
            "/users/request_API",
            "/users/routeafterlogin",
            "/users/statistics",
            "/users/tagStatisticsGraph",
            "/users/terms",
            "/users/updateLoginTime",
            "/users/view",
            "/users/getGpgPublicKey",
            "/userSettings/index",
            "/userSettings/view",
            "/userSettings/setSetting",
            "/userSettings/getSetting",
            "/userSettings/delete",
            "/userSettings/setHomePage",
            "/user_settings/index",
            "/user_settings/view",
            "/user_settings/setSetting",
            "/user_settings/getSetting",
            "/user_settings/delete",
            "/user_settings/setHomePage",
            "/warninglists/checkValue",
            "/warninglists/index",
            "/warninglists/view",
            "/allowedlists/index",
            "/eventGraph/view",
            "/eventGraph/add",
            "/eventGraph/delete",
            "/event_graph/view",
            "/event_graph/add",
            "/event_graph/delete"
        ]
    }
}
~~~~

#### Getting a list of all accessible controllers and actions in MISP

~~~~
https://<misp url>/servers/queryACL/printAllFunctionNames
~~~~

This URL will return a JSON with all controller and all mapped functions within them. 

#### Viewing a list of yet unmapped functions

~~~~
https://<misp url>/servers/queryACL/findMissingFunctionNames
~~~~

Functions that have not been tied into the new ACL yet show up here. These functions will (until added to the ACL) only be accessible to site admins.

# Appendix C: Official MISP developments

This section lists the projects that can be found on the main [MISP GitHub](https://github.com/MISP/repositories) page
 e know of but not officially support and rely on their respective maintainers to keep up to date to the MISP 2.4 developments.


| Project | Description | Status |
| -- | -- | -- |
| [misp-objects](https://github.com/MISP/misp-objects) | Definition, description and relationship types of MISP objects | Core to MISP, frequently updated and tested |
| [Best Practices in ThreatIntel](https://github.com/MISP/best-practices-in-threat-intelligence) | Best practices in threat intelligence | Book available here: https://www.misp-project.org/best-practices-in-threat-intelligence.html |

<!--
| []() |  | Core to MISP, frequently updated and tested |
| []() |  | Core to MISP, frequently updated and tested |
| []() |  | Core to MISP, frequently updated and tested |
-->

# Appendix D: Third-party development

This section lists some projects we know of but not officially support and rely on their respective maintainers to keep up to date to the MISP 2.4 developments.

| Project | Description | Status |
| -- | -- | -- |
| [MISP-STIX-ESM](https://github.com/mohlcyber/MISP-STIX-ESM) | Exports MISP events to STIX and ingest into McAfee ESM | Not tested by MISP core team |
| [Docker MISP](https://github.com/harvard-itsecurity/docker-misp) | Automated Docker MISP container | Not tested by MISP core team |
| [misp42splunk](https://github.com/remg427/misp42splunk) | A Splunk app to use MISP in background and combine with TheHive | Not tested by MISP core team |
| [getmispioc](https://github.com/xme/splunk/tree/master/getmispioc) | getiocmisp is a Splunk custom search command that helps to extract IOCs from a MISP instance. | Not tested by MISP core team |
| [OTX MISP](https://github.com/gcrahay/otx_misp) | Imports Alienvault OTX pulses to a MISP instance | Not tested by MISP core team |
| [BTG](https://github.com/conix-security/BTG) | BTG's purpose is to make fast and efficient search on IOC | Not tested by MISP core team |
| [MISP OSINT Collection](https://github.com/adulau/misp-osint-collection) | Collection of best practices to add OSINT into MISP and/or MISP communities | Not tested by MISP core team |
| [IBM XFE module](https://github.com/johestephan/XFE) | Various IBM X-Force Exchange modules | Not tested by MISP core team |
| [MISP dockerized](https://github.com/DCSO/MISP-dockerized-misp-modules) | MISP dockerized is a project designed to provide an easy-to-use and easy-to-install'out of the box' MISP instance that includes everything you need to run MISP with minimal host-side requirements. | Not tested by MISP core team |
| [MISP dockerized modules](https://github.com/DCSO/MISP-dockerized-misp-modules) | MISP-modules for MISP dockerized | Not tested by MISP core team |
| [FireMISP](https://github.com/deralexxx/FireMISP) | FireEye Alert json files to MISP Malware information sharing plattform (Alpha) | Not tested by MISP core team |
| [MISP Chrome Plugin](https://github.com/deralexxx/misp-chrome-plugin) | MISP Chrome plugin for adding and looking up indicators | Not tested by MISP core team |
| [PySight2MISP](https://github.com/deralexxx/PySight2MISP) | PySight2MISP is a project that can be run to be used as glue between iSight intel API and MISP API | Not tested by MISP core team |
| [tie2misp](https://github.com/DCSO/tie2misp) | Import DCSO TIE IOCs as MISP events | Not tested by MISP core team |
| [security onion MISP](https://github.com/weslambert/securityonion-misp) | Grab NIDS rules and Bro Intel generated from a MISP instance and use them in Security Onion | Not tested by MISP core team |
| [virustream](https://github.com/ntddk/virustream) | A script to track malware IOCs with OSINT on Twitter. | Not tested by MISP core team |
| [LAC CSV Import](https://github.com/LAC-Japan/MISP-CSVImport) | Register MISP events based on information described in files such as CSV and TSV. | Not tested by MISP core team |
| [The Hive](https://github.com/TheHive-Project/TheHive) | TheHive: a Scalable, Open Source and Free Security Incident Response Platform | Strong links between core team members, tested and known working |
| [puppet-misp](https://github.com/voxpupuli/puppet-misp) | This module installs and configures MISP - [puppet forge site](https://forge.puppet.com/puppet/misp) | Not tested by MISP core team |
| [Ansible MISP](https://github.com/StamusNetworks/ansible-misp) | Ansible playbook to install Malware Information Sharing Platform (MISP) | **unmaintained** |
| [ansible MISP](https://github.com/juju4/ansible-MISP) | ansible role to setup MISP | Not tested by MISP core team |
| [OpenDXL ATD MISP](https://github.com/mohlcyber/OpenDXL-ATD-MISP) | Automated threat intelligence collection with McAfee ATD, OpenDXL and MISP | Not tested by MISP core team |
| [IMAP Proxy](https://github.com/CIRCL/IMAP-Proxy) | Modular IMAP proxy (including PyCIRCLeanMail and MISP forward modules) | Not tested by MISP core team |
| [AutoMISP](https://github.com/da667/AutoMISP) | automate your MISP installs - This shell script is designed to automatically install [MISP](https://github.com/MISP/MISP) and the [misp-modules](https://github.com/MISP/misp-modules) extension on either Ubuntu 16.04, or 18.04. | Not tested by MISP core team |
| [Palo Alto Networks report_to_misp](https://github.com/PaloAltoNetworks/report_to_misp) | Parse a report and import the events into MISP | Not tested by MISP core team |
| [Palo Alto Networks minemeld-misp](https://github.com/PaloAltoNetworks/minemeld-misp) | MineMeld nodes for MISP | Not tested by MISP core team |
| [golang-misp](https://github.com/0xrawsec/golang-misp) | Golang Library to interact with your MISP instance | Not tested by MISP core team |
| [go-misp](https://github.com/Zenithar/go-misp) | Golang MISP [API Client](http://zenithar.org/go/misp) | Not tested by MISP core team |
| [MISP MAR](https://github.com/mohlcyber/MISP-MAR) | Integration between MISP platform and McAfee Active Response | Not tested by MISP core team |
| [MISP IoC Validator](https://github.com/tom8941/MISP-IOC-Validator) | Validate IOC from MISP ; Export results and iocs to SIEM and sensors using syslog and CEF format | Not tested by MISP core team |
| [vt2misp](https://github.com/eCrimeLabs/vt2misp) | Script to fetch data from virustotal and add it to a specific event as an object | Not tested by MISP core team |
| [Threat Pinch Lookup](https://github.com/cloudtracer/ThreatPinchLookup) | Documentation and Sharing Repository for ThreatPinch Lookup Chrome & Firefox [Extension](https://chrome.google.com/webstore/detail/threatpinch-lookup/ljdgplocfnmnofbhpkjclbefmjoikgke) | Not tested by MISP core team |
| [dovehawk](https://github.com/tylabs/dovehawk) | Dovehawk is a Bro module that automatically imports MISP indicators and reports Sightings | Not tested by MISP core team |
| [yara-exporter](https://github.com/CERT-Bund/yara-exporter) | Exporting MISP event attributes to yara rules usable with Thor apt scanner | Not tested by MISP core team |
| [volatility-misp](https://github.com/CIRCL/volatility-misp) | Volatility plugin to interface with MISP | Not tested by MISP core team |
| [misp2bro](https://github.com/thnyheim/misp2bro) | Python script that gets IOC from MISP and converts it into BRO intel files. | Not tested by MISP core team |
| [TA-misp](https://github.com/stricaud/TA-misp) | Splunk integration with MISP | Not tested by MISP core team |
| [MISP QRadar](https://github.com/karthikkbala/MISP-QRadar-Integration) | The Project can used to integrate QRadar with MISP Threat Sharing Platform | Not tested by MISP core team |
| [pymisp-suricata_search](https://github.com/raw-data/pymisp-suricata_search) | Multi-threaded suricata search module for MISP | Not tested by MISP core team |
| [MISP-ThreatExchange](https://github.com/EC-DIGIT-CSIRC/MISP-ThreatExchange) | Script to interface MISP with Facebook ThreatExchange | Not tested by MISP core team |
| [aptc](https://github.com/jymcheong/aptc) | [Automated Payload Test Controller](https://jymcheong.github.io/aptc/) | Not tested by MISP core team |
| [aptmap](https://github.com/3c7/aptmap) | A [map](https://aptmap.netlify.com) displaying threat actors from the [misp-galaxy](https://github.com/MISP/misp-galaxy) | Not tested by MISP core team |
| [mispy](https://github.com/nbareil/mispy) | Another MISP module for Python | Not tested by MISP core team |
| [MispSharp](https://github.com/DBHeise/MispSharp) | C# Library for MISP | Not tested by MISP core team |
| [misp_btc](https://github.com/rommelfs/misp_btc) | get BTC addresses from MISP and fetch BTC transactions | Tested by MISP core team |
| [Privacy Aware Sharing of IoCs in MISP](https://github.com/charly077/MISP-privacy-aware-sharing-master-thesis) | [Master Thesis](https://github.com/charly077/MISP-privacy-aware-sharing-master-thesis/blob/master/report/report.pdf) including MISP data. | Master thesis |
| [sam-bot ](https://github.com/IRATEAU/sam-bot) | Bot to create MISP events from data in Slack | Not tested by MISP core team |
| [Polarity.io Connector](https://github.com/polarityio/misp) | "Polarity is the memory augmentation platform that makes your team smarter" | Not tested by MISP core team |

<!--
| []() |  | Not tested by MISP core team |
| []() |  | Not tested by MISP core team |
| []() |  | Not tested by MISP core team |
-->

# Appendix E: Other Threat Intel Ressources

A brief list of online ressources that around #ThreatIntel

* [A curated list of awesome malware analysis tools and resources](https://github.com/rshipp/awesome-malware-analysis/blob/master/README.md). Inspired by [awesome-python](https://github.com/vinta/awesome-python) and [awesome-php](https://github.com/ziadoz/awesome-php).
* [An authoritative list of awesome devsecops tools with the help from community experiments and contributions](https://github.com/devsecops/awesome-devsecops/blob/master/README.md).[DEV.SEC.OPS](http://devsecops.org)
* [Advance Python IoC extractor](https://github.com/InQuest/python-iocextract)

# Appendix F: LDAP Authentication

MISP supports LDAP authentication from version 2.4.xxx. This manual will show how to configure LDAP authentication. 

#### Installation and configuration

1. Install `mod_ldap` PHP module
    ```bash
    # for Centos or RHEL
    yum install rh-php72-php-ldap
    # for Ubuntu or debian
    apt install php-ldap
    ```
2. Prepare variables for configuration

* `{{ LDAP_SERVER }}` – a full LDAP URI of server. For example: `ldap://example.com`.
* `{{ LDAP_BASE_DN }}` – DN for path that contains users. For example: `cn=users,cn=accounts,dc=example,dc=com`.
* `{{ LDAP_BIND_DN }}` – user that can read. For example: `uid=misp,cn=sysaccounts,cn=etc,dc=example,dc=com`.
* `{{ LDAP_BIND_PASSWORD }}` – password for that user.
* `{{ LDAP_USER_GROUP }}` – group with access to MISP. For example: `cn=misp-users,cn=groups,cn=accounts,dc=example,dc=com`.
   
3. Configure MISP ApacheSecureAuth in `app/Config/config.php`

    ```php
    'LdapAuth' => array(
      'enabled' => true,
      'name' => 'My Identity provider',
      'ldapServer' => '{{ LDAP_SERVER }}',
      'ldapDN' => '{{ LDAP_BASE_DN }}',
      'ldapSearchFilter' => '(objectclass=inetuser)',
      'ldapReaderUser' => '{{ LDAP_BIND_DN }}',
      'ldapReaderPassword' => '{{ LDAP_BIND_PASSWORD }}',
      'ldapUserGroup' => '{{ LDAP_USER_GROUP }}',
      'updateUser' => true,
    );
    ```

Required variables:

* `enabled` – if it is true, all users must log in through LDAP account.
* `ldapServer` – a full LDAP URI of the form ldap://hostname:port or ldaps://hostname:port for TLS encryption.
* `ldapDN` – DN for a path that contains users.

Optional variables:

* `name` – identity provider name. Will be shown in the login screen and user editing for. Can contain HTML.
* `ldapReaderUser` – DN or RDN LDAP user with permission to read LDAP information about users.
* `ldapReaderPassword` – password for that user.
* `ldapSearchFilter` - LDAP search filter.
* `ldapSearchAttribute` - LDAP attribute that contains username. Default: `uid`.
* `ldapEmailField` - LDAP attribute (string) or attributes (array) that will be checked if contains user e-mail address. If you want to change or add field, you should also add that field/fields to `ldapAttributes`. Default: `mail`.
* `ldapAttributes` – fields that will be fetched from LDAP server. Default: `mail` and `memberof`.
* `ldapUserGroup` - LDAP group that must be assigned to user to access MISP. Default: not set.
* `createUser` - if `true`, MISP will create new user from LDAP. Default `true`.
* `updateUser` - if `true`, MISP will update existing users information (e-mail address and role) from LDAP after login. Default: `false`.
* `ldapDefaultOrg` – default organization ID for user from LDAP. By default it is the first organization in the database.
* `ldapDefaultRoleId` - default role for newly created user. It can be integer or array when key contains LDAP group and value assigned role ID. Must be defined if `updateUser` is set to `true` (without that variable, user will be disabled).
* `ldapProtocol` - protocol version used. Default: 3.
* `ldapNetworkTimeout` - timeout for communication with LDAP server in seconds. Default: 5 seconds.
* `ldapAllowReferrals` - follow referrals returned by the LDAP server. Default: `false`.
* `ldapStartTls` - enable STARTTLS. Default: `true`.

#### Debugging

Setting LDAP authentication can be sometimes tricky. For debugging, you can check MISP error log (by default in `/var/www/MISP/app/tmp/logs/error.log`) or debug log (by default in `/var/www/MISP/app/tmp/logs/debug.log`) that can contain useful information with problem description.

#### Migrating existing user to LDAP

Because LDAP and MISP users are paired by e-mail address, it is possible to migrate existing user account to LDAP managed. When you enable LDAP support and LDAP user will try to log in, an existing user in MISP with the same e-mail address will be found and then assigned to LDAP user.

#### Caveats

* When a user is disabled in LDAP or is removed from the required group, it will be not automatically disabled in MISP. That means that user will be disabled when he tries to login (with form or with Auth key), but for example, notification e-mails will still work until he tries to log in.
* When a user is disabled in LDAP and also in MISP and then enabled in LDAP, it will be enabled in MISP for next login just when `updateUser` is set to `true`.
* Currently it is not possible to log in with both LDAP and local (MISP) accounts.
* Admins can change users email address. But when `updateUser` is set to true, when the user will log in again, the e-mail address will be updated from LDAP.
* `Security.require_password_confirmation` setting currently doesnt work with LDAP authentication. But on the other hand, since user cannot change e-mail address and password, this setting is not important.