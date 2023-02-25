<!-- toc -->

### Attribute Categories vs. Types

|Category| Antivirus detection | Artifacts dropped | Attribution | External analysis | Financial fraud | Internal reference |
| --- |:---:|:---:|:---:|:---:|:---:|:---:|
|AS| | | | X | | |
|aba-rtn| | | | | X | |
|anonymised| X | X | X | X | X | X |
|attachment| X | X | | X | | |
|authentihash| | X | | | | |
|azure-application-id| | | | | | |
|bank-account-nr| | | | | X | |
|bic| | | | | X | |
|bin| | | | | X | |
|boolean| | | | | | |
|bro| | | | X | | |
|btc| | | | | X | |
|campaign-id| | | X | | | |
|campaign-name| | | X | | | |
|cc-number| | | | | X | |
|cdhash| | X | | | | |
|chrome-extension-id| | | | | | |
|comment| X | X | X | X | X | X |
|community-id| | | | X | | |
|cookie| | X | | | | |
|cortex| | | | X | | |
|counter| | | | | | |
|country-of-residence| | | | | | |
|cpe| | | | X | | |
|dash| | | | | X | |
|date-of-birth| | | | | | |
|datetime| | | | | | |
|dkim| | | | | | |
|dkim-signature| | | | | | |
|dns-soa-email| | | X | | | |
|domain| | | | X | | |
|domain&#124;ip| | | | X | | |
|email| | | X | | | |
|email-attachment| | | | | | |
|email-body| | | | | | |
|email-dst| | | | | | |
|email-dst-display-name| | | | | | |
|email-header| | | | | | |
|email-message-id| | | | | | |
|email-mime-boundary| | | | | | |
|email-reply-to| | | | | | |
|email-src| | | | | | |
|email-src-display-name| | | | | | |
|email-subject| | | | | | |
|email-thread-index| | | | | | |
|email-x-mailer| | | | | | |
|eppn| | | | | | |
|favicon-mmh3| | | | | | |
|filename| | X | | X | | |
|filename-pattern| | X | | X | | |
|filename&#124;authentihash| | X | | | | |
|filename&#124;impfuzzy| | X | | | | |
|filename&#124;imphash| | X | | | | |
|filename&#124;md5| | X | | X | | |
|filename&#124;pehash| | X | | | | |
|filename&#124;sha1| | X | | X | | |
|filename&#124;sha224| | X | | | | |
|filename&#124;sha256| | X | | X | | |
|filename&#124;sha3-224| | X | | X | | |
|filename&#124;sha3-256| | X | | X | | |
|filename&#124;sha3-384| | X | | X | | |
|filename&#124;sha3-512| | X | | X | | |
|filename&#124;sha384| | X | | | | |
|filename&#124;sha512| | X | | | | |
|filename&#124;sha512/224| | X | | | | |
|filename&#124;sha512/256| | X | | | | |
|filename&#124;ssdeep| | X | | | | |
|filename&#124;tlsh| | X | | | | |
|filename&#124;vhash| | X | | | | |
|first-name| | | | | | |
|float| | | | | | |
|frequent-flyer-number| | | | | | |
|full-name| | | | | | |
|gender| | | | | | |
|gene| | X | | | | |
|git-commit-id| | | | | | X |
|github-organisation| | | | | | |
|github-repository| | | | X | | |
|github-username| | | | | | |
|hassh-md5| | | | X | | |
|hasshserver-md5| | | | X | | |
|hex| X | X | | | X | X |
|hostname| | | | X | | |
|hostname&#124;port| | | | | | |
|http-method| | | | | | |
|iban| | | | | X | |
|identity-card-number| | | | | | |
|impfuzzy| | X | | | | |
|imphash| | X | | | | |
|ip-dst| | | | X | | |
|ip-dst&#124;port| | | | X | | |
|ip-src| | | | X | | |
|ip-src&#124;port| | | | X | | |
|issue-date-of-the-visa| | | | | | |
|ja3-fingerprint-md5| | | | X | | |
|jabber-id| | | | | | |
|jarm-fingerprint| | | | X | | |
|kusto-query| | X | | | | |
|last-name| | | | | | |
|link| X | | | X | | X |
|mac-address| | | | X | | |
|mac-eui-64| | | | X | | |
|malware-sample| | X | | X | | |
|malware-type| | | | | | |
|md5| | X | | X | | |
|middle-name| | | | | | |
|mime-type| | X | | | | |
|mobile-application-id| | | | | | |
|mutex| | X | | | | |
|named pipe| | X | | | | |
|nationality| | | | | | |
|other| X | X | X | X | X | X |
|passenger-name-record-locator-number| | | | | | |
|passport-country| | | | | | |
|passport-expiration| | | | | | |
|passport-number| | | | | | |
|pattern-in-file| | X | | X | | |
|pattern-in-memory| | X | | X | | |
|pattern-in-traffic| | | | X | | |
|payment-details| | | | | | |
|pdb| | X | | | | |
|pehash| | | | | | |
|pgp-private-key| | X | | | | |
|pgp-public-key| | X | | | | |
|phone-number| | | | | X | |
|place-of-birth| | | | | | |
|place-port-of-clearance| | | | | | |
|place-port-of-onward-foreign-destination| | | | | | |
|place-port-of-original-embarkation| | | | | | |
|port| | | | | | |
|primary-residence| | | | | | |
|process-state| | X | | | | |
|prtn| | | | | X | |
|redress-number| | | | | | |
|regkey| | X | | X | | |
|regkey&#124;value| | X | | X | | |
|sha1| | X | | X | | |
|sha224| | X | | | | |
|sha256| | X | | X | | |
|sha3-224| | X | | X | | |
|sha3-256| | X | | X | | |
|sha3-384| | X | | X | | |
|sha3-512| | X | | X | | |
|sha384| | X | | | | |
|sha512| | X | | | | |
|sha512/224| | X | | | | |
|sha512/256| | X | | | | |
|sigma| | X | | | | |
|size-in-bytes| | | | | | |
|snort| | | | X | | |
|special-service-request| | | | | | |
|ssdeep| | X | | | | |
|ssh-fingerprint| | | | | | |
|stix2-pattern| | X | | | | |
|target-email| | | | | | |
|target-external| | | | | | |
|target-location| | | | | | |
|target-machine| | | | | | |
|target-org| | | | | | |
|target-user| | | | | | |
|telfhash| | X | | | | |
|text| X | X | X | X | X | X |
|threat-actor| | | X | | | |
|tlsh| | | | | | |
|travel-details| | | | | | |
|twitter-id| | | | | | |
|uri| | | | | | |
|url| | | | X | | |
|user-agent| | | | X | | |
|vhash| | X | | | | |
|visa-number| | | | | | |
|vulnerability| | | | X | | |
|weakness| | | | X | | |
|whois-creation-date| | | X | | | |
|whois-registrant-email| | | X | | | |
|whois-registrant-name| | | X | | | |
|whois-registrant-org| | | X | | | |
|whois-registrant-phone| | | X | | | |
|whois-registrar| | | X | | | |
|windows-scheduled-task| | X | | | | |
|windows-service-displayname| | X | | | | |
|windows-service-name| | X | | | | |
|x509-fingerprint-md5| | X | X | X | | |
|x509-fingerprint-sha1| | X | X | X | | |
|x509-fingerprint-sha256| | X | X | X | | |
|xmr| | | | | X | |
|yara| | X | | | | |
|zeek| | | | X | | |

|Category| Network activity | Other | Payload delivery | Payload installation | Payload type | Persistence mechanism |
| --- |:---:|:---:|:---:|:---:|:---:|:---:|
|AS| X | | X | | | |
|aba-rtn| | | | | | |
|anonymised| X | X | X | X | X | X |
|attachment| X | | X | X | | |
|authentihash| | | X | X | | |
|azure-application-id| | | X | X | | |
|bank-account-nr| | | | | | |
|bic| | | | | | |
|bin| | | | | | |
|boolean| | X | | | | |
|bro| X | | | | | |
|btc| | | | | | |
|campaign-id| | | | | | |
|campaign-name| | | | | | |
|cc-number| | | | | | |
|cdhash| | | X | X | | |
|chrome-extension-id| | | X | X | | |
|comment| X | X | X | X | X | X |
|community-id| X | | | | | |
|cookie| X | | | | | |
|cortex| | | | | | |
|counter| | X | | | | |
|country-of-residence| | | | | | |
|cpe| | X | X | X | | |
|dash| | | | | | |
|date-of-birth| | | | | | |
|datetime| | X | | | | |
|dkim| X | | | | | |
|dkim-signature| X | | | | | |
|dns-soa-email| | | | | | |
|domain| X | | X | | | |
|domain&#124;ip| X | | | | | |
|email| X | | X | | | |
|email-attachment| | | X | | | |
|email-body| | | X | | | |
|email-dst| X | | X | | | |
|email-dst-display-name| | | X | | | |
|email-header| | | X | | | |
|email-message-id| | | X | | | |
|email-mime-boundary| | | X | | | |
|email-reply-to| | | X | | | |
|email-src| X | | X | | | |
|email-src-display-name| | | X | | | |
|email-subject| X | | X | | | |
|email-thread-index| | | X | | | |
|email-x-mailer| | | X | | | |
|eppn| X | | | | | |
|favicon-mmh3| X | | | | | |
|filename| | | X | X | | X |
|filename-pattern| X | | X | X | | |
|filename&#124;authentihash| | | X | X | | |
|filename&#124;impfuzzy| | | X | X | | |
|filename&#124;imphash| | | X | X | | |
|filename&#124;md5| | | X | X | | |
|filename&#124;pehash| | | X | X | | |
|filename&#124;sha1| | | X | X | | |
|filename&#124;sha224| | | X | X | | |
|filename&#124;sha256| | | X | X | | |
|filename&#124;sha3-224| | | X | X | | |
|filename&#124;sha3-256| | | X | X | | |
|filename&#124;sha3-384| | | X | X | | |
|filename&#124;sha3-512| | | X | X | | |
|filename&#124;sha384| | | X | X | | |
|filename&#124;sha512| | | X | X | | |
|filename&#124;sha512/224| | | X | X | | |
|filename&#124;sha512/256| | | X | X | | |
|filename&#124;ssdeep| | | X | X | | |
|filename&#124;tlsh| | | X | X | | |
|filename&#124;vhash| | | X | X | | |
|first-name| | | | | | |
|float| | X | | | | |
|frequent-flyer-number| | | | | | |
|full-name| | | | | | |
|gender| | | | | | |
|gene| | | | | | |
|git-commit-id| | | | | | |
|github-organisation| | | | | | |
|github-repository| | | | | | |
|github-username| | | | | | |
|hassh-md5| X | | X | | | |
|hasshserver-md5| X | | X | | | |
|hex| X | X | X | X | | X |
|hostname| X | | X | | | |
|hostname&#124;port| X | | X | | | |
|http-method| X | | | | | |
|iban| | | | | | |
|identity-card-number| | | | | | |
|impfuzzy| | | X | X | | |
|imphash| | | X | X | | |
|ip-dst| X | | X | | | |
|ip-dst&#124;port| X | | X | | | |
|ip-src| X | | X | | | |
|ip-src&#124;port| X | | X | | | |
|issue-date-of-the-visa| | | | | | |
|ja3-fingerprint-md5| X | | X | | | |
|jabber-id| | | | | | |
|jarm-fingerprint| X | | X | | | |
|kusto-query| | | | | | |
|last-name| | | | | | |
|link| | | X | | | |
|mac-address| X | | X | | | |
|mac-eui-64| X | | X | | | |
|malware-sample| | | X | X | | |
|malware-type| | | X | X | | |
|md5| | | X | X | | |
|middle-name| | | | | | |
|mime-type| | | X | X | | |
|mobile-application-id| | | X | X | | |
|mutex| | | | | | |
|named pipe| | | | | | |
|nationality| | | | | | |
|other| X | X | X | X | X | X |
|passenger-name-record-locator-number| | | | | | |
|passport-country| | | | | | |
|passport-expiration| | | | | | |
|passport-number| | | | | | |
|pattern-in-file| X | | X | X | | |
|pattern-in-memory| | | | X | | |
|pattern-in-traffic| X | | X | X | | |
|payment-details| | | | | | |
|pdb| | | | | | |
|pehash| | | X | X | | |
|pgp-private-key| | X | | | | |
|pgp-public-key| | X | | | | |
|phone-number| | X | | | | |
|place-of-birth| | | | | | |
|place-port-of-clearance| | | | | | |
|place-port-of-onward-foreign-destination| | | | | | |
|place-port-of-original-embarkation| | | | | | |
|port| X | X | | | | |
|primary-residence| | | | | | |
|process-state| | | | | | |
|prtn| | | | | | |
|redress-number| | | | | | |
|regkey| | | | | | X |
|regkey&#124;value| | | | | | X |
|sha1| | | X | X | | |
|sha224| | | X | X | | |
|sha256| | | X | X | | |
|sha3-224| | | X | X | | |
|sha3-256| | | X | X | | |
|sha3-384| | | X | X | | |
|sha3-512| | | X | X | | |
|sha384| | | X | X | | |
|sha512| | | X | X | | |
|sha512/224| | | X | X | | |
|sha512/256| | | X | X | | |
|sigma| | | X | X | | |
|size-in-bytes| | X | | | | |
|snort| X | | | | | |
|special-service-request| | | | | | |
|ssdeep| | | X | X | | |
|ssh-fingerprint| X | | | | | |
|stix2-pattern| X | | X | X | | |
|target-email| | | | | | |
|target-external| | | | | | |
|target-location| | | | | | |
|target-machine| | | | | | |
|target-org| | | | | | |
|target-user| | | | | | |
|telfhash| | | X | X | | |
|text| X | X | X | X | X | X |
|threat-actor| | | | | | |
|tlsh| | | X | X | | |
|travel-details| | | | | | |
|twitter-id| | | | | | |
|uri| X | | | | | |
|url| X | | X | | | |
|user-agent| X | | X | | | |
|vhash| | | X | X | | |
|visa-number| | | | | | |
|vulnerability| | | X | X | | |
|weakness| | | X | X | | |
|whois-creation-date| | | | | | |
|whois-registrant-email| | | X | | | |
|whois-registrant-name| | | | | | |
|whois-registrant-org| | | | | | |
|whois-registrant-phone| | | | | | |
|whois-registrar| | | | | | |
|windows-scheduled-task| | | | | | |
|windows-service-displayname| | | | | | |
|windows-service-name| | | | | | |
|x509-fingerprint-md5| X | | X | X | | |
|x509-fingerprint-sha1| X | | X | X | | |
|x509-fingerprint-sha256| X | | X | X | | |
|xmr| | | | | | |
|yara| | | X | X | | |
|zeek| X | | | | | |

|Category| Person | Social network | Support Tool | Targeting data |
| --- |:---:|:---:|:---:|:---:|
|AS| | | | |
|aba-rtn| | | | |
|anonymised| X | X | X | X |
|attachment| | | X | |
|authentihash| | | | |
|azure-application-id| | | | |
|bank-account-nr| | | | |
|bic| | | | |
|bin| | | | |
|boolean| | | | |
|bro| | | | |
|btc| | | | |
|campaign-id| | | | |
|campaign-name| | | | |
|cc-number| | | | |
|cdhash| | | | |
|chrome-extension-id| | | | |
|comment| X | X | X | X |
|community-id| | | | |
|cookie| | | | |
|cortex| | | | |
|counter| | | | |
|country-of-residence| X | | | |
|cpe| | | | |
|dash| | | | |
|date-of-birth| X | | | |
|datetime| | | | |
|dkim| | | | |
|dkim-signature| | | | |
|dns-soa-email| | | | |
|domain| | | | |
|domain&#124;ip| | | | |
|email| X | X | | |
|email-attachment| | | | |
|email-body| | | | |
|email-dst| | X | | |
|email-dst-display-name| | | | |
|email-header| | | | |
|email-message-id| | | | |
|email-mime-boundary| | | | |
|email-reply-to| | | | |
|email-src| | X | | |
|email-src-display-name| | | | |
|email-subject| | | | |
|email-thread-index| | | | |
|email-x-mailer| | | | |
|eppn| | X | | |
|favicon-mmh3| | | | |
|filename| | | | |
|filename-pattern| | | | |
|filename&#124;authentihash| | | | |
|filename&#124;impfuzzy| | | | |
|filename&#124;imphash| | | | |
|filename&#124;md5| | | | |
|filename&#124;pehash| | | | |
|filename&#124;sha1| | | | |
|filename&#124;sha224| | | | |
|filename&#124;sha256| | | | |
|filename&#124;sha3-224| | | | |
|filename&#124;sha3-256| | | | |
|filename&#124;sha3-384| | | | |
|filename&#124;sha3-512| | | | |
|filename&#124;sha384| | | | |
|filename&#124;sha512| | | | |
|filename&#124;sha512/224| | | | |
|filename&#124;sha512/256| | | | |
|filename&#124;ssdeep| | | | |
|filename&#124;tlsh| | | | |
|filename&#124;vhash| | | | |
|first-name| X | | | |
|float| | | | |
|frequent-flyer-number| X | | | |
|full-name| X | | | |
|gender| X | | | |
|gene| | | | |
|git-commit-id| | | | |
|github-organisation| | X | | |
|github-repository| | X | | |
|github-username| | X | | |
|hassh-md5| | | | |
|hasshserver-md5| | | | |
|hex| | | X | |
|hostname| | | | |
|hostname&#124;port| | | | |
|http-method| | | | |
|iban| | | | |
|identity-card-number| X | | | |
|impfuzzy| | | | |
|imphash| | | | |
|ip-dst| | | | |
|ip-dst&#124;port| | | | |
|ip-src| | | | |
|ip-src&#124;port| | | | |
|issue-date-of-the-visa| X | | | |
|ja3-fingerprint-md5| | | | |
|jabber-id| | X | | |
|jarm-fingerprint| | | | |
|kusto-query| | | | |
|last-name| X | | | |
|link| | | X | |
|mac-address| | | | |
|mac-eui-64| | | | |
|malware-sample| | | | |
|malware-type| | | | |
|md5| | | | |
|middle-name| X | | | |
|mime-type| | | | |
|mobile-application-id| | | | |
|mutex| | | | |
|named pipe| | | | |
|nationality| X | | | |
|other| X | X | X | |
|passenger-name-record-locator-number| X | | | |
|passport-country| X | | | |
|passport-expiration| X | | | |
|passport-number| X | | | |
|pattern-in-file| | | | |
|pattern-in-memory| | | | |
|pattern-in-traffic| | | | |
|payment-details| X | | | |
|pdb| | | | |
|pehash| | | | |
|pgp-private-key| X | X | | |
|pgp-public-key| X | X | | |
|phone-number| X | | | |
|place-of-birth| X | | | |
|place-port-of-clearance| X | | | |
|place-port-of-onward-foreign-destination| X | | | |
|place-port-of-original-embarkation| X | | | |
|port| | | | |
|primary-residence| X | | | |
|process-state| | | | |
|prtn| | | | |
|redress-number| X | | | |
|regkey| | | | |
|regkey&#124;value| | | | |
|sha1| | | | |
|sha224| | | | |
|sha256| | | | |
|sha3-224| | | | |
|sha3-256| | | | |
|sha3-384| | | | |
|sha3-512| | | | |
|sha384| | | | |
|sha512| | | | |
|sha512/224| | | | |
|sha512/256| | | | |
|sigma| | | | |
|size-in-bytes| | | | |
|snort| | | | |
|special-service-request| X | | | |
|ssdeep| | | | |
|ssh-fingerprint| | | | |
|stix2-pattern| | | | |
|target-email| | | | X |
|target-external| | | | X |
|target-location| | | | X |
|target-machine| | | | X |
|target-org| | | | X |
|target-user| | | | X |
|telfhash| | | | |
|text| X | X | X | |
|threat-actor| | | | |
|tlsh| | | | |
|travel-details| X | | | |
|twitter-id| | X | | |
|uri| | | | |
|url| | | | |
|user-agent| | | | |
|vhash| | | | |
|visa-number| X | | | |
|vulnerability| | | | |
|weakness| | | | |
|whois-creation-date| | | | |
|whois-registrant-email| | X | | |
|whois-registrant-name| | | | |
|whois-registrant-org| | | | |
|whois-registrant-phone| | | | |
|whois-registrar| | | | |
|windows-scheduled-task| | | | |
|windows-service-displayname| | | | |
|windows-service-name| | | | |
|x509-fingerprint-md5| | | | |
|x509-fingerprint-sha1| | | | |
|x509-fingerprint-sha256| | | | |
|xmr| | | | |
|yara| | | | |
|zeek| | | | |


### Categories

*   **Antivirus detection**: All the info about how the malware is detected by the antivirus products
*   **Artifacts dropped**: Any artifact (files, registry keys etc.) dropped by the malware or other modifications to the system
*   **Attribution**: Identification of the group, organisation, or country behind the attack
*   **External analysis**: Any other result from additional analysis of the malware like tools output
*   **Financial fraud**: Financial Fraud indicators
*   **Internal reference**: Reference used by the publishing party (e.g. ticket number)
*   **Network activity**: Information about network traffic generated by the malware
*   **Other**: Attributes that are not part of any other category or are meant to be used as a component in MISP objects in the future
*   **Payload delivery**: Information about how the malware is delivered
*   **Payload installation**: Info on where the malware gets installed in the system
*   **Payload type**: Information about the final payload(s)
*   **Persistence mechanism**: Mechanisms used by the malware to start at boot
*   **Person**: A human being - natural person
*   **Social network**: Social networks and platforms
*   **Support Tool**: Tools supporting analysis or detection of the event
*   **Targeting data**: Internal Attack Targeting and Compromise Information

### Types

*   **AS**: Autonomous system
*   **aba-rtn**: ABA routing transit number
*   **anonymised**: Anonymised value - described with the anonymisation object via a relationship
*   **attachment**: Attachment with external information
*   **authentihash**: Authenticode executable signature hash
*   **azure-application-id**: Azure Application ID.
*   **bank-account-nr**: Bank account number without any routing number
*   **bic**: Bank Identifier Code Number also known as SWIFT-BIC, SWIFT code or ISO 9362 code
*   **bin**: Bank Identification Number
*   **boolean**: Boolean value - to be used in objects
*   **bro**: An NIDS rule in the Bro rule-format
*   **btc**: Bitcoin Address
*   **campaign-id**: Associated campaign ID
*   **campaign-name**: Associated campaign name
*   **cc-number**: Credit-Card Number
*   **cdhash**: An Apple Code Directory Hash, identifying a code-signed Mach-O executable file
*   **chrome-extension-id**: Chrome extension id
*   **comment**: Comment or description in a human language
*   **community-id**: A community ID flow hashing algorithm to map multiple traffic monitors into common flow id
*   **cookie**: HTTP cookie as often stored on the user web client. This can include authentication cookie or session cookie.
*   **cortex**: Cortex analysis result
*   **counter**: An integer counter, generally to be used in objects
*   **country-of-residence**: The country of residence of a natural person
*   **cpe**: Common Platform Enumeration - structured naming scheme for information technology systems, software, and packages.
*   **dash**: Dash Address
*   **date-of-birth**: Date of birth of a natural person (in YYYY-MM-DD format)
*   **datetime**: Datetime in the ISO 8601 format
*   **dkim**: DKIM public key
*   **dkim-signature**: DKIM signature
*   **dns-soa-email**: RFC 1035 mandates that DNS zones should have a SOA (Statement Of Authority) record that contains an email address where a PoC for the domain could be contacted. This can sometimes be used for attribution/linkage between different domains even if protected by whois privacy
*   **domain**: A domain name used in the malware
*   **domain&#124;ip**: A domain name and its IP address (as found in DNS lookup) separated by a &#124;
*   **email**: An email address
*   **email-attachment**: File name of the email attachment.
*   **email-body**: Email body
*   **email-dst**: The destination email address. Used to describe the recipient when describing an e-mail.
*   **email-dst-display-name**: Email destination display name
*   **email-header**: Email header
*   **email-message-id**: The email message ID
*   **email-mime-boundary**: The email mime boundary separating parts in a multipart email
*   **email-reply-to**: Email reply to header
*   **email-src**: The source email address. Used to describe the sender when describing an e-mail.
*   **email-src-display-name**: Email source display name
*   **email-subject**: The subject of the email
*   **email-thread-index**: The email thread index header
*   **email-x-mailer**: Email x-mailer header
*   **eppn**: eduPersonPrincipalName - eppn - the NetId of the person for the purposes of inter-institutional authentication. Should be stored in the form of user@univ.edu, where univ.edu is the name of the local security domain.
*   **favicon-mmh3**: favicon-mmh3 is the murmur3 hash of a favicon as used in Shodan.
*   **filename**: Filename
*   **filename-pattern**: A pattern in the name of a file
*   **filename&#124;authentihash**: A filename and Authenticode executable signature hash
*   **filename&#124;impfuzzy**: Import fuzzy hash - a fuzzy hash created based on the imports in the sample.
*   **filename&#124;imphash**: Import hash - a hash created based on the imports in the sample.
*   **filename&#124;md5**: A filename and an MD5 hash separated by a &#124;
*   **filename&#124;pehash**: A filename and a peHash separated by a &#124;
*   **filename&#124;sha1**: A filename and an SHA1 hash separated by a &#124;
*   **filename&#124;sha224**: A filename and a SHA-224 hash separated by a &#124;
*   **filename&#124;sha256**: A filename and an SHA256 hash separated by a &#124;
*   **filename&#124;sha3-224**: A filename and an SHA3-224 hash separated by a &#124;
*   **filename&#124;sha3-256**: A filename and an SHA3-256 hash separated by a &#124;
*   **filename&#124;sha3-384**: A filename and an SHA3-384 hash separated by a &#124;
*   **filename&#124;sha3-512**: A filename and an SHA3-512 hash separated by a &#124;
*   **filename&#124;sha384**: A filename and a SHA-384 hash separated by a &#124;
*   **filename&#124;sha512**: A filename and a SHA-512 hash separated by a &#124;
*   **filename&#124;sha512/224**: A filename and a SHa-512/224 hash separated by a &#124;
*   **filename&#124;sha512/256**: A filename and a SHA-512/256 hash separated by a &#124;
*   **filename&#124;ssdeep**: A checksum in ssdeep format
*   **filename&#124;tlsh**: A filename and a Trend Micro Locality Sensitive Hash separated by a &#124;
*   **filename&#124;vhash**: A filename and a VirusTotal hash separated by a &#124;
*   **first-name**: First name of a natural person
*   **float**: A floating point value.
*   **frequent-flyer-number**: The frequent flyer number of a passenger
*   **full-name**: Full name of a natural person
*   **gender**: The gender of a natural person (Male, Female, Other, Prefer not to say)
*   **gene**: GENE - Go Evtx sigNature Engine
*   **git-commit-id**: A Git commit ID.
*   **github-organisation**: A GitHub organisation
*   **github-repository**: A Github repository
*   **github-username**: A GitHub user name
*   **hassh-md5**: hassh is a network fingerprinting standard which can be used to identify specific Client SSH implementations. The fingerprints can be easily stored, searched and shared in the form of an MD5 fingerprint.
*   **hasshserver-md5**: hasshServer is a network fingerprinting standard which can be used to identify specific Server SSH implementations. The fingerprints can be easily stored, searched and shared in the form of an MD5 fingerprint.
*   **hex**: A value in hexadecimal format
*   **hostname**: A full host/dnsname of an attacker
*   **hostname&#124;port**: Hostname and port number separated by a &#124;
*   **http-method**: HTTP method used by the malware (e.g. POST, GET, ...).
*   **iban**: International Bank Account Number
*   **identity-card-number**: Identity card number
*   **impfuzzy**: A fuzzy hash of import table of Portable Executable format
*   **imphash**: Import hash - a hash created based on the imports in the sample.
*   **ip-dst**: A destination IP address of the attacker or C&C server
*   **ip-dst&#124;port**: IP destination and port number separated by a &#124;
*   **ip-src**: A source IP address of the attacker
*   **ip-src&#124;port**: IP source and port number separated by a &#124;
*   **issue-date-of-the-visa**: The date on which the visa was issued
*   **ja3-fingerprint-md5**: JA3 is a method for creating SSL/TLS client fingerprints that should be easy to produce on any platform and can be easily shared for threat intelligence.
*   **jabber-id**: Jabber ID
*   **jarm-fingerprint**: JARM is a method for creating SSL/TLS server fingerprints.
*   **kusto-query**: Kusto query - Kusto from Microsoft Azure is a service for storing and running interactive analytics over Big Data.
*   **last-name**: Last name of a natural person
*   **link**: Link to an external information
*   **mac-address**: MAC address
*   **mac-eui-64**: MAC EUI-64 address
*   **malware-sample**: Attachment containing encrypted malware sample
*   **malware-type**: 
*   **md5**: A checksum in MD5 format
*   **middle-name**: Middle name of a natural person
*   **mime-type**: A media type (also MIME type and content type) is a two-part identifier for file formats and format contents transmitted on the Internet
*   **mobile-application-id**: The application id of a mobile application
*   **mutex**: Mutex, use the format \BaseNamedObjects\<Mutex>
*   **named pipe**: Named pipe, use the format \.\pipe\<PipeName>
*   **nationality**: The nationality of a natural person
*   **other**: Other attribute
*   **passenger-name-record-locator-number**: The Passenger Name Record Locator is a key under which the reservation for a trip is stored in the system. The PNR contains, among other data, the name, flight segments and address of the passenger. It is defined by a combination of five or six letters and numbers.
*   **passport-country**: The country in which the passport was issued
*   **passport-expiration**: The expiration date of a passport
*   **passport-number**: The passport number of a natural person
*   **pattern-in-file**: Pattern in file that identifies the malware
*   **pattern-in-memory**: Pattern in memory dump that identifies the malware
*   **pattern-in-traffic**: Pattern in network traffic that identifies the malware
*   **payment-details**: Payment details
*   **pdb**: Microsoft Program database (PDB) path information
*   **pehash**: peHash - a hash calculated based of certain pieces of a PE executable file
*   **pgp-private-key**: A PGP private key
*   **pgp-public-key**: A PGP public key
*   **phone-number**: Telephone Number
*   **place-of-birth**: Place of birth of a natural person
*   **place-port-of-clearance**: The port of clearance
*   **place-port-of-onward-foreign-destination**: A Port where the passenger is transiting to
*   **place-port-of-original-embarkation**: The original port of embarkation
*   **port**: Port number
*   **primary-residence**: The primary residence of a natural person
*   **process-state**: State of a process
*   **prtn**: Premium-Rate Telephone Number
*   **redress-number**: The Redress Control Number is the record identifier for people who apply for redress through the DHS Travel Redress Inquiry Program (DHS TRIP). DHS TRIP is for travelers who have been repeatedly identified for additional screening and who want to file an inquiry to have erroneous information corrected in DHS systems
*   **regkey**: Registry key or value
*   **regkey&#124;value**: Registry value + data separated by &#124;
*   **sha1**: A checksum in SHA1 format
*   **sha224**: A checksum in SHA-224 format
*   **sha256**: A checksum in SHA256 format
*   **sha3-224**: A checksum in SHA3-224 format
*   **sha3-256**: A checksum in SHA3-256 format
*   **sha3-384**: A checksum in SHA3-384 format
*   **sha3-512**: A checksum in SHA3-512 format
*   **sha384**: A checksum in SHA-384 format
*   **sha512**: A checksum in SHA-512 format
*   **sha512/224**: A checksum in the SHA-512/224 format
*   **sha512/256**: A checksum in the SHA-512/256 format
*   **sigma**: Sigma - Generic Signature Format for SIEM Systems
*   **size-in-bytes**: Size expressed in bytes
*   **snort**: An IDS rule in Snort rule-format
*   **special-service-request**: A Special Service Request is a function to an airline to provide a particular facility for A Passenger or passengers. 
*   **ssdeep**: A checksum in ssdeep format
*   **ssh-fingerprint**: A fingerprint of SSH key material
*   **stix2-pattern**: STIX 2 pattern
*   **target-email**: Attack Targets Email(s)
*   **target-external**: External Target Organizations Affected by this Attack
*   **target-location**: Attack Targets Physical Location(s)
*   **target-machine**: Attack Targets Machine Name(s)
*   **target-org**: Attack Targets Department or Organization(s)
*   **target-user**: Attack Targets Username(s)
*   **telfhash**: telfhash is symbol hash for ELF files, just like imphash is imports hash for PE files.
*   **text**: Name, ID or a reference
*   **threat-actor**: A string identifying the threat actor
*   **tlsh**: A checksum in the Trend Micro Locality Sensitive Hash format
*   **travel-details**: Travel details
*   **twitter-id**: Twitter ID
*   **uri**: Uniform Resource Identifier
*   **url**: Uniform Resource Locator
*   **user-agent**: The user-agent used by the malware in the HTTP request.
*   **vhash**: A VirusTotal checksum
*   **visa-number**: Visa number
*   **vulnerability**: A reference to the vulnerability used in the exploit
*   **weakness**: A reference to the weakness (CWE) used in the exploit
*   **whois-creation-date**: The date of domain's creation, obtained from the WHOIS information.
*   **whois-registrant-email**: The e-mail of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrant-name**: The name of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrant-org**: The org of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrant-phone**: The phone number of a domain's registrant, obtained from the WHOIS information.
*   **whois-registrar**: The registrar of the domain, obtained from the WHOIS information.
*   **windows-scheduled-task**: A scheduled task in windows
*   **windows-service-displayname**: A windows service's displayname, not to be confused with the windows-service-name. This is the name that applications will generally display as the service's name in applications.
*   **windows-service-name**: A windows service name. This is the name used internally by windows. Not to be confused with the windows-service-displayname.
*   **x509-fingerprint-md5**: X509 fingerprint in MD5 format
*   **x509-fingerprint-sha1**: X509 fingerprint in SHA-1 format
*   **x509-fingerprint-sha256**: X509 fingerprint in SHA-256 format
*   **xmr**: Monero Address
*   **yara**: YARA signature
*   **zeek**: An NIDS rule in the Zeek rule-format
