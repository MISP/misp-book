<!-- toc -->

### Attribute Categories vs. Types

|Category| Internal reference | Targeting data | Antivirus detection | Payload delivery | Artifacts dropped | Payload installation |
| --- |:---:|:---:|:---:|:---:|:---:|:---:|
|md5| | | | X | X | X |
|sha1| | | | X | X | X |
|sha256| | | | X | X | X |
|filename| | | | X | X | X |
|pdb| | | | | X | |
|filename&#124;md5| | | | X | X | X |
|filename&#124;sha1| | | | X | X | X |
|filename&#124;sha256| | | | X | X | X |
|ip-src| | | | X | | |
|ip-dst| | | | X | | |
|hostname| | | | X | | |
|domain| | | | X | | |
|domain&#124;ip| | | | | | |
|email| | | | X | | |
|email-src| | | | X | | |
|eppn| | | | | | |
|email-dst| | | | X | | |
|email-subject| | | | X | | |
|email-attachment| | | | X | | |
|email-body| | | | X | | |
|float| | | | | | |
|git-commit-id| X | | | | | |
|url| | | | X | | |
|http-method| | | | | | |
|user-agent| | | | X | | |
|ja3-fingerprint-md5| | | | X | | |
|jarm-fingerprint| | | | X | | |
|favicon-mmh3| | | | | | |
|hassh-md5| | | | X | | |
|hasshserver-md5| | | | X | | |
|regkey| | | | | X | |
|regkey&#124;value| | | | | X | |
|AS| | | | X | | |
|snort| | | | | | |
|bro| | | | | | |
|zeek| | | | | | |
|community-id| | | | | | |
|pattern-in-file| | | | X | X | X |
|pattern-in-traffic| | | | X | | X |
|pattern-in-memory| | | | | X | X |
|filename-pattern| | | | X | X | X |
|pgp-public-key| | | | | X | |
|pgp-private-key| | | | | X | |
|ssh-fingerprint| | | | | | |
|yara| | | | X | X | X |
|stix2-pattern| | | | X | X | X |
|sigma| | | | X | X | X |
|gene| | | | | X | |
|kusto-query| | | | | X | |
|mime-type| | | | X | X | X |
|identity-card-number| | | | | | |
|cookie| | | | | X | |
|vulnerability| | | | X | | X |
|cpe| | | | X | | X |
|weakness| | | | X | | X |
|attachment| | | X | X | X | X |
|malware-sample| | | | X | X | X |
|link| X | | X | X | | |
|comment| X | X | X | X | X | X |
|text| X | | X | X | X | X |
|hex| X | | X | X | X | X |
|other| X | | X | X | X | X |
|named pipe| | | | | X | |
|mutex| | | | | X | |
|process-state| | | | | X | |
|target-user| | X | | | | |
|target-email| | X | | | | |
|target-machine| | X | | | | |
|target-org| | X | | | | |
|target-location| | X | | | | |
|target-external| | X | | | | |
|btc| | | | | | |
|dash| | | | | | |
|xmr| | | | | | |
|iban| | | | | | |
|bic| | | | | | |
|bank-account-nr| | | | | | |
|aba-rtn| | | | | | |
|bin| | | | | | |
|cc-number| | | | | | |
|prtn| | | | | | |
|phone-number| | | | | | |
|threat-actor| | | | | | |
|campaign-name| | | | | | |
|campaign-id| | | | | | |
|malware-type| | | | X | | X |
|uri| | | | | | |
|authentihash| | | | X | X | X |
|vhash| | | | X | X | X |
|ssdeep| | | | X | X | X |
|imphash| | | | X | X | X |
|telfhash| | | | X | X | X |
|pehash| | | | X | | X |
|impfuzzy| | | | X | X | X |
|sha224| | | | X | X | X |
|sha384| | | | X | X | X |
|sha512| | | | X | X | X |
|sha512/224| | | | X | X | X |
|sha512/256| | | | X | X | X |
|sha3-224| | | | X | X | X |
|sha3-256| | | | X | X | X |
|sha3-384| | | | X | X | X |
|sha3-512| | | | X | X | X |
|tlsh| | | | X | | X |
|cdhash| | | | X | X | X |
|filename&#124;authentihash| | | | X | X | X |
|filename&#124;vhash| | | | X | X | X |
|filename&#124;ssdeep| | | | X | X | X |
|filename&#124;imphash| | | | X | X | X |
|filename&#124;impfuzzy| | | | X | X | X |
|filename&#124;pehash| | | | X | X | X |
|filename&#124;sha224| | | | X | X | X |
|filename&#124;sha384| | | | X | X | X |
|filename&#124;sha512| | | | X | X | X |
|filename&#124;sha512/224| | | | X | X | X |
|filename&#124;sha512/256| | | | X | X | X |
|filename&#124;sha3-224| | | | X | X | X |
|filename&#124;sha3-256| | | | X | X | X |
|filename&#124;sha3-384| | | | X | X | X |
|filename&#124;sha3-512| | | | X | X | X |
|filename&#124;tlsh| | | | X | X | X |
|windows-scheduled-task| | | | | X | |
|windows-service-name| | | | | X | |
|windows-service-displayname| | | | | X | |
|whois-registrant-email| | | | X | | |
|whois-registrant-phone| | | | | | |
|whois-registrant-name| | | | | | |
|whois-registrant-org| | | | | | |
|whois-registrar| | | | | | |
|whois-creation-date| | | | | | |
|x509-fingerprint-sha1| | | | X | X | X |
|x509-fingerprint-md5| | | | X | X | X |
|x509-fingerprint-sha256| | | | X | X | X |
|dns-soa-email| | | | | | |
|size-in-bytes| | | | | | |
|counter| | | | | | |
|datetime| | | | | | |
|port| | | | | | |
|ip-dst&#124;port| | | | X | | |
|ip-src&#124;port| | | | X | | |
|hostname&#124;port| | | | X | | |
|mac-address| | | | X | | |
|mac-eui-64| | | | X | | |
|email-dst-display-name| | | | X | | |
|email-src-display-name| | | | X | | |
|email-header| | | | X | | |
|email-reply-to| | | | X | | |
|email-x-mailer| | | | X | | |
|email-mime-boundary| | | | X | | |
|email-thread-index| | | | X | | |
|email-message-id| | | | X | | |
|github-username| | | | | | |
|github-repository| | | | | | |
|github-organisation| | | | | | |
|jabber-id| | | | | | |
|twitter-id| | | | | | |
|dkim| | | | | | |
|dkim-signature| | | | | | |
|first-name| | | | | | |
|middle-name| | | | | | |
|last-name| | | | | | |
|full-name| | | | | | |
|date-of-birth| | | | | | |
|place-of-birth| | | | | | |
|gender| | | | | | |
|passport-number| | | | | | |
|passport-country| | | | | | |
|passport-expiration| | | | | | |
|redress-number| | | | | | |
|nationality| | | | | | |
|visa-number| | | | | | |
|issue-date-of-the-visa| | | | | | |
|primary-residence| | | | | | |
|country-of-residence| | | | | | |
|special-service-request| | | | | | |
|frequent-flyer-number| | | | | | |
|travel-details| | | | | | |
|payment-details| | | | | | |
|place-port-of-original-embarkation| | | | | | |
|place-port-of-clearance| | | | | | |
|place-port-of-onward-foreign-destination| | | | | | |
|passenger-name-record-locator-number| | | | | | |
|mobile-application-id| | | | X | | X |
|azure-application-id| | | | X | | X |
|chrome-extension-id| | | | X | | X |
|cortex| | | | | | |
|boolean| | | | | | |
|anonymised| X | X | X | X | X | X |

|Category| Persistence mechanism | Network activity | Payload type | Attribution | External analysis | Financial fraud |
| --- |:---:|:---:|:---:|:---:|:---:|:---:|
|md5| | | | | X | |
|sha1| | | | | X | |
|sha256| | | | | X | |
|filename| X | | | | X | |
|pdb| | | | | | |
|filename&#124;md5| | | | | X | |
|filename&#124;sha1| | | | | X | |
|filename&#124;sha256| | | | | X | |
|ip-src| | X | | | X | |
|ip-dst| | X | | | X | |
|hostname| | X | | | X | |
|domain| | X | | | X | |
|domain&#124;ip| | X | | | X | |
|email| | X | | X | | |
|email-src| | X | | | | |
|eppn| | X | | | | |
|email-dst| | X | | | | |
|email-subject| | X | | | | |
|email-attachment| | | | | | |
|email-body| | | | | | |
|float| | | | | | |
|git-commit-id| | | | | | |
|url| | X | | | X | |
|http-method| | X | | | | |
|user-agent| | X | | | X | |
|ja3-fingerprint-md5| | X | | | X | |
|jarm-fingerprint| | X | | | X | |
|favicon-mmh3| | X | | | | |
|hassh-md5| | X | | | X | |
|hasshserver-md5| | X | | | X | |
|regkey| X | | | | X | |
|regkey&#124;value| X | | | | X | |
|AS| | X | | | X | |
|snort| | X | | | X | |
|bro| | X | | | X | |
|zeek| | X | | | X | |
|community-id| | X | | | X | |
|pattern-in-file| | X | | | X | |
|pattern-in-traffic| | X | | | X | |
|pattern-in-memory| | | | | X | |
|filename-pattern| | X | | | X | |
|pgp-public-key| | | | | | |
|pgp-private-key| | | | | | |
|ssh-fingerprint| | X | | | | |
|yara| | | | | | |
|stix2-pattern| | X | | | | |
|sigma| | | | | | |
|gene| | | | | | |
|kusto-query| | | | | | |
|mime-type| | | | | | |
|identity-card-number| | | | | | |
|cookie| | X | | | | |
|vulnerability| | | | | X | |
|cpe| | | | | X | |
|weakness| | | | | X | |
|attachment| | X | | | X | |
|malware-sample| | | | | X | |
|link| | | | | X | |
|comment| X | X | X | X | X | X |
|text| X | X | X | X | X | X |
|hex| X | X | | | | X |
|other| X | X | X | X | X | X |
|named pipe| | | | | | |
|mutex| | | | | | |
|process-state| | | | | | |
|target-user| | | | | | |
|target-email| | | | | | |
|target-machine| | | | | | |
|target-org| | | | | | |
|target-location| | | | | | |
|target-external| | | | | | |
|btc| | | | | | X |
|dash| | | | | | X |
|xmr| | | | | | X |
|iban| | | | | | X |
|bic| | | | | | X |
|bank-account-nr| | | | | | X |
|aba-rtn| | | | | | X |
|bin| | | | | | X |
|cc-number| | | | | | X |
|prtn| | | | | | X |
|phone-number| | | | | | X |
|threat-actor| | | | X | | |
|campaign-name| | | | X | | |
|campaign-id| | | | X | | |
|malware-type| | | | | | |
|uri| | X | | | | |
|authentihash| | | | | | |
|vhash| | | | | | |
|ssdeep| | | | | | |
|imphash| | | | | | |
|telfhash| | | | | | |
|pehash| | | | | | |
|impfuzzy| | | | | | |
|sha224| | | | | | |
|sha384| | | | | | |
|sha512| | | | | | |
|sha512/224| | | | | | |
|sha512/256| | | | | | |
|sha3-224| | | | | X | |
|sha3-256| | | | | X | |
|sha3-384| | | | | X | |
|sha3-512| | | | | X | |
|tlsh| | | | | | |
|cdhash| | | | | | |
|filename&#124;authentihash| | | | | | |
|filename&#124;vhash| | | | | | |
|filename&#124;ssdeep| | | | | | |
|filename&#124;imphash| | | | | | |
|filename&#124;impfuzzy| | | | | | |
|filename&#124;pehash| | | | | | |
|filename&#124;sha224| | | | | | |
|filename&#124;sha384| | | | | | |
|filename&#124;sha512| | | | | | |
|filename&#124;sha512/224| | | | | | |
|filename&#124;sha512/256| | | | | | |
|filename&#124;sha3-224| | | | | X | |
|filename&#124;sha3-256| | | | | X | |
|filename&#124;sha3-384| | | | | X | |
|filename&#124;sha3-512| | | | | X | |
|filename&#124;tlsh| | | | | | |
|windows-scheduled-task| | | | | | |
|windows-service-name| | | | | | |
|windows-service-displayname| | | | | | |
|whois-registrant-email| | | | X | | |
|whois-registrant-phone| | | | X | | |
|whois-registrant-name| | | | X | | |
|whois-registrant-org| | | | X | | |
|whois-registrar| | | | X | | |
|whois-creation-date| | | | X | | |
|x509-fingerprint-sha1| | X | | X | X | |
|x509-fingerprint-md5| | X | | X | X | |
|x509-fingerprint-sha256| | X | | X | X | |
|dns-soa-email| | | | X | | |
|size-in-bytes| | | | | | |
|counter| | | | | | |
|datetime| | | | | | |
|port| | X | | | | |
|ip-dst&#124;port| | X | | | X | |
|ip-src&#124;port| | X | | | X | |
|hostname&#124;port| | X | | | | |
|mac-address| | X | | | X | |
|mac-eui-64| | X | | | X | |
|email-dst-display-name| | | | | | |
|email-src-display-name| | | | | | |
|email-header| | | | | | |
|email-reply-to| | | | | | |
|email-x-mailer| | | | | | |
|email-mime-boundary| | | | | | |
|email-thread-index| | | | | | |
|email-message-id| | | | | | |
|github-username| | | | | | |
|github-repository| | | | | X | |
|github-organisation| | | | | | |
|jabber-id| | | | | | |
|twitter-id| | | | | | |
|dkim| | X | | | | |
|dkim-signature| | X | | | | |
|first-name| | | | | | |
|middle-name| | | | | | |
|last-name| | | | | | |
|full-name| | | | | | |
|date-of-birth| | | | | | |
|place-of-birth| | | | | | |
|gender| | | | | | |
|passport-number| | | | | | |
|passport-country| | | | | | |
|passport-expiration| | | | | | |
|redress-number| | | | | | |
|nationality| | | | | | |
|visa-number| | | | | | |
|issue-date-of-the-visa| | | | | | |
|primary-residence| | | | | | |
|country-of-residence| | | | | | |
|special-service-request| | | | | | |
|frequent-flyer-number| | | | | | |
|travel-details| | | | | | |
|payment-details| | | | | | |
|place-port-of-original-embarkation| | | | | | |
|place-port-of-clearance| | | | | | |
|place-port-of-onward-foreign-destination| | | | | | |
|passenger-name-record-locator-number| | | | | | |
|mobile-application-id| | | | | | |
|azure-application-id| | | | | | |
|chrome-extension-id| | | | | | |
|cortex| | | | | X | |
|boolean| | | | | | |
|anonymised| X | X | X | X | X | X |

|Category| Support Tool | Social network | Person | Other |
| --- |:---:|:---:|:---:|:---:|
|md5| | | | |
|sha1| | | | |
|sha256| | | | |
|filename| | | | |
|pdb| | | | |
|filename&#124;md5| | | | |
|filename&#124;sha1| | | | |
|filename&#124;sha256| | | | |
|ip-src| | | | |
|ip-dst| | | | |
|hostname| | | | |
|domain| | | | |
|domain&#124;ip| | | | |
|email| | X | X | |
|email-src| | X | | |
|eppn| | X | | |
|email-dst| | X | | |
|email-subject| | | | |
|email-attachment| | | | |
|email-body| | | | |
|float| | | | X |
|git-commit-id| | | | |
|url| | | | |
|http-method| | | | |
|user-agent| | | | |
|ja3-fingerprint-md5| | | | |
|jarm-fingerprint| | | | |
|favicon-mmh3| | | | |
|hassh-md5| | | | |
|hasshserver-md5| | | | |
|regkey| | | | |
|regkey&#124;value| | | | |
|AS| | | | |
|snort| | | | |
|bro| | | | |
|zeek| | | | |
|community-id| | | | |
|pattern-in-file| | | | |
|pattern-in-traffic| | | | |
|pattern-in-memory| | | | |
|filename-pattern| | | | |
|pgp-public-key| | X | X | X |
|pgp-private-key| | X | X | X |
|ssh-fingerprint| | | | |
|yara| | | | |
|stix2-pattern| | | | |
|sigma| | | | |
|gene| | | | |
|kusto-query| | | | |
|mime-type| | | | |
|identity-card-number| | | X | |
|cookie| | | | |
|vulnerability| | | | |
|cpe| | | | X |
|weakness| | | | |
|attachment| X | | | |
|malware-sample| | | | |
|link| X | | | |
|comment| X | X | X | X |
|text| X | X | X | X |
|hex| X | | | X |
|other| X | X | X | X |
|named pipe| | | | |
|mutex| | | | |
|process-state| | | | |
|target-user| | | | |
|target-email| | | | |
|target-machine| | | | |
|target-org| | | | |
|target-location| | | | |
|target-external| | | | |
|btc| | | | |
|dash| | | | |
|xmr| | | | |
|iban| | | | |
|bic| | | | |
|bank-account-nr| | | | |
|aba-rtn| | | | |
|bin| | | | |
|cc-number| | | | |
|prtn| | | | |
|phone-number| | | X | X |
|threat-actor| | | | |
|campaign-name| | | | |
|campaign-id| | | | |
|malware-type| | | | |
|uri| | | | |
|authentihash| | | | |
|vhash| | | | |
|ssdeep| | | | |
|imphash| | | | |
|telfhash| | | | |
|pehash| | | | |
|impfuzzy| | | | |
|sha224| | | | |
|sha384| | | | |
|sha512| | | | |
|sha512/224| | | | |
|sha512/256| | | | |
|sha3-224| | | | |
|sha3-256| | | | |
|sha3-384| | | | |
|sha3-512| | | | |
|tlsh| | | | |
|cdhash| | | | |
|filename&#124;authentihash| | | | |
|filename&#124;vhash| | | | |
|filename&#124;ssdeep| | | | |
|filename&#124;imphash| | | | |
|filename&#124;impfuzzy| | | | |
|filename&#124;pehash| | | | |
|filename&#124;sha224| | | | |
|filename&#124;sha384| | | | |
|filename&#124;sha512| | | | |
|filename&#124;sha512/224| | | | |
|filename&#124;sha512/256| | | | |
|filename&#124;sha3-224| | | | |
|filename&#124;sha3-256| | | | |
|filename&#124;sha3-384| | | | |
|filename&#124;sha3-512| | | | |
|filename&#124;tlsh| | | | |
|windows-scheduled-task| | | | |
|windows-service-name| | | | |
|windows-service-displayname| | | | |
|whois-registrant-email| | X | | |
|whois-registrant-phone| | | | |
|whois-registrant-name| | | | |
|whois-registrant-org| | | | |
|whois-registrar| | | | |
|whois-creation-date| | | | |
|x509-fingerprint-sha1| | | | |
|x509-fingerprint-md5| | | | |
|x509-fingerprint-sha256| | | | |
|dns-soa-email| | | | |
|size-in-bytes| | | | X |
|counter| | | | X |
|datetime| | | | X |
|port| | | | X |
|ip-dst&#124;port| | | | |
|ip-src&#124;port| | | | |
|hostname&#124;port| | | | |
|mac-address| | | | |
|mac-eui-64| | | | |
|email-dst-display-name| | | | |
|email-src-display-name| | | | |
|email-header| | | | |
|email-reply-to| | | | |
|email-x-mailer| | | | |
|email-mime-boundary| | | | |
|email-thread-index| | | | |
|email-message-id| | | | |
|github-username| | X | | |
|github-repository| | X | | |
|github-organisation| | X | | |
|jabber-id| | X | | |
|twitter-id| | X | | |
|dkim| | | | |
|dkim-signature| | | | |
|first-name| | | X | |
|middle-name| | | X | |
|last-name| | | X | |
|full-name| | | X | |
|date-of-birth| | | X | |
|place-of-birth| | | X | |
|gender| | | X | |
|passport-number| | | X | |
|passport-country| | | X | |
|passport-expiration| | | X | |
|redress-number| | | X | |
|nationality| | | X | |
|visa-number| | | X | |
|issue-date-of-the-visa| | | X | |
|primary-residence| | | X | |
|country-of-residence| | | X | |
|special-service-request| | | X | |
|frequent-flyer-number| | | X | |
|travel-details| | | X | |
|payment-details| | | X | |
|place-port-of-original-embarkation| | | X | |
|place-port-of-clearance| | | X | |
|place-port-of-onward-foreign-destination| | | X | |
|passenger-name-record-locator-number| | | X | |
|mobile-application-id| | | | |
|azure-application-id| | | | |
|chrome-extension-id| | | | |
|cortex| | | | |
|boolean| | | | X |
|anonymised| X | X | X | X |

### Categories

*   **Internal reference**: Reference used by the publishing party (e.g. ticket number)
*   **Targeting data**: Targeting information to include recipient email, infected machines, department, and or locations.
*   **Antivirus detection**: List of anti-virus vendors detecting the malware or information on detection performance (e.g. 13/43 or 67%). Attachment with list of detection or link to VirusTotal could be placed here as well.
*   **Payload delivery**: Information about the way the malware payload is initially delivered, for example information about the email or web-site, vulnerability used, originating IP etc. Malware sample itself should be attached here.
*   **Artifacts dropped**: Any artifact (files, registry keys etc.) dropped by the malware or other modifications to the system
*   **Payload installation**: Location where the payload was placed in the system and the way it was installed. For example, a filename|md5 type attribute can be added here like this: c:\windows\system32\malicious.exe|41d8cd98f00b204e9800998ecf8427e.
*   **Persistence mechanism**: Mechanisms used by the malware to start at boot. This could be a registry key, legitimate driver modification, LNK file in startup
*   **Network activity**: Information about network traffic generated by the malware
*   **Payload type**: Information about the final payload(s). Can contain a function of the payload, e.g. keylogger, RAT, or a name if identified, such as Poison Ivy.
*   **Attribution**: Identification of the group, organisation, or country behind the attack
*   **External analysis**: Any other result from additional analysis of the malware like tools output Examples: pdf-parser output, automated sandbox analysis, reverse engineering report.
*   **Financial fraud**: Financial Fraud indicators, for example: IBAN Numbers, BIC codes, Credit card numbers, etc.
*   **Support Tool**: Tools supporting analysis or detection of the event
*   **Social network**: Social networks and platforms
*   **Person**: A human being - natural person
*   **Other**: Attributes that are not part of any other category or are meant to be used as a component in MISP objects in the future

### Types

*   **md5**: You are encouraged to use filename|md5 instead. A checksum in md5 format, only use this if you don't know the correct filename
*   **sha1**: You are encouraged to use filename|sha1 instead. A checksum in sha1 format, only use this if you don't know the correct filename
*   **sha256**: You are encouraged to use filename|sha256 instead. A checksum in sha256 format, only use this if you don't know the correct filename
*   **filename**: Filename
*   **pdb**: Microsoft Program database (PDB) path information
*   **filename|md5**: A filename and an md5 hash separated by a | (no spaces)
*   **filename|sha1**: A filename and an sha1 hash separated by a | (no spaces)
*   **filename|sha256**: A filename and an sha256 hash separated by a | (no spaces)
*   **ip-src**: A source IP address of the attacker
*   **ip-dst**: A destination IP address of the attacker or C&C server. Also set the IDS flag on when this IP is hardcoded in malware
*   **hostname**: A full host/dnsname of an attacker. Also set the IDS flag on when this hostname is hardcoded in malware
*   **domain**: A domain name used in the malware. Use this instead of hostname when the upper domain is important or can be used to create links between events.
*   **domain|ip**: A domain name and its IP address (as found in DNS lookup) separated by a | (no spaces)
*   **email**: An e-mail address
*   **email-src**: The source email address. Used to describe the sender when describing an e-mail.
*   **eppn**: eduPersonPrincipalName - eppn - the NetId of the person for the purposes of inter-institutional authentication. Should be stored in the form of user@univ.edu, where univ.edu is the name of the local security domain.
*   **email-dst**: The destination email address. Used to describe the recipient when describing an e-mail.
*   **email-subject**: The subject of the email
*   **email-attachment**: File name of the email attachment.
*   **email-body**: Email body
*   **float**: A floating point value.
*   **git-commit-id**: A git commit ID.
*   **url**: url
*   **http-method**: HTTP method used by the malware (e.g. POST, GET, ...).
*   **user-agent**: The user-agent used by the malware in the HTTP request.
*   **ja3-fingerprint-md5**: JA3 is a method for creating SSL/TLS client fingerprints that should be easy to produce on any platform and can be easily shared for threat intelligence.
*   **jarm-fingerprint**: JARM is a method for creating SSL/TLS server fingerprints.
*   **favicon-mmh3**: favicon-mmh3 is the murmur3 hash of a favicon as used in Shodan.
*   **hassh-md5**: hassh is a network fingerprinting standard which can be used to identify specific Client SSH implementations. The fingerprints can be easily stored, searched and shared in the form of an MD5 fingerprint.
*   **hasshserver-md5**: hasshServer is a network fingerprinting standard which can be used to identify specific Server SSH implementations. The fingerprints can be easily stored, searched and shared in the form of an MD5 fingerprint.
*   **regkey**: Registry key or value
*   **regkey|value**: Registry value + data separated by |
*   **AS**: Autonomous system
*   **snort**: An IDS rule in Snort rule-format. This rule will be automatically rewritten in the NIDS exports.
*   **bro**: An NIDS rule in the Bro rule-format.
*   **zeek**: An NIDS rule in the Zeek rule-format.
*   **community-id**: a community ID flow hashing algorithm to map multiple traffic monitors into common flow id
*   **pattern-in-file**: Pattern in file that identifies the malware
*   **pattern-in-traffic**: Pattern in network traffic that identifies the malware
*   **pattern-in-memory**: Pattern in memory dump that identifies the malware
*   **filename-pattern**: A pattern in the name of a file
*   **pgp-public-key**: A PGP public key
*   **pgp-private-key**: A PGP private key
*   **ssh-fingerprint**: A fingerprint of SSH key material
*   **yara**: Yara signature
*   **stix2-pattern**: STIX 2 pattern
*   **sigma**: Sigma - Generic Signature Format for SIEM Systems
*   **gene**: GENE - Go Evtx sigNature Engine
*   **kusto-query**: Kusto query - Kusto from Microsoft Azure is a service for storing and running interactive analytics over Big Data.
*   **mime-type**: A media type (also MIME type and content type) is a two-part identifier for file formats and format contents transmitted on the Internet
*   **identity-card-number**: Identity card number
*   **cookie**: HTTP cookie as often stored on the user web client. This can include authentication cookie or session cookie.
*   **vulnerability**: A reference to the vulnerability used in the exploit
*   **cpe**: Common Platform Enumeration - structured naming scheme for information technology systems, software, and packages.
*   **weakness**: A reference to the weakness used in the exploit
*   **attachment**: Please upload files using the <em>Upload Attachment</em> button.
*   **malware-sample**: Please upload files using the <em>Upload Attachment</em> button.
*   **link**: Link to an external information
*   **comment**: Comment or description in a human language. This will not be correlated with other attributes
*   **text**: Name, ID or a reference
*   **hex**: A value in hexadecimal format
*   **other**: Other attribute
*   **named pipe**: Named pipe, use the format \.\pipe\<PipeName>
*   **mutex**: Mutex, use the format \BaseNamedObjects\<Mutex>
*   **process-state**: State of a process
*   **target-user**: Attack Targets Username(s)
*   **target-email**: Attack Targets Email(s)
*   **target-machine**: Attack Targets Machine Name(s)
*   **target-org**: Attack Targets Department or Organization(s)
*   **target-location**: Attack Targets Physical Location(s)
*   **target-external**: External Target Organizations Affected by this Attack
*   **btc**: Bitcoin Address
*   **dash**: Dash Address
*   **xmr**: Monero Address
*   **iban**: International Bank Account Number
*   **bic**: Bank Identifier Code Number also known as SWIFT-BIC, SWIFT code or ISO 9362 code
*   **bank-account-nr**: Bank account number without any routing number
*   **aba-rtn**: ABA routing transit number
*   **bin**: Bank Identification Number
*   **cc-number**: Credit-Card Number
*   **prtn**: Premium-Rate Telephone Number
*   **phone-number**: Telephone Number
*   **threat-actor**: A string identifying the threat actor
*   **campaign-name**: Associated campaign name
*   **campaign-id**: Associated campaign ID
*   **malware-type**:
*   **uri**: Uniform Resource Identifier
*   **authentihash**: You are encouraged to use filename|authentihash instead. Authenticode executable signature hash, only use this if you don't know the correct filename
*   **vhash**: You are encouraged to use filename|vhash instead. A checksum from VirusTotal, only use this if you don't know the correct filename
*   **ssdeep**: You are encouraged to use filename|ssdeep instead. A checksum in the SSDeep format, only use this if you don't know the correct filename
*   **imphash**: You are encouraged to use filename|imphash instead. A hash created based on the imports in the sample, only use this if you don't know the correct filename
*   **telfhash**: You are encouraged to use a file object with telfash
*   **pehash**: PEhash - a hash calculated based of certain pieces of a PE executable file
*   **impfuzzy**: You are encouraged to use filename|impfuzzy instead. A fuzzy hash created based on the imports in the sample, only use this if you don't know the correct filename
*   **sha224**: You are encouraged to use filename|sha224 instead. A checksum in sha224 format, only use this if you don't know the correct filename
*   **sha384**: You are encouraged to use filename|sha384 instead. A checksum in sha384 format, only use this if you don't know the correct filename
*   **sha512**: You are encouraged to use filename|sha512 instead. A checksum in sha512 format, only use this if you don't know the correct filename
*   **sha512/224**: You are encouraged to use filename|sha512/224 instead. A checksum in sha512/224 format, only use this if you don't know the correct filename
*   **sha512/256**: You are encouraged to use filename|sha512/256 instead. A checksum in sha512/256 format, only use this if you don't know the correct filename
*   **sha3-224**: You are encouraged to use filename|sha3-224 instead. A checksum in sha3-224 format, only use this if you don't know the correct filename
*   **sha3-256**: You are encouraged to use filename|sha3-256 instead. A checksum in sha3-256 format, only use this if you don't know the correct filename
*   **sha3-384**: You are encouraged to use filename|sha3-384 instead. A checksum in sha3-384 format, only use this if you don't know the correct filename
*   **sha3-512**: You are encouraged to use filename|sha3-512 instead. A checksum in sha3-512 format, only use this if you don't know the correct filename
*   **tlsh**: You are encouraged to use filename|tlsh instead. A checksum in the Trend Micro Locality Sensitive Hash format, only use this if you don't know the correct filename
*   **cdhash**: An Apple Code Directory Hash, identifying a code-signed Mach-O executable file
*   **filename|authentihash**: A checksum in md5 format
*   **filename|vhash**: A filename and a VirusTotal hash separated by a |
*   **filename|ssdeep**: A checksum in ssdeep format
*   **filename|imphash**: Import hash - a hash created based on the imports in the sample.
*   **filename|impfuzzy**: Import fuzzy hash - a fuzzy hash created based on the imports in the sample.
*   **filename|pehash**: A filename and a PEhash separated by a |
*   **filename|sha224**: A filename and a sha-224 hash separated by a |
*   **filename|sha384**: A filename and a sha-384 hash separated by a |
*   **filename|sha512**: A filename and a sha-512 hash separated by a |
*   **filename|sha512/224**: A filename and a sha-512/224 hash separated by a |
*   **filename|sha512/256**: A filename and a sha-512/256 hash separated by a |
*   **filename|sha3-224**: A filename and an sha3-224 hash separated by a |
*   **filename|sha3-256**: A filename and an sha3-256 hash separated by a |
*   **filename|sha3-384**: A filename and an sha3-384 hash separated by a |
*   **filename|sha3-512**: A filename and an sha3-512 hash separated by a |
*   **filename|tlsh**: A filename and a Trend Micro Locality Sensitive Hash separated by a |
*   **windows-scheduled-task**: A scheduled task in windows
*   **windows-service-name**: A windows service name. This is the name used internally by windows. Not to be confused with the windows-service-displayname.
*   **windows-service-displayname**: A windows service's displayname, not to be confused with the windows-service-name. This is the name that applications will generally display as the service's name in applications.
*   **whois-registrant-email**: The e-mail of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrant-phone**: The phone number of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrant-name**: The name of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrant-org**: The org of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrar**: The registrar of the domain, obtained from the WHOIS information.
*   **whois-creation-date**: The date of domain's creation, obtained from the WHOIS information.
*   **x509-fingerprint-sha1**: X509 fingerprint in SHA-1 format
*   **x509-fingerprint-md5**: X509 fingerprint in MD5 format
*   **x509-fingerprint-sha256**: X509 fingerprint in SHA-256 format
*   **dns-soa-email**: RFC1035 mandates that DNS zones should have a SOA (Statement Of Authority) record that contains an email address where a PoC for the domain could be contacted. This can sometimes be used for attribution/linkage between different domains even if protected by whois privacy
*   **size-in-bytes**: Size expressed in bytes
*   **counter**: An integer counter, generally to be used in objects
*   **datetime**: Datetime in the ISO 8601 format
*   **port**: Port number
*   **ip-dst|port**: IP destination and port number separated by a |
*   **ip-src|port**: IP source and port number separated by a |
*   **hostname|port**: Hostname and port number separated by a |
*   **mac-address**: Mac address
*   **mac-eui-64**: Mac EUI-64 address
*   **email-dst-display-name**: Email destination display name
*   **email-src-display-name**: Email source display name
*   **email-header**: Email header
*   **email-reply-to**: Email reply to header
*   **email-x-mailer**: Email x-mailer header
*   **email-mime-boundary**: The email mime boundary separating parts in a multipart email
*   **email-thread-index**: The email thread index header
*   **email-message-id**: The email message ID
*   **github-username**: A github user name
*   **github-repository**: A github repository
*   **github-organisation**: A github organisation
*   **jabber-id**: Jabber ID
*   **twitter-id**: Twitter ID
*   **dkim**: DKIM public key
*   **dkim-signature**: DKIM signature
*   **first-name**: First name of a natural person
*   **middle-name**: Middle name of a natural person
*   **last-name**: Last name of a natural person
*   **full-name**: Full name of a natural person
*   **date-of-birth**: Date of birth of a natural person (in YYYY-MM-DD format)
*   **place-of-birth**: Place of birth of a natural person
*   **gender**: The gender of a natural person (Male, Female, Other, Prefer not to say)
*   **passport-number**: The passport number of a natural person
*   **passport-country**: The country in which the passport was issued
*   **passport-expiration**: The expiration date of a passport
*   **redress-number**: The Redress Control Number is the record identifier for people who apply for redress through the DHS Travel Redress Inquiry Program (DHS TRIP). DHS TRIP is for travelers who have been repeatedly identified for additional screening and who want to file an inquiry to have erroneous information corrected in DHS systems
*   **nationality**: The nationality of a natural person
*   **visa-number**: Visa number
*   **issue-date-of-the-visa**: The date on which the visa was issued
*   **primary-residence**: The primary residence of a natural person
*   **country-of-residence**: The country of residence of a natural person
*   **special-service-request**: A Special Service Request is a function to an airline to provide a particular facility for A Passenger or passengers.
*   **frequent-flyer-number**: The frequent flyer number of a passenger
*   **travel-details**: Travel details
*   **payment-details**: Payment details
*   **place-port-of-original-embarkation**: The original port of embarkation
*   **place-port-of-clearance**: The port of clearance
*   **place-port-of-onward-foreign-destination**: A Port where the passenger is transiting to
*   **passenger-name-record-locator-number**: The Passenger Name Record Locator is a key under which the reservation for a trip is stored in the system. The PNR contains, among other data, the name, flight segments and address of the passenger. It is defined by a combination of five or six letters and numbers.
*   **mobile-application-id**: The application id of a mobile application
*   **azure-application-id**: Azure Application ID.
*   **chrome-extension-id**: Chrome extension id
*   **cortex**: Cortex analysis result
*   **boolean**: Boolean value - to be used in objects
*   **anonymised**: Anonymised value - described with the anonymisation object via a relationship.
