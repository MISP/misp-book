<!-- toc -->

## Galaxies

Galaxies in MISP are a method used to express a large object called cluster that can be attached to MISP events or attributes. A cluster can be composed of one or more elements. Elements are expressed as key-values.

There are default vocabularies available in MISP galaxy but those can be overwritten, replaced or updated as you wish. Vocabularies are from existing standards (like [STIX](https://oasis-open.github.io/cti-documentation/stix/intro), [Veris](http://veriscommunity.net/veris-overview.html), [ATT&CK](https://attack.mitre.org/), MISP and so on) or custom ones you only use for your organization.

Existing clusters and vocabularies can be used as-is or as a template. MISP distribution can be applied to each cluster to permit a limited or broader distribution scheme.

The objective is to have a common set of clusters for organizations starting analysis but that can be expanded to localized information (which is not shared) or additional information (that can be shared).

[MISP galaxy](https://github.com/MISP/misp-galaxy) is available on Github.

### Managing Galaxies in MISP

> [warning] You need to have a specific role to manage Galaxies on a MISP instance.

Galaxies management is accessed using the Galaxies link on the top menu.

![MenuGalaxy](./figures/GalaxyMenu.png)

A list with all the galaxies existing on the server will appear.

![GalaxyView](./figures/GalaxyView.png)

Each galaxy can be explored using the **View** icon at the end of the line.

![GalaxyList](./figures/GalaxyList.png)

Here the metadata of the selected galaxy is shown. You also see a table with each available value as well as some complementary data such as a description of the value or the activity (MISP Sightings), that is to say the evolution of the use of each value.

Galaxies can be reimported from the submodules by clicking the "Update Galaxies" link on either the galaxies list or while browsing a specific galaxy. A popup will appear to confirm the reimportation.

![GalaxyUpdate](./figures/GalaxyUpdate.png)

All galaxies will always be updated, even while browsing a specific galaxy.

### Adding a custom Galaxy repository in MISP (WiP - notFunctional)

[Fork](https://help.github.com/articles/fork-a-repo/) the [misp-galaxy](https://github.com/MISP/misp-galaxy/) repository to your github account.

Once you have forked the repo you can do the following, assuming you have followed the Standard MISP Install.

```bash
cd /var/www/MISP/app/files/
sudo rm -rf misp-galaxy
# Replace the following line with your fork
sudo -u www-data git clone https://github.com/SteveClement/misp-galaxy.git
```

Once this is done double check if you can still see the Galaxies in the Web UI.

> [warning] This will impact the UI "Update MISP" functionality in administration. Your git head might get [detached](https://git-scm.com/docs/gitglossary#gitglossary-aiddefdetachedHEADadetachedHEAD) in your misp-galaxy repo.

### Adding a new Galaxy (WiP - notFuctional)

#### Dependencies

To create your own Galaxies the following tools are needed to run the validation scripts.

- jsonschema (>v2.4)
- jq
- moreutils (sponge)

On a Debian flavoured distribution you can potentially do this:

```bash
sudo apt install jq moreutils python3-jsonschema
sudo wget -O /usr/local/bin/jsonschema https://gist.githubusercontent.com/SteveClement/e6ac60e153e9657913000216fc77c6ef/raw/c273ace06ad338d609dd2c84a0a6e215a268ea11/jsonschema
sudo chmod +x /usr/local/bin/jsonschema # This will only work with jsonschema >2.4 (before no CLI interface was available)
```


#### Create a fork

To add your custom Galaxy it is preferable to [fork](https://help.github.com/articles/fork-a-repo/) the [misp-galaxy](https://github.com/MISP/misp-galaxy/) repository. See above for details.

#### Understanding directory structure



#### Removing a Galaxy to better understand the add

Let's start with removing a single Galaxy. 

```bash
cd /var/www/MISP/app/files/misp-galaxy
sudo -u www-data rm galaxies/android.json
sudo -u www-data rm clusters/android.json
sudo -u www-data /var/www/MISP/app/Console/cake Admin updateGalaxies force
```

After this you will have removed the android Galaxy Cluster.


### Using Galaxies in MISP Events - Example

For this example, we will try to add a cluster to an existing event. This cluster contains information about  threat actor known as Sneaky Panda.

![EventWithoutCluster](./figures/EventWithoutCluster.png)

Here on the event view, we notice a blue frame under the metadatas with the title "Galaxies" and a button "Add new cluster". Let's click on the latter to begin.

![GalaxyPopup](./figures/GalaxyPopup.png)

A popup will appear proposising to explore a particular galaxy or all at the same time. Here, as we know we want to as a threat actor, we will choose the second option and scroll to find Sneaky Panda (We are courageous, aren't we?).

![NoSneakyPanda](./figures/NoSneakyPanda.png)

Wait. No Sneaky Panda? Hm that's strange. Or maybe it is only registred as a alias. Let's have a look! To do so we will use the search field which stay on top of the list. So what do we get? Beijing Group, is it an alias of our threat actor.


![Search](./figures/Search.png)

Pointing the cursor on it will give us the answer.

![Alias](./figures/Alias.png)

We have a match. So we select it and here we go.

![NewThreatActor](./figures/NewThreatActor.png)

Clicking on the magnifying glass next to Threat actor redirects to the list of all threat actors
Clicking on the magnifying glass next to Beijing Group redirects us to a page about this group
Clicking on the addition symbol on the left of Beijing Group extends the module.

### Available Galaxies

<!-- NB. This list is generated dynamically with gen-doc.sh included in this directory. -->

#### Clusters

[Android](https://github.com/MISP/misp-galaxy/blob/master/clusters/android.json) - Android malware galaxy based on multiple open sources.

[Backdoor](https://github.com/MISP/misp-galaxy/blob/master/clusters/backdoor.json) - A list of backdoor malware.

[Banker](https://github.com/MISP/misp-galaxy/blob/master/clusters/banker.json) - A list of banker malware.

[Botnet](https://github.com/MISP/misp-galaxy/blob/master/clusters/botnet.json) - botnet galaxy

[Branded vulnerability](https://github.com/MISP/misp-galaxy/blob/master/clusters/branded_vulnerability.json) - List of known vulnerabilities and attacks with a branding

[Cert eu govsector](https://github.com/MISP/misp-galaxy/blob/master/clusters/cert-eu-govsector.json) - Cert EU GovSector

[Exploit kit](https://github.com/MISP/misp-galaxy/blob/master/clusters/exploit-kit.json) - Exploit-Kit is an enumeration of some exploitation kits used by adversaries. The list includes document, browser and router exploit kits.It's not meant to be totally exhaustive but aim at covering the most seen in the past 5 years

[Malpedia](https://github.com/MISP/misp-galaxy/blob/master/clusters/malpedia.json) - Malware galaxy cluster based on Malpedia.

[Microsoft activity group](https://github.com/MISP/misp-galaxy/blob/master/clusters/microsoft-activity-group.json) - Activity groups as described by Microsoft

[Mitre attack pattern](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-attack-pattern.json) - ATT&CK tactic

[Mitre course of action](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-course-of-action.json) - ATT&CK Mitigation

[Mitre enterprise attack attack pattern](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-enterprise-attack-attack-pattern.json) - ATT&CK tactic

[Mitre enterprise attack course of action](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-enterprise-attack-course-of-action.json) - ATT&CK Mitigation

[Mitre enterprise attack intrusion set](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-enterprise-attack-intrusion-set.json) - Name of ATT&CK Group

[Mitre enterprise attack malware](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-enterprise-attack-malware.json) - Name of ATT&CK software

[Mitre enterprise attack tool](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-enterprise-attack-tool.json) - Name of ATT&CK software

[Mitre intrusion set](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-intrusion-set.json) - Name of ATT&CK Group

[Mitre malware](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-malware.json) - Name of ATT&CK software

[Mitre mobile attack attack pattern](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-mobile-attack-attack-pattern.json) - ATT&CK tactic

[Mitre mobile attack course of action](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-mobile-attack-course-of-action.json) - ATT&CK Mitigation

[Mitre mobile attack intrusion set](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-mobile-attack-intrusion-set.json) - Name of ATT&CK Group

[Mitre mobile attack malware](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-mobile-attack-malware.json) - Name of ATT&CK software

[Mitre mobile attack tool](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-mobile-attack-tool.json) - Name of ATT&CK software

[Mitre pre attack attack pattern](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-pre-attack-attack-pattern.json) - ATT&CK tactic

[Mitre pre attack intrusion set](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-pre-attack-intrusion-set.json) - Name of ATT&CK Group

[Mitre tool](https://github.com/MISP/misp-galaxy/blob/master/clusters/mitre-tool.json) - Name of ATT&CK software

[Preventive measure](https://github.com/MISP/misp-galaxy/blob/master/clusters/preventive-measure.json) - Preventive measures based on the ransomware document overview as published in https://docs.google.com/spreadsheets/d/1TWS238xacAto-fLKh1n5uTsdijWdCEsGIM0Y0Hvmc5g/pubhtml# . The preventive measures are quite generic and can fit any standard Windows infrastructure and their security measures.

[Ransomware](https://github.com/MISP/misp-galaxy/blob/master/clusters/ransomware.json) - Ransomware galaxy based on https://docs.google.com/spreadsheets/d/1TWS238xacAto-fLKh1n5uTsdijWdCEsGIM0Y0Hvmc5g/pubhtml and http://pastebin.com/raw/GHgpWjar

[Rat](https://github.com/MISP/misp-galaxy/blob/master/clusters/rat.json) - remote administration tool or remote access tool (RAT), also called sometimes remote access trojan, is a piece of software or programming that allows a remote "operator" to control a system as if they have physical access to that system.

[Sector](https://github.com/MISP/misp-galaxy/blob/master/clusters/sector.json) - Activity sectors

[Stealer](https://github.com/MISP/misp-galaxy/blob/master/clusters/stealer.json) - A list of malware stealer.

[Tds](https://github.com/MISP/misp-galaxy/blob/master/clusters/tds.json) - TDS is a list of Traffic Direction System used by adversaries

[Threat actor](https://github.com/MISP/misp-galaxy/blob/master/clusters/threat-actor.json) - Known or estimated adversary groups targeting organizations and employees. Adversary groups are regularly confused with their initial operation or campaign.

[Tool](https://github.com/MISP/misp-galaxy/blob/master/clusters/tool.json) - threat-actor-tools is an enumeration of tools used by adversaries. The list includes malware but also common software regularly used by the adversaries.

#### Vocabularies

##### Common

[Certainty level](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/common/certainty-level.json) - Certainty level of an associated element or cluster.

[Sector](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/common/sector.json) - List of activity sectors

[Threat actor type](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/common/threat-actor-type.json) - threat actor type vocab as defined by Cert EU.

[Ttp category](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/common/ttp-category.json) - ttp category vocab as defined by Cert EU.

[Ttp type](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/common/ttp-type.json) - ttp type vocab as defined by Cert EU.

##### threat-actor

[Cert eu motive](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/cert-eu-motive.json) - Motive vocab as defined by Cert EU.

[Intended effect](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/intended-effect.json) - The IntendedEffectVocab is the default STIX vocabulary for expressing the intended effect of a threat actor

[Motivation](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/motivation.json) - The MotivationVocab is the default STIX vocabulary for expressing the motivation of a threat actor.

[Planning and operational support](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/planning-and-operational-support.json) - The PlanningAndOperationalSupportVocab is the default STIX vocabulary for expressing the planning and operational support functions available to a threat actor.

[Sophistication](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/sophistication.json) - The ThreatActorSophisticationVocab enumeration is used to define the default STIX vocabulary for expressing the subjective level of sophistication of a threat actor.

[Type](https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/type.json) - The ThreatActorTypeVocab enumeration is used to define the default STIX vocabulary for expressing the subjective type of a threat actor.
