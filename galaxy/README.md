<!-- toc -->

## Galaxies

Galaxies in MISP are a method used to express a large object called cluster that can be attached to MISP events or attributes. A cluster can be composed of one or more elements. Elements are expressed as key-values.

There are default vocabularies available in MISP galaxy but those can be overwritten, replaced or updated as you wish. Vocabularies are from existing standards (like STIX, Veris, MISP and so on) or custom ones.

Existing clusters and vocabularies can be used as-is or as a template. MISP distribution can be applied to each cluster to permit a limited or broader distribution scheme.

The objective is to have a comment set of clusters for organizations starting analysis but that can be expanded to localized information (which is not shared) or additional information (that can be shared).

WIP

[MISP galaxy](https://github.com/MISP/misp-galaxy)

### Managing Galaxies in MISP

WIP

### Using Galaxies in MISP Events - Example

For this example, we will try to add a cluster to an existing event. This cluster will contains informations about threath actor known as Sneaky Panda.

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
Clicking on the addition symbole on the left of Beijing Group extends the module.

### Available Galaxies

#### Clusters

[Exploit-kit](https://github.com/MISP/misp-galaxy/blob/master/clusters/exploit-kit.json) - Exploit-Kit is an enumeration of some exploitation kits used by adversaries. The list includes document, browser and router exploit kits. It's not meant to be totally exhaustive but aim at covering the most seen in the past 5 years.

[Microsoft Activity Group](https://github.com/MISP/misp-galaxy/blob/master/clusters/microsoft-activity-group.json) - Activity groups as described by Microsoft.

[TDS - Traffic Direction System](clusters/tds.json) - TDS is a list of Traffic Direction System used by adversaries.

[Threats Actors](https://github.com/MISP/misp-galaxy/blob/master/clusters/threat-actor.json) - Known or estimated adversary groups targeting organizations and employees. Adversary groups are regularly confused with their initial operation or campaign. Threat actors are characteristics of malicious actors (or adversaries) representing a cyber attack threat including presumed intent and historically observed behaviour.

[Tools](https://github.com/MISP/misp-galaxy/blob/master/clusters/tool.json) - Enumeration of software tools used by adversaries. The list includes malware but also common software regularly used by the adversaries.


#### Vocabularies

##### Common
	[certainty-level]
	(https://github.com/MISP/misp-galaxy/blob/master/vocabularies/common/certainty-level.json) -
Certainty level of an associated element or cluster

##### threat-actor
 	[intended-effect]
	(https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/intended-effect.json) - default STIX vocabulary for expressing the intended effect of a threat actor
	[motivation]
	(https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/motivation.json) - default STIX vocabulary for expressing the motivation of a threat actor.
	[planning-and-operational-support]
	(https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/planning-and-operational-support.json) - default STIX vocabulary for expressing the planning and operational support functions available to a threat actor.
	[sophistication]
	(https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/sophistication.json) - default STIX vocabulary for expressing the subjective level of sophistication of a threat actor.
	[type]
	(https://github.com/MISP/misp-galaxy/blob/master/vocabularies/threat-actor/type.json) - default STIX vocabulary for expressing the subjective type of a threat actor.
