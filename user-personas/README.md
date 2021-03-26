# MISP user personas

These personas are fictitious but are concrete representations of the people using MISP. 
We can use these personas to keep in mind who we are working for, what are their needs, and what MISP should do for them.
These personas come from OSINT on current MISP users (Gitter chats, GitHub issues, LinkedIn) and other sources of information about cybersecurity.

## Primary personas
Farrah and Adam represent the users that are the most important to us.

### Farrah
_**The Threat Hunter**_

Farrah works as a threat intelligence for a security service provider in Malaysia that offers a range of cybersecurity solutions. 
He leads a threat intelligence team made up of experienced intelligence analysts who are former military/government employees and contractors.

Farrah uses MISP to analyze malware, gather information about specific adversary groups, and discover emerging threats. 
He also uses MISP for data normalization (consolidating data across different source formats), de-duplication (removal of duplicate information), and enrichment (removal of false positives, scoring of indicators, and the addition of context).

_"In order to effectively address threats, you must maintain a team focused on monitoring, generating and triaging alerts"_

#### Role
Lead Threat Intelligence Analyst

#### His primary goals are to: 
- Hunt down threats, analyze malware, manage vulnerabilities and prevent attacks against ICT infrastructures, organizations, or people.
- Improve  security posture through the aggregation,  correlation, and analysis of threat data from multiple sources
- Investigate and understand adversarial capabilities, infrastructure & TTPs.
- Turn threat data from various sources into actionable threat intelligence.

#### He uses MISP to:
- Dispatch notifications containing IoCs to various parties via mail_to_misp.
- Monitor feeds for indicators and correlate attributes and analyze malware (check ransom notes, look for any indicators, check the origin, etc).
- Store attack info in a structured format and allow for automated use of the database for various purposes using the API.
- Prioritize indicators using sighting reports and purge false positives using warning lists.
- Classify and contextualize data using taxonomies and galaxies, and keep track of the advancement of an analysis using tags.
- View and visualize events and activities using MISP-dashboard or Maltego.
- Automatically import, aggregate, compare, contextualize, query, and cross-reference data using PyMISP     
- Import, export and enrich data using MISP modules
- Aggregate, curate, and validate indicators from various feeds, then feed the data into detection and analysis tools like NIDs, IDS, and SIEMs
- Query vulnerability scan results in MISP, automatically create/classify events on matching results, then create blocklists by excluding attributes that exist on warning lists.
- Collaborate with others in a sharing community using Proposals (send and receive feedback), Extended Events (add additional information to other’s analytics), and Event Reports (supply resolution steps and recommendations).
- Share and receive reports of a specific threat, false positives, or post-mortem     analysis of an incident from sharing groups. 

#### His objectives are to:
- Join relevant sharing communities, produce and publish indicators and share information across sectors to avoid hybrid threats.
- Use IoCs from feeds to identify vulnerabilities, compromised assets, data leaks and to verify the results of a malware scan.
- Triage threat intel, prioritize vulnerabilities, and customize risk feeds to ignore or downgrade irrelevant alerts in order to avoid alert fatigue.     
- Generate and share alerts to provide critical information to internal teams and external peers.
- Share information about relevant vulnerabilities, coordinate with security vendors to get notifications, and community sharing of pentest results with other analysts.
- Research the evolution of high-risk malware families, validate malware signatures and domain reputations.
- Use indicators to query security logs/systems and databases, identify compromised systems, and add/modify signatures (used by firewalls, intrusion detection systems, etc), and block or alert on activity matching the indicators.
- Correlate shared indicators from feeds with those captured by other security and network tools to produce intelligence placed in the context of wider threat landscapes.
- Integrate with existing security solutions so as to centralize security in one place. Leverage integrations to alert on information leaks (AIL 2), hunt down threats (McAfee OpenDXL), share attacker’s techniques (ATT&CK), query and prioritize indicators (MVISION EDR), speed up investigations (Cytomic Orion), and enhance the power of threat data (Carbon Black).


### Adam
_**The Remediator**_

Adam is part of the Computer Security Incident Response Team (CSIRT) at a Belgian cybersecurity consulting firm. 
His responsibilities involve incident response, incident coordination, threat intelligence, and vulnerability management. 
He monitors potential threats, investigates attacks, and works with other security personnel to reduce the impact and severity of an attack.

Adam uses MISP to monitor incidents, provide early warnings/alerts about incidents, respond to incidents and provide incident analysis and situational awareness.

_“A breach alone is not a disaster, but mishandling it is. The goal is to handle the situation in a way that limits damage and reduces recovery and time costs”_

#### Role
Incident Response

#### His primary goals are to:

- Uncover the effects of attacks, determine how to clean up its impact, and inform a response to an existing incident to mitigate its extent or impacts.
- Develop and maintain strong processes for the most common incidents and threats, and create actionable results and remediation plans for internal stakeholders to proactively improve the security posture and maturity.
- Accelerate incident investigations, management, and prioritization by looking for information on the who/what/why/when/how of an incident. 
- Determine the scope of incidents and limit the potential damage.

#### He uses MISP to:
- Store incidents as a database of events, describe incidents through event classification (using taxonomies and galaxies) and use the API to deduce from all incidents the current operational status, risk posture, and threats to the cyber environment.
- Join sharing groups and communities to share incident information with others and discuss information related to risks associated with incidents via Forums, comments to events, and contact a reporter.
- Analyze observables/malware collected during an incident, determining whether they are IoCs or false positives using the correlation graph and expansion modules.     
- Alert and send emails when events are created in the system or major changes occur in the events, serving as part of an early warning system.     
- Pull events via the API or export IOCs in formats for easy ingestion into other tools (such as SIEMs and IDS) and carrying out investigations by launching lookups against databases.
- Collaborate and get feedback from team members and affected parties during incident response using Proposals.
- Dismiss false positives (using warning lists) and enable alert prioritization. 
- Aggregate and compare information from internal and external feeds to identify genuine threats.
- Perform large-scale data/traffic analysis and correlation through lookups against SightingDB.
- Share, receive, store and forward incidents and information identified during an incident investigation, enabling the MISP system to act as a forensic tool over time.     
- Correlate and reference network forensic flows from different tools or network equipment
- Speed up incident response via integration with TheHive.

#### His objectives are to:
- Share information and get critical alerts and relevant actionable information in the event of a crisis situation.
- Support forensic analysts and collaborate with law enforcement.
- Improve incident response functionality and increase coverage and detection  through integrations with tools like SIEMs.
- Use threat data to validate alarms/events and decide which to escalate to the rest of the incident response team for remediation.
- Aggregate information from various sources and correlating in order to understand how this data fits together in the broad threat landscape.
- Get insights (e.g using data feeds) into attacks, thereby helping incident response teams understand the nature, intent, and timing of specific attacks.
- Prioritize incidents based on risk and impact to the organization and filter out false alerts.


## Secondary personas

Tina, Henry, Jacob, and Sarah represent other users that are also important to us.

### Tina
_**The Fraud Catcher**_

Tina works as a fraud analyst at a National bank in Canada. She is responsible for investigating any forgery or theft within customers' accounts and transactions on behalf of the bank.

Tina uses MISP to find and share financial indicators in order to detect financial frauds.

_"Fighting fraud with threat intelligence is all about alerting"_

#### Role
Fraud analyst

#### Her primary goals are to:
- Identify and trace fraudulent activity.
- Create models for analyzing and determining financial fraud in order to protect consumers and stakeholders.
- Assess and analyze the attack surface, conduct threat modeling, and deliver actionable intelligence with a focus on current and emerging cyber-attacks against financial sector assets.

#### She uses MISP to:
- Map legacy and internal systems/models using MISP objects.
- Find IoCs, malware, vulnerabilities, financial threat, fraud information and share data between other banks and financial institutions using sharing groups.
- Create, modify and visualize the timeline of events, use MISP Dashboard to provide real-time information showing current threats and activity.
- Minimize false positives during the fraud vetting process using warning lists and sightings.
- Detect fraud using threat intel such as real-time notifications for stolen credit cards and phishing URLs from MISP feeds.
- Prevent fraud by integrating MISP with a network of crawlers, honeypots, and  other techniques that can cross-reference indicators against feeds, enabling the bank to intercept cards before they are sold on the black market and therefore reduce this risk of fraud.
- Monitor feeds for specific indicators (e.g. email header content, attachments, embedded URLs) related to phishing and fraud attacks.
- Block wire transfers to money mule accounts by integrating MISP warning lists and sightings with blocking systems.
- Aggregate sightings of attributes/objects so as to detect particular security events or threats.

#### Her objectives are to:
- Investigate financial indicators and handle false positives in order to detect and alert for certain potentially invalid data points.
- Aggregate, correlate, and analyze financial indicators from multiple feeds to discover any fraudulent activity.
- Blend threat intel from MISP with anti-fraud tools to identify and prevent fraud in real-time.
- Use threat intel to produce awareness reports informing the institution of threats in the financial sector, and then develop proactive defense strategies against fraud activity.
- Engage with sharing communities that allow individual enterprises to receive and share data so they can protect themselves before they are compromised.

### Henry
_**The Enforcer**_

Henry is a law enforcement officer living in Florida, USA. He works with the Digital Forensics and Incident Response (DFIR) team. 
He is responsible for investigating digital security incidents, identifying digital assets targeted during attacks, and documenting all findings.

He uses MISP to support or bootstrap his DFIR cases.

_"I worry about what I don’t know, not what I know"_

#### Role
Law Enforcement Officer

#### His primary goals are to:
- Find, gather and analyze digital evidence for criminal investigations. 
- Carry out data breach and malware investigations.

#### He uses MISP to:
- Propose changes to existing analyses or reports.
- Correlate (1-to-1 value matches, fuzzy hashing, CIDR block matching) evidence against external/local attributes.     
- Correlate and reference network forensic flows from different tools or network equipment using the community-id feature.
- Export data in various formats to feed into and lookup in other security tools.
- Join sharing groups and collaborate with other investigators. 
- Receive, gather, analyze and share intelligence on digital crimes.
- Report digital evidence (in STIX) in a structured way for forensic use.
- Collect evidence for forensic analysis from feeds, using shared indicators to carry out cybercriminal behavior investigations, attribution, and identifying the link to organized crime activities.
- Exchange, store and forward incidents/information identified during an incident investigation, enabling the MISP system to act as a forensic tool over time.

#### His objectives are to:
- Share indicators, analyses, and reports of forensic evidence among other law enforcement officers within and out of his team.
- Collaborate with CSIRT/CERTs and security researchers in the investigation of cyberattacks.
- Correlate data identified in a recent incident with data from previous investigations or external feeds.
- Bridge their use-cases with MISP’s information-sharing mechanism.


### Jacob
_**The Veteran**_

Jacob is a cybersecurity consultant for organizations looking to secure their infrastructure. 
He has founded a cybersecurity agency that provides threat intel and security consulting services to small and medium-sized businesses. 

Jacob uses MISP to investigate threats and find IOCs. 
He works with many clients and typically wants to integrate MISP into existing client solutions.

_"There’s a difference between threat data and threat intelligence"_

#### Role
Cyber Security consultant

#### His primary goals are to:
- Produce intelligence that will be embedded into organizational workflows and would serve decision-makers.
- Scope and implement custom security solutions across a variety of client software, architectures, and tools.
- Detect, contain, and remediate cybersecurity incidents, manually or programmatically.

#### He uses MISP to:
- Create, collaborate, automate and share threat intel using flexible sharing groups, automatic correlation, free-text import helper, event distribution, and proposals.
- Allow users to notify a MISP instance about activities (gotten from SIEMs, NIDS, honeypot devices, etc) related to an indicator using sightings.
- Monitor feeds delivered through a REST API and correlate IOCs with firewall and other logs to identify potential threats in the organization.
- Push/pull events between local and client MISP instances in order to exchange intel internally and externally.
- Import, export, and enrich data using modules, automate such tasks using PyMISP.
- Create sub-communities and MISP object templates to allow rapid sharing of information using specific data models with existing communities.
- Validate data and flag false positives using warning lists and sightings.
- View live data/statistics and process information in real-time through integration with ZMQ to access MISP-dashboard.
- Pseudo-anonymously publish data using the MISP delegation system.
- Contextualize shared information within MISP instances and communities (using taxonomies and tags), and attach more complex structures to data (using MITRE ATT&CK and other galaxies)

#### His objectives are to:
- Run a Cyber Threat Intel platform using MISP integrated with existing client solutions (such as Active Directory, Splunk ES, ThreatConnect, Recorded Future, and Crowdstrike).
- Gather unstructured data from various sources and connect the dots to provide context on IoCs and TTPs of threat actors.
- Identify incoming threats, triage and prioritize alerts as they emerge.
- Feed SIEMs from MISP and feed MISP from other sources (SIEMs included).
- Share incidents and IOCs for detection (checking if IoCs are present in client infrastructure), blocking (using attributes to block, sinkhole, or divert the traffic), and intelligence (gathering information about campaigns and attacks) purposes.

### Jay
_**The Inquisitor**_

Jay is a risk analyst for a large technology company in the USA. 
He is responsible for identifying and predicting risks, as well as forecasting the cost of certain attacks to the organization.

Jay uses MISP data to learn about the broad threat landscape and analyze the likelihood of certain risks, so as to gain situational awareness.

_"The more certain you can be about the probability of a specific exploit impacting your environment, the easier it is to manage risk"_

#### Role
Risk analyst

#### His primary goals are to:
- Improve the organization’s security posture, situational awareness, and resilience.
- Forecast evolving threats before they materialize, provide detailed insights into which vulnerabilities pose the greatest risk, and plan accordingly to avoid them.
- Assess business and technical risks, identify the right strategies and technologies to mitigate the risks, communicate the nature of the risks to top management and justify investments in defensive measures.

#### He uses MISP to:
- Monitor trends and adversary TTPs within the company’s sector/geographical region, share and track information emerging on a particular topic from the MISP dashboard in order to gain situational awareness.
- Monitor IoCs from various technical feeds and add additional context to internal sources of data using the automatic correlation engine.
- Access risk scores using correlation and sightings.
- Present data using different export formats, event reports, and the MISP dashboard timeline.

#### His objectives are to:
- Use shared indicators to perform a risk assessment, identify key information/assets and illustrate the intent/capability of actors to target these assets through impact assessments.
- Score threats according to the organization’s specific needs and prepare processes in advance based on threat data gathered from feeds
- Present data to stakeholders in various formats – articles, timelines, graphs, raw data – depending on their technical knowledge.
- Gain shared situational awareness through information sharing and collaboration with other experts in the same sector.

### Sarah
_**The Fact Checker**_

Sarah is a disinformation researcher and journalist working for a large American newspaper. 
She works with security researchers around the world to investigate cybercrimes and report disinformation. 
In the past, she has written about national security and geopolitics. She is used to making decisions on what should or shouldn't be published or shared.

Sarah uses MISP to collaborate with security researchers and investigate disinformation as it happens.

_"Decisions as to what is or isn't published or shared go far beyond what is technically interesting"_

#### Role
Disinformation researcher and journalist

#### Her primary goals are to:
- Conduct research and write intelligence reports about up-and-coming emerging threats and recent breaches.
- Investigate and report disinformation as it happens.
- Convert technical data into articles and reports that non-technical people can understand.

#### She uses MISP to:
- Write/read event reports, create misinformation events using relevant techniques found in a report or sighting.
- Join sharing groups and communities (e.g Cogsec Collab) that connect misinformation researchers and responders, share incident data with organizations focusing on response and counter-campaigns.
- Integrate with the AM!TT Framework (as a galaxy) in order to describe misinformation tactics/techniques, break an incident into techniques that can be analyzed/countered, and check for disinformation through mapping.
- Monitor feeds, investigate disinformation using shared indicators in feeds, generate structured intelligence using the automated correlation     engine, and decide if there are any falsehoods in data.
- Enrich threat data by adding object types, new relationship types (to make the graphs that users can traverse in MISP richer), and taxonomies     to cover things like types of threat actors.     
- Classify events, indicators, and threats using taxonomies (such as the Admiralty Scale taxonomy), which ranks the reliability of a source and the credibility of the information.

#### Her objectives are to:
- Distill essential information from a large piece of data, making it clear to the reader what really matters.
- Integrate MISP with TheHive for enhanced disinformation investigation and reporting. 
- Verify that an article (or image, video, etc) doesn’t contain disinformation and verify that a source (publisher, domain, etc) doesn’t distribute disinformation.
- Extend MISP for disinformation, adding object types for incidents and narratives, and using AMITT for attack patterns.

## Other personas
Malcolm represents users that we care about but aren't so important to us.

### Malcolm
_**The Data Expert**_

Malcolm is a data scientist for a telecom operator in the USA. 
He assists the Security Operations Center with tasks related to anomaly detection, exploratory data analysis, data visualization, modeling, and optimization of security solutions.

Malcolm uses data from MISP alongside natural language processing, predictive modeling, and other data science techniques to assess, prioritize, and even predict risk. 
He can process threat data to help with alert prioritization and data-driven decision making.

_"It is a mistake to theorize before one has data. Insensibly, one begins to twist facts to suit theories, instead of theories to suit facts"_

#### Role
Data Scientist

#### His primary goals are to:
- Develop tools to help businesses detect threats so they can develop solid plans of action and better protect themselves.
- Make predictions, perform data analysis, and detect patterns in data.     
- Support the threat analysis team with the development of new and innovative  ways of extracting insight from large sets of structured and unstructured data.     
- Translate complex data into relevant insights and visualize information.

#### He uses MISP to:
- Collect IoCs and sift through data from feeds to derive useful insights and connect dots between actors from various sources.
- Join sharing groups to collaborate with threat analysts and reduce analysts’ workload by taking on many tasks related to data collection and correlation.
- Automatically aggregate, parse, de-duplicate, and manage indicators using the API.     
- Visualize events in real-time by setting up MISP-dashboard.
- Export large threat data sets that can be used to train ML models

#### His objectives are to:
- Combine data from MISP and other security sources to find patterns/relationships in data, develop models, assess, prioritize, and predict risk using data science and AI techniques.     
- Produce informative visualizations and knowledge graphs based on large data sets.     
- Eliminate manual tasks by writing scripts that automatically aggregate, parse, de-duplicate, and manage indicators in MISP.
- Classify risks in order to save analysts time sorting through false positives and deciding what to prioritize.
