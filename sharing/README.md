<!-- toc -->

## Sharing / Synchronisation

* [Explanation](#users)
* [Setup](#setup)
* [Roles](#roles)
* [Tools](#tools)
* [Server Settings](#server-settings)
* [Events](#events)
* [Sharing groups](#sharing-groups)
* [Recommendations](#recommendations)

* MISP's core functionality is sharing where everyone can be a consumer and/or a contributor/producer.
* Quick benefit without the obligation to contribute
* Low barrier access to get acquainted to the system

##Concept

The following figure shows the concept how different MISP instances could tie together.

![Scenario example](figures/MISP_scenario_example.png)

##Setup

###Adding a server

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

    The organization having the external server you want to sync with. Example: BE

4. Local Organisation

    This setting will configure which organisation will be assigned to the events being pulled.

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

###Test connection

Test connection can be used to test the connection to the remote server and will give a feedback about local and remote version of MISP.

###Rules

Rules are used to limit sharing to e.g. events with a given tag, or disabling sharing for events containing a certain Tag.

###Troubleshooting

If you have issues connecting to a remote servers try to do the following things:

- try to connect with your user account to the remote server, to ensure the password is still valid and that your API key is valid
- try to connect with your user account to the remote server and check your roles on the remote server
- with connection issues do a package capture to find out more
- if you have a SSL connection issue to a remote server with a signed by a CA that is not included in OS, make sure the whole certificate path is included in the path.

##Collaboration

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

####Create a new Topic

To create a new topic

~~~~
https://<misp url>/posts/add
~~~~

![Start a topic](figures/discussions_start_topic.png)

####Comment a topic

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

# Events

This will describe what to do within events to be shared.

* Only events that are **published** will be shared

# Sharing-groups

There is an article about sharing groups in [here](using-the-system/#create-and-manage-sharing-groups)

#Recommendation

The following section will describe what is the best practice how many MISP instances that showed to be good for orgs.
Of course depending on your specific requirements an architecture could be more spread or simplified.

The architecture is divided into several systems / stages beginning with:

## MISP Staging System

This systems purpose is to be linked to all available external MISP systems that you have access to.
It will download all events and do enrichment between these events.

## MISP SECOps System

This system is the main system used by human analysts.
It will it is not linked to any external MISP instance other then the Staging System.

To publish events to the community assign the right tags to match your push [Rules](#rules) and **publish the event**