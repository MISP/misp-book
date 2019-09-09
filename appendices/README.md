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
  "2": {
    "name": "User",
    "urls": [
      "/attributes/add/*",
      "/attributes/add_attachment/*",
      "/attributes/add_threatconnect/*",
      "/attributes/attributeReplace/*",
      "/attributes/delete/*",
      "/attributes/deleteSelected/*",
      "/attributes/download/*",
      "/attributes/downloadAttachment/*",
      "/attributes/downloadSample/*",
      "/attributes/edit/*",
      "/attributes/editField/*",
      "/attributes/editSelected/*",
      "/attributes/fetchEditForm/*",
      "/attributes/fetchViewValue/*",
      "/attributes/hoverEnrichment/*",
      "/attributes/index/*",
      "/attributes/restSearch/*",
      "/attributes/returnAttributes/*",
      "/attributes/rpz/*",
      "/attributes/search/*",
      "/attributes/searchAlternate/*",
      "/attributes/text/*",
      "/attributes/updateAttributeValues/*",
      "/attributes/view/*",
      "/eventDelegations/acceptDelegation/*",
      "/eventDelegations/delegateEvent/*",
      "/eventDelegations/deleteDelegation/*",
      "/eventDelegations/view/*",
      "/events/add/*",
      "/events/addIOC/*",
      "/events/addTag/*",
      "/events/add_misp_export/*",
      "/events/contact/*",
      "/events/csv/*",
      "/events/delegation_index/*",
      "/events/delete/*",
      "/events/downloadExport/*",
      "/events/downloadOpenIOCEvent/*",
      "/events/downloadSearchResult/*",
      "/events/edit/*",
      "/events/export/*",
      "/events/exportChoice/*",
      "/events/filterEventIndex/*",
      "/events/freeTextImport/*",
      "/events/hids/*",
      "/events/index/*",
      "/events/nids/*",
      "/events/proposalEventIndex/*",
      "/events/queryEnrichment/*",
      "/events/removePivot/*",
      "/events/removeTag/*",
      "/events/restSearch/*",
      "/events/saveFreeText/*",
      "/events/stix/*",
      "/events/updateGraph/*",
      "/events/view/*",
      "/events/viewEventAttributes/*",
      "/events/viewGraph/*",
      "/events/xml/*",
      "/jobs/cache/*",
      "/jobs/getGenerateCorrelationProgress/*",
      "/jobs/getProgress/*",
      "/logs/event_index/*",
      "/logs/maxDateActivity/*",
      "/logs/returnDates/*",
      "/organisations/fetchOrgsForSG/*",
      "/organisations/fetchSGOrgRow/*",
      "/organisations/index/*",
      "/organisations/landingpage/*",
      "/organisations/view/*",
      "/pages/display/*",
      "/posts/add/*",
      "/posts/delete/*",
      "/posts/edit/*",
      "/regexp/index/*",
      "/roles/index/*",
      "/roles/view/*",
      "/servers/fetchServersForSG/*",
      "/shadowAttributes/accept/*",
      "/shadowAttributes/acceptSelected/*",
      "/shadowAttributes/add/*",
      "/shadowAttributes/add_attachment/*",
      "/shadowAttributes/delete/*",
      "/shadowAttributes/discard/*",
      "/shadowAttributes/discardSelected/*",
      "/shadowAttributes/download/*",
      "/shadowAttributes/edit/*",
      "/shadowAttributes/editField/*",
      "/shadowAttributes/fetchEditForm/*",
      "/shadowAttributes/index/*",
      "/shadowAttributes/view/*",
      "/sharingGroups/index/*",
      "/sharingGroups/view/*",
      "/sightings/add/*",
      "/sightings/delete/*",
      "/tags/add/*",
      "/tags/delete/*",
      "/tags/edit/*",
      "/tags/index/*",
      "/tags/quickAdd/*",
      "/tags/selectTag/*",
      "/tags/selectTaxonomy/*",
      "/tags/showEventTag/*",
      "/tags/view/*",
      "/tags/viewTag/*",
      "/taxonomies/index/*",
      "/taxonomies/taxonomyMassConfirmation/*",
      "/taxonomies/view/*",
      "/templateElements/index/*",
      "/templates/deleteTemporaryFile/*",
      "/templates/index/*",
      "/templates/populateEventFromTemplate/*",
      "/templates/submitEventPopulation/*",
      "/templates/templateChoices/*",
      "/templates/uploadFile/*",
      "/templates/view/*",
      "/threads/index/*",
      "/threads/view/*",
      "/threads/viewEvent/*",
      "/users/dashBoard/*",
      "/users/downloadTerms/*",
      "/users/edit/*",
      "/users/histogram/*",
      "/users/index/*",
      "/users/login/*",
      "/users/logout/*",
      "/users/memberslist/*",
      "/users/resetauthkey/*",
      "/users/routeafterlogin/*",
      "/users/statistics/*",
      "/users/terms/*",
      "/users/updateLoginTime/*",
      "/users/view/*",
      "/whitelists/index/*"
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
