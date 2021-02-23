<!-- toc -->

# Sharing / Synchronisation

* MISP's core functionality is sharing where everyone can be a consumer and/or a contributor/producer.
* Quick benefit without the obligation to contribute
* Low barrier access to get acquainted to the system

# Synchronisation
## Concept

The following figure shows the concept how different MISP instances could tie together.

![Scenario example](figures/MISP_scenario_example.png)

In MISP, two ways exist to get events from remote sources:

* **Use case 1**: From another MISP server (also called MISP instance), by synchronising two MISP servers.
* **Use case 2**: From a link, by using [Feeds](../managing-feeds).

The example below illustrate the synchronisation between two MISP servers (use case 1).
An organisation B (OrgB) wants to synchronise its MISP server, called ServerB, with the MISP server of an organisation A (Org A), called ServerA. The following steps can be taken to syncronise ServerB with ServerA:

<p align="center">
  <a name="misp-server-sync"></a><img src="./figures/misp-sync-servers.png" alt="Synchronisation between two MISP servers" style="width: 100%;"/></br>
  <span><i>FIGURE: Illustration of the synchronisation between two MISP servers</i></span>
</p>

* **Step 1**: Add OrgB as a local organisation on ServerA (OrgB.ServerA) using OrgB's existing UUID from their local organisation on ServerB.
* **Step 2**: Add a Sync User (syncuser@OrgB.ServerA) in the organisation OrgB.ServerA on the MISP ServerA.
* **Step 3**: [Set up a sync server](#adding-a-server) on MISP ServerB using the key (called Authkey) from the sync user (syncuser@OrgB.ServerA) created on MISP ServerA.

For additional information on the synchronisation process, refer to the [MISP GitHub issues](https://github.com/MISP/MISP/issues), for example, [issue 2595](https://github.com/MISP/MISP/issues/2595).

## Adding a server

Servers can be added by users via

~~~~
https://<misp url>/servers/add
~~~~

![Add Server](figures/add_server_1.png)

    The Add Server Form has several input fields:

![Add Server](figures/add_server_ui.png)

1. Base URL 

    The base-url to the external server you want to sync with. Example: https://foo.sig.mil.be

2. Instance Name

    A name that will make it clear to your users what this instance is. For example: Organisation A's instance

3. Remote Sync Organisation Type

    MISP has several organisation "pools", one for local and one for known external organisations. When adding a
    synchronisation connection, you need to define the host organisation of the remote instance. Select which pool
    you wish to pick the organisation from using this drop-down. You also have the option of adding a new organisation
    directly from this interface.

4. Local/Known remote Organisation

    Choose the organisation from the selected pool that defines the host organisation on the remote side. Make sure that
    the remote instance is actually run by the organisation you select as this is used in an integral part of the 
    sharing mechanism. Do not select your own organisation for this setting.

5. Authkey

    You can find the authentication key on your profile on the external server.

6. Push

    Allow the upload of events and their attributes. That means only Events that match the given filter will
    be pushed to the server.
    
    E.g. it can limit push of events to events not being TLP:RED
    

7. Pull

    Allow the download of events and their attributes from the server. That means only Events
    matching the given criteria will be pulled.
    
    E.g. it can limit to NOT download Type:OSINT events.

8. Self Signed

    Click this, if you would like to allow a connection despite the other instance using a self-signed certificate (not recommended). (server certificate file still needed)

9. Server certificate file

    You can also upload a certificate file if the instance you are trying to connect to has its own signing authority.  (*.pem)

10. Client certificate file

    You can also upload a certificate file if the instance you are trying to connect to has its own signing authority.  (*.pem)

## Test connection

Test connection can be used to test the connection to the remote server and will give a feedback about local and remote version of MISP.

## Rules

Rules are used to limit sharing when synchronising events and attributes, to e.g. events with a given tag, or disabling sharing for events containing a certain Tag.

## Troubleshooting

If you have issues connecting to a remote servers try to do the following things:

- try to connect with your user account to the remote server, to ensure the password is still valid and that your API key is valid
- try to connect with your user account to the remote server and check your roles on the remote server
- with connection issues do a package capture to find out more
- if you have a SSL connection issue to a remote server with a signed by a CA that is not included in OS, make sure the whole certificate path is included in the path.

## Sharing and distribution

The following section describes how distribution mechanisms of events and attributes work.

### Distribution settings

The below five distribution settings are available for events and attributes. Descriptions of those settings can be found [here](../using-the-system/#creating-an-event).

* Your organisation only
* This community only
* Connected communities
* All communities
* Sharing group

Events that are not published are only distributed/shared to the local organisations on the same MISP server/instance (within the limit of the distribution model).
Only events that are **published** will be shared with remote organisations on other MISP servers via push/pull mechanisms.
More details on publishing events [here](../using-the-system/#publish-an-event).

### Community

A community is composed of the local organisations on a MISP server and the remote organisations connected by the sync users. For more information on the concept of community, refer to an [article on MISP information sharing following ISO/IEC 27010](https://github.com/MISP/misp-compliance/blob/master/ISO_IEC_27010/misp-sharing-information-following-ISO-IEC-27010.md#suitable-data-model), explaining the concept of community.

Specifically, communities are not reversible. Taking the example of <a href="#misp-server-sync">the above figure</a>, illustrating the synchronisation between two MISP servers, OrgB.ServerB is part of the MISP ServerA community but OrgB.ServerA is not part of MISP ServerB community.

### Sharing-groups

There is an article about sharing groups in [here](../using-the-system/#create-and-manage-sharing-groups)

### Distribution mechanisms

The distribution level of an event is automatically decreased as it is synchronised with other MISP instances, when it was originally set to:

* Community only (to organisation only)
* Connected community (to community only)
 
It is not decreased when it was originally set to:

* Organisation only
* All communities
* Sharing group

[!] This rule does not apply if “Internal instance” has been checked when creating the server.

As an example, the figure below illustrates two events **e** and **e'** created by OrgA and respectively shared as "This community only" and "Connected communities" and how they propagate in an illustrative MISP set of intances synchronised with each others.

![Illustration of MISP organisations and community interactions](figures/misp-compliance-iso-concepts.png)

#### General syncing rules
- The owner organisation of the event on instance B is set to the organisation of the sync user.
- The creator user is the authkey user when pushing
- The creator user is the user triggering the pull when pulling. This user can be different than the authkey user.
- Rule of thumb: if the user configured to pull from instance A to B can see the event on instance A, the event will be synced.

#### Syncing scenarios with communities distribution

##### Internal instance flag not set
The below scenarios are if “Internal instance” has not been checked when creating the server. This is the usual scenario.
###### Push from instance A to instance B - usual scenario
Which organisation the remote sync user belongs to has no impact on which events are pushed.

| Instance A  | Instance B                                                                        |
| ----------- | --------------------------------------------------------------------------------- |
| Your organisation only      | Event/object/attribute not pushed                                                 |
| This community only   | Event/object/attribute not pushed                                                 |
| Connected communities      | Event/object/attribute distribution decreased to 'This community only' on B       |
| All communities   | Event/object/attribute distribution stays 'all communities'                       |

###### Pulling from instance A to instance B - usual scenario
Rule of thumb: if the user configured to pull from instance A can see the event on instance A, the event will be synced.

| Instance A  | Instance B                                                                                                                                                                     |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Your organisation only      | Event/object/attribute pulled in only if the sync user is member of the event's owner organisation on A. Event distribution stays 'Your organisation only' on instance B       |
| This community only   | Event/object/attribute distribution decreased to 'Your organisation only' on B                                                                                                 |
| Connected communities      | Event/object/attribute distribution decreased to 'This community only' on B                                                                                                    |
| All communities   | Event/object/attribute distribution stays all communities on B                                                                                                                 |

##### Internal instance flag  set
The below scenarios are if “Internal instance” has been checked when creating the server. This is the *not* the usual scenario and *potentially dangerous*. The internal instance flag can be used when both instances have the same hosting organisation. 

###### Push from instance A to instance B - internal flag set scenario
| Instance A  | Instance B                                                                                                                                                                                                                                          |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Your organisation only      | Event/object/attribute not pushed if triggering push of already locally (on instance A) published event. Event/object/attribute synced on publication of an event, even if the organisation publishing is not the host organisation of the instance |
| This community only   | Event/object/attribute distribution stays 'This community only' on B                                                                                                                                                                                |
| Connected communities      | Event/object/attribute distribution stays 'Connected communities' on B                                                                                                                                                                              |
| All communities   | Event/object/attribute distribution stays 'All communities on B'                                                                                                                                                                                    |

###### Pulling from instance A to instance B - internal flag set scenario
Rule of thumb: if the user configured to pull from instance A can see the event on instance A, the event will be synced.

| Instance A  | Instance B                                                                                                                                                      |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Your organisation only      | Event/object/attribute pulled in only if the sync user is member of the event's owner organisation. Event distribution stays 'Your organisation only' on B      |
| This community only   | Event/object/attribute distribution decreased to 'Your organisation only' on B                                                                                  |
| Connected communities      | Event/object/attribute distribution decreased to 'This community only' on B                                                                                     |
| All communities   | Event/object/attribute distribution stays 'All communities' on B                                                                                                |

## Collaboration

### Proposals

Proposals can be used to propose new attribute values that can be reviewed by the event owner.

### Forums / Threats

Forums can be used to discuss non event related topics.

Discussions can be accessed on the top "Global Actions - List Discussions"

**Discussions will and can not be shared with other servers**

and via URL:

~~~~
https://<misp url>/threads/index
~~~~

![Discussions](figures/discussions.png)

#### Create a new Topic

To create a new topic

~~~~
https://<misp url>/posts/add
~~~~

![Start a topic](figures/discussions_start_topic.png)

#### Comment a topic

A topic can be commented by any user

~~~~
https://<misp url>/threads/view/<topic id>
~~~~

### Comments to events

In MISP ongoing events can be commented by every user to ask free text question to events.
**Comments to events will not be shared with other servers**

![Contact reporter](figures/comment_an_event.png)

### Contact a reporter

This feature can be used to contact the person or the organisation that the person belongs to that has created the event.

All E-Mails can be enforced to be encrypted

![Contact reporter](figures/contact_reporter.png)

### Receive alerts

It is possible to get alerts via encrypted mail in the following cases:

* published events by other user of the MISP instance
* events pushed to the MISP instance
* events pulled by the MISP instance

These E-Mail alerts are an opt-in feature

![Change user settings](figures/profile_receive_alerts.png)


## Recommendation

The following section will describe what is the best practice how many MISP instances that showed to be good for orgs.
Of course depending on your specific requirements an architecture could be more spread or simplified.

The architecture is divided into several systems / stages beginning with:

### MISP Staging System

This systems purpose is to be linked to all available external MISP systems that you have access to.
It will download all events and do enrichment between these events.

### MISP SECOps System

This system is the main system used by human analysts.
It will it is not linked to any external MISP instance other then the Staging System.

To publish events to the community assign the right tags to match your push [Rules](#rules) and **publish the event**
