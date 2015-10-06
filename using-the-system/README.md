## Using the system

### Creating an event:

The process of entering an event can be split into 3 phases, the creation of the event itself, populating it with attributes
and attachments and finally publishing it.

During this first step, you will be create a basic event without any actual attributes, but storing general information such as a description, time and risk level of the incident. To start creating the event, click on the New Event button on the left and fill out the form you are presented with. The following fields need to be filled out:

![Fill this form out to create a skeleton event, before proceeding to populate it with attributes and attachments.](figures/add_event.png)

*   **Date:** The date when the incident has happened. Just click this field and a date-picker will pop up where you can select the desired date.
*   **Distribution:** This setting controls, who will be able to see this event once it becomes published and eventually when it becomes pulled. Apart from being able to set which users on this server are allowed to see the event, this also controls whether the event will be synchronised to other servers or not. The distribution is inherited by attributes: the most restrictive setting wins. The following options are available:
  *   **Your organization only:** This setting will only allow members of your organisation to see this. It can be pulled to another instance by one of your organisation members where only your organisation will be able to see it. Events with this setting will not be synchronised. 
      Upon push: do not push. Upon pull : pull.
  *   **This Community-only:** Users that are part of your MISP community will be able to see the event. This includes your own organisation, organisations on this MISP server and organisations running MISP servers that synchronise with this server. Any other organisations connected to such linked servers will be restricted from seeing the event.
      Upon push: do not push. Upon pull: pull and downgrade to Your organization only.
  *   **Connected communities:** Users that are part of your MISP community will be able to see the event. This includes all organisations on this MISP server, all organisations on MISP servers synchronising with this server and the hosting organisations of servers that connect to those afore mentioned servers (so basically any server that is 2 hops away from this one). Any other organisations connected to linked servers that are 2 hops away from this own will be restricted from seeing the event. For more information on community-related distribution levels, click here.
      Upon push: downgrade to This Community only and push. Upon pull: pull and downgrade to This Community only.
  *   **All communities:** This will share the event with all MISP communities, allowing the event to be freely propagated from one server to the next.
      Upon push: push. Upon pull: pull.
*   **Threat Level:** This field indicates the risk level of the event. Incidents can be categorised into three different threat categories (low, medium, high). This field can alternatively be left as undefined. The 3 options are:
  *  **Low:** General mass malware.
  *  **Medium:** Advanced Persistent Threats (APT)
  *  **High:** Sophisticated APTs and 0day attacks.
*   **Analysis:** Indicates the current stage of the analysis for the event, with the following possible options:
  *  **Initial:** The analysis is just beginning
  *  **Ongoing:** The analysis is in progress
  *  **Completed:** The analysis is complete
*   **Event Description:** The info field, where the malware/incident can get a brief description starting with the internal reference. This field should be as brief and concise as possible, the more detailed description happens through attributes in the next stage of the event's creation. Keep in mind that the system will automatically replace detected text strings that match a regular expression entry set up by your server's administrator(s).
*   **GFI Sandbox:** It is possible to upload the exported .zip file from GFI sandbox with the help of this tool. These will be dissected by the MISP and a list of attributes and attachments will automatically be generated from the .zip file. Whilst this does most of the work needed to be done in the second step of the event's creation, it is important to manually look over all the data that is being entered.

### Add attributes to the event:

The second step of creating an event is to populate it with attributes and attachments. This can be done by adding them manually or importing the attributes from an external format (OpenIOC, ThreatConnect). To import from an external format or to upload an attachment use the options in the menu on the left.

![Use these tools to populate the event.](figures/attribute_tools.png)

Using the above shown buttons, you can populate an event using various tools that will be explained in the following section. Let's start with the Add Attribute button.

### Add Attribute

Keep in mind that the system searches for regular expressions in the value field of all attributes when entered, replacing detected strings within it as set up by the server's administrator (for example to enforce standardised capitalisation in paths for event correlation or to bring exact paths to a standardised format). The following fields need to be filled out:
![This form allows you to add attributes.](figures/add_attribute.png)

*   **Category:** This drop-down menu explains the category of the attribute, meaning what aspect of the malware this attribute is describing. This could mean the persistence mechanisms of the malware or network activity, etc. For a list of valid categories, [click here](#categories-and-types)
*   **Type:** Whilst categories determine what aspect of an event they are describing, the Type explains by what means that aspect is being described. As an example, the source IP address of an attack, a source e-mail address or a file sent through an attachment can all describe the payload delivery of a malware. These would be the types of attributes with the category of payload deliver. For an explanation of what each of the types looks like together with the valid combinations of categories and types, [click here](#categories-and-types)
*   **Distribution:** This drop-down list allows you to control who will be able to see this attribute. The distribution is inherited by attributes: the most restrictive setting wins. For more info, read the distribution information in the creating an event section - [click here](#creating-an-event)
*   **Contextual Comment:** Add a comment to the attribute. This will not be used for correlation.
*   **Value:** The actual value of the attribute, enter data about the value based on what is valid for the chosen attribute type. For example, for an attribute of type ip-src (source IP address), 11.11.11.11 would be a valid value. For more information on types and values, [click here](#categories-and-types)
*   **Contextual Comment:** You can add some comments to the attribute that will not be used for correlation but instead serves as purely an informational field.
*   **For Intrusion Detection System:** This option allows the attribute to be used as an IDS signature when exporting the NIDS data, unless it is being overruled by the white-list. For more information about the whitelist, head over to the [administration](#administration) section.
*   **Batch import:** If there are several attributes of the same type to enter (such as a list of IP addresses, it is possible to enter them all into the same value-field, separated by a line break between each line. This will allow the system to create separate lines for the each attribute.

### Populate from Template

Templates allow users to rapidly populate events of a specific type by filling out a series of pre-defined fields. Users with template creation privileges can create new templates for their organisations or for all organisations on their instance. If you are interested in template creation, please refer to the templating section.
For users trying to populate an event, after clicking on the populate from template button, you'll be presented with a list of all currently accessible templates. Pick the one that best describes the event that you are creating. </p>
![Choose the most appropriate template for your event.](figures/template_choice.png)
Once you have chosen a template, you'll be presented with the actual form contained within. Make sure you fill out as many fields as possible with the mandatory fields - marked by a star in a bracket such as this: (*) - are filled out.
Templates are devided into sections, with each section having a title and a description in addition to a series of fields. Each field can be an attribute or a file attachment field. An attribute field has the following components:
![MISP will generate attributes based on the field's settings and the data that you provide.](figures/template_field.png)

*  **Field**: The name of the field along with an indication if the field is mandatory.
*  **Description**: A short description of the field.
*  **Types**: The value(s) that are valid for the field. In the case of several types being shown here, you can enter value(s) matching any one of the types, or in the case of a batch import field, any mixture of the given types.
*  **Text field**: This field can either be a single line textfield or a multi-line text area. For the former, enter a single value of the above indicated type, whilst for the latter you cna paste a list of values separated by line-breaks.

### Freetext Import Tool

![Just paste a line-break separated list of indicators into the freetext import tool.](figures/freetext1.png)

If you have a list of indicators that you would like to quickly generate attributes out of then the Free-text import tool is just what you need. Simply paste a list of indicators (separated by line-breaks into this tool).

![MISP will often find several valid category/type combinations for the values. Do last minute adjustments on the result page.](figures/freetext2.png)

Since there are several category / type combinations that can be valid for a lot of values, MISP will suggest the most common settings. You can alter the category / type / IDS fields manually if you disagree with the results. The options will be restricted to valid category/type combinations for the value that you have entered.

### Attribute Replace Tool

If you would like to create and maintain an event with a set of indicators that receives removals and additions over time, then the attribute replace tool might make this task easier for you.

![Select a category/type combination and paste the updated list of indicators into the textarea.](figures/attribute_replace_tool.png)

Simply select the desired category / type combination, choose whether the attributes should be marked for IDS exports and paste the new list of indicators into the textarea. Attributes of the same category/type that are present in the event but not the new list will be removed, values in the pasted list that do not yet exist as attributes will be created as attributes and values that already have matching attributes will be left untouched.

### Add attachments to the event:

You can also upload attachments, such as the malware itself, report files from external analysis or simply artifacts dropped by the malware. Clicking on the add attachment button brings up a form that allows you to quickly attach a file to the event. The following fields need to be filled out:

![Point the uploader to the file you want to upload. Make sure to mark it as malware if the uploaded file is harmful, that way it will be neutralised.](figures/add_attachment.png)

*   **Category:** The category is the same as with the attributes, it answers the question of what the uploaded file is meant to describe.
*   **Distribution:** This drop-down list allows you to control who will be able to see this attachment. The distribution is inherited by attributes: the most restrictive setting wins. For more info, refer to the distribution information in the [event section](#creating-an-event).
*   **Upload field:** By hitting browse, you can browse your file system and point the uploader to the file that you want to attach to the attribute. This will then be uploaded when the upload button is pushed.
*   **Malware:** This check-box marks the file as malware and as such it will be zipped and passworded, to protect the users of the system from accidentally downloading and executing the file. Make sure to tick this if you suspect that the filed is infected, before uploading it.
*   **Contextual Comment:** You can add some comments to the attribute that will not be used for correlation but instead serves as purely an informational field.

### Propose a change to an event that belongs to another organisation

If you would like to propose a modification to an attribute, or to propose some additional attributes to the creating organisation, you can do this with the buttons that replace the add attribute field on the left and the edit icon on the right end of each listed attribute in the event view. The creating organisation of the event will be able to see any proposals and discard or accept the changes.

![An attribute with a proposal attached will turn blue and the proposal itself will be grey. If there is a grey proposal without a blue attribute infront of it, it means that someone has proposed a new attribute](figures/proposal.png)

If the organisation that has created the event is on another connected server, they will be able to accept the proposal once they initiate a pull and receive your proposal. After this they can republish the event, sending the altered attribute back to your instance. 

### Populate from OpenIOC

It is also possible to attempt to import the data contained in a .ioc file, The import tool will attempt to gather as many IndicatorItems within nested logical operators as possible without breaking their validity. After the procedure is done, you'll be presented with a list of successfully created attributes and a list of failed IndicatorItems as well as a graph of the .ioc file.

![The import tool will list the successful and failed entries after the process is done.](figures/ioc1.png)

![You'll also be able to see a graph of the imported .ioc file and how successful the import was.](figures/ioc2.png)

### Populate from ThreatConnect

You can also import the data from a ThreatConnect export csv file. The following columns are used by the import tool (and are thus mandatory fields to select during the export): 
*   Type
*   Value
*   Confidence
*   Description
*   Source

The result will be a list of attributes that get added to the currently selected event, each of which will be marked with a comment that indicates that its origin being from a ThreatConnect import.

### Publish an event:

![Only use publish (no email) for minor changes such as the correction of typos.](figures/publish.png)

Once all the attributes and attachments that you want to include with the event are uploaded / set, it is time to finalise its creation by publishing the event (click on publish event in the event view). This will alert the eligible users of it (based on the private-controls of the event and its attributes/attachments and whether they have auto-alert turned on), push the event to instances that your instance connects to and propagate it further based on the distribution rules. It also readies the network related attributes for NIDS signature creation (through the NIDS signature export feature, for more information, go to the export section.).
There is an alternate way of publishing an event without alerting any other users, by using the "publish (no email)" button. This should only be used for minor edits (such as correcting a typo). 

If your instance has background jobs enabled then the event might not get published immediately. 

## Browsing past events:

The MISP interface allows the user to have an overview over or to search for events and attributes of events that are already stored in the system in various ways.
### To list all events:

On the left menu bar, the option "List events" will generate a list of the last 60 events. While the attributes themselves aren't shown in this view, the following pieces of information can be seen:

![This is the list of events in the system. Use the buttons to the right to alter or view any of the events.](figures/list_events2.png)
*   **Published:** Already published events are marked by a checkmark. Unpublished events are marked by a cross.
*   **Org:** The organisation that created the event.
*   **Owner Org:** The organisation that owns the event on this instance. This field is only visible to administrators.
*   **ID:** The event's ID number, assigned by the system when the event was first entered (or in the case of an event that was synchronized, when it was first copied over - more on synchronisation in chapter xy)
*   **Tags:** Tags that are assigned to this event.
*   **#Attr.:** The number of attributes that the event has.
*   **Email:** The e-mail address of the event's reporter. This is not visible to regular users. Organisation administrators can see the e-mail addresses of their own organisation's users.
*   **Date:** The date of the attack.
*   **Threat Level:** The risk level of the attack, the following levels are possible:
  *    **Low:** General Malware
  *    **Medium:** Advanced Persistent Threats (APTs)
  *    **High:** Sophisticated APTs and 0day exploits
  *    **Undefined:** This field can be left undefined and edited at a later date.
*   **Analysis:** Indicates the current stage of the analysis for the event, with the following possible options:
  *   **Initial:** The analysis is just beginning
  *   **Ongoing:** The analysis is in progress
  *   **Completed:** The analysis is complete
*   **Info:** A short description of the event, starting with an internal reference number.
*   **Distribution:** This field indicates what the sharing privileges of the event. For details, refer to the distribution information in the [event section](#creating-an-event).
*   **Actions:** The controls that the user has to view or modify the event. The possible actions that are available (depending on user privileges - [click here](#roles) to find out more about privileges):
  *   **Publish:** Publishing an event will have several effects: The system will e-mail all eligible users that have auto-alert turned on (and having the needed privileges for the event, depending on its private classification) with a description of your newly published event, it will be flagged as published and it will be pushed to all eligible servers (to read more about synchronisation between servers, have a look at the [section on connecting servers](#connecting-to-other-instances)
  *   **Edit:** Clicking on the edit button will bring up the same same screen as the one used for creating new events, with the exception that all fields come filled out with the data of the event that is being edited. The distribution of an event can only be edited if you are a user of the creating organisation of the event. For more information on this view, refer to the section on [creating an event](#creating-an-event).
  *   **Delete:** The system will prompt you before erasing the unwanted event.
  *   **View:** Will bring up the event view, which besides the basic information contained in the event list, will also include the following:

### Filters

It is also possible to filter the events shown by clicking on the small magnifying glass icons next to the field names and entering a filter term.

### Event view

![This view includes the basic information about an event, a link to related events, all attributes and attachments with tools to modify or delete them and extra functions for publishing the event or getting in touch with the event's reporter.](figures/event_detail.png)

##General Event Information##

*   **ID:** The ID of the event.
*   **Uuid:** In order to avoid collisions between events and attributes (during for example a sync) a Uuid is assigned that uniquely identifies each of them.
*   **Org** The organisation that has originally created the event. The logo (if it exists on the server, alternatively a string) representing the organisation is also shown int he right upper corner.
*   **Contributors:** Shows a list of the organisations that have contributed to the event via proposals. If you click any of the logos listed here, you'll get redirected to a filtered event history view, including only the changes made by the organisation.
*   **Tags:** A list of tags associated with the event. Clicking a tag will show a list of events with the same tag attached. The little cross next to each tag allows you to remove the tag from the event, whilst the '+' button allows you to assign a tag. For the latter two options to be visible, you have to have tagging permission.
*   **Date:** The date of detection, set by the user that creates the event, not to be confused with the creation date of the event.
*   **Threat Level:** The assigned threat level of the event.
*   **Analysis:** The status of the analysis.
*   **Distribution:** This shows the distribution rules applied to this event, controlling whether only the creating organisation can see (Your organisation only) it or everyone on the instance (This community only). The two remaining settings allow the event to be propagated to organisations on remote connected instances.
*   **Info:** A short description of the event itself. Make sure not to put information in here that could be used for correlation purposes and be better suited as an Attribute. 
*   **Published:** Whether the event has been published or not. Publishing allows the attributes of the event to be used for all eligible exports and it notifies users that have subscribed to the event alerts. Also, a publish initiates a push to all eligible instances. 

**List of Related Events**
The list of relations is shown on the right hand side of the general event information. Events can be related by having one or more attributes that are exact matches. For example, if two events both contain a source IP attribute of 11.11.11.11 then they are related. The list of events that are related the currently shown one, are listed under "Related Events", as links (titled the related event's date and ID number) to the events themselves.

**Data Element Toggles**
You can control some of the data that is shown on this page using three toggles. The elements that can be disabled are the pivot threads, the attributes (and proposals) and the Discussions. You can collapse these elements and then expand them again using the same button.

**Pivot Threads**
While moving from event to event through the relation links (a process that we refer to as pivoting), you create a path that shows which events you have traversed. This path is reset by leaving the event view and navigating elsewhere in the application or by deleting the root pivot element. 
Each event visited is represented by a bubble in the pivot thread graph, connected by lines that show how the user has arrived at the next connected event. It is possible to jump back to an earlier relation and pivot to another event through that, creating branches in the graph.
The currently selected event is coloured blue in the graph. If you would like to delete an element from the graph (including all of elements that branch off of it) just click on the small x within a pivot bubble. For a deletion to be possible the following conditions have to be met:
*   The pivot element to be deleted cannot be on the path that leads to the currently selected event
*   The pivot element residing in the graph's root can always be deleted - this will simply reset the current pivot thread

**Attributes and Proposals**
A list of all attributes and proposals attached to the event. The fields for each of them only differ in the available actions and the fact that for proposals to attributes all fields are blank that would stay unchanged if the proposal was accepted (for example, proposing a change to an attribute to turn the IDS flag on will have all fields apart from the IDS flag blank in the proposal. Here is a list of what each of the fields represents: 
*   **Date**: The date of the last modification to the attribute. Proposals don't have a date of last edit.
*   **Category**: The category of the attribute or proposal. For a list of possible categories visit the section on [categories and types](categories-and-types).
*   **Type**: The type of the attribute or proposal. For a list of possible categories visit the section on [categories and types](categories-and-types).
*   **Value**: The value or value-pair of the attribute. This is the main payload of the attribute, which is described by the category and type columns. For certain types of attributes that are made up of value-pairs the two parts will be split by a pipe (|), such as for filename|md5. The value field(s) are used by the correlation engine to find relations between events. In value-pair attributes both values are correlated individually. 
*   **Comment**: Attributes can have a contextual comment to further describe the attribute. These comments are not used for correlation and are purely informative. 
*   **Related Events**: A list of the event IDs that also contain an attribute with the same value. 
*   **IDS**: Flags an attribute as an indicator of compromise, allowing it to be included in all of the eligible exports. 
*   **Distribution**: Defines the distribution of the attribute individually. An attribute can have a different distribution level than the event. In any case, the lowest distribution level of the two is used. 
*   **Actions**: The user can interact with the events through these buttons, which will be further described in the next portion of the guide as they differ for attributes and proposals. 

Depending on the colour coding of the row, you can have an attribute, a proposal to the event or a proposal to an attribute:
*   **Attributes**: Each uncoloured line represents an Attribute.
*   **Proposals to an Event**: Each gray line at the end of the list represents a Proposal to an event. These are proposals for a new attribute, mostly unrelated to any of the currently existing attributes. If the creator of the event accepts one of these a new attribute will be created.
*   **Proposals to an Attribute**: Each attribute can have several edit proposals. These will be placed right below the attribute that the proposal affects and - as with the event proposals - is coloured grey. The original attribute's row is coloured blue if a proposal exists for it.

Using the modify button will bring up the attribute creation view, with all data filled out with the attribute's currently stored data.

**Event Discussion Thread**

Each event has its own assigned discussion where users (that are eligible to see the event) can participate in an open discussion. The users are anonymised in the messages, all that other users will see is their user ID number and their organisation. To post a message on the Event Discussion, either use the reply button on a previous post or use the quickresponse field at the bottom of the page. 
Each post is made up of the following:
*   **Date:**The date when the post was created.
*   **Post navigation:**This should the post's ID as well as a link to jump to the top of the discussion thread on the page itself.
*   **Organisation logo:**If such an image exists for the organisation that has posted the message, then the logo is shown.
*   **Message:**The body of the post itself. This can also include automatically generated links to other events and threads as well as show quoted test in embedded bubbles. Editing an event will also append a post with a message indicating that it was edited together with the timestamp of the edit.
*   **User:**The e-mail address of the poster if he/she is from the organisation as the current user. Alternatively a generated sting is shown that includes the user ID of the user, so that his/her e-mail address could remain hidden whilst still being identifiable.
*   **Action buttons:**Edit, Delete and Reply. The first two of the three options are only available to the poster of the message or a site admin. Quoting a post will automatically include the original message in [quote] tags. 

Here is a list of the various tools you can use while using this feature:
*   **Pagination:** There are 5 posts visible on each event page, if there have been more messages posted, use the previous and next button to navigate through the thread. This will not reload the rest of the page.
*   **Discussion Tags:** Users can quote something by encapsulating it in [quote][/quote] tags, they can create a link to another event with the [event][/event] tags or to another discussion thread with [thread][/thread].
*   **Quick Post:** Adding a post will take the user to a separate add Post page, something that can be a bit of an inconvenience. To avoid this, there is a quick post button, where users can add messages on the fly without having to reload the page. On top of the quick post field, 3 buttons allow users to generate quote, event and thread tags quickly.


### Event History: 

View the logs of the event that show how the event has changed over time, including the contribution from other organisations in the form of proposals. There are two ways to get to this view, either by clicking on View Event History on the side menu of an event view, or by clicking on a contribing organisation's logo on the event view. The latter will show a restricted form of the logs, showing only Proposals created by the selected organisation. The fields shown in this view are as described as follows:
*   **Org**: The logo (or in the lack thereof a string representation) of the organisation.
*   **Action**: Each entry in the log happens during an action, such as the creation, modification or deletion of data and some special actions (such as accepting a proposal). This field shows which action caused the entry to be created. 
*   **Model**: As described above, a log entry is generated on certain actions. This field shows which type of data was affected that caused the log entry to be created (such as a change to the event, the creation of an attribute, the discarding of a proposal, etc).
*   **Title**: This is a short description of the change itself and it is not nearly as detailed as the information administrators get in the audit logs. However, for attributes and proposals the category / type and value of the created or edited attribute is shown. 
*   **Created**: The date and time of the log entry's creation.

### Listing all attributes:
	Apart from having a list of all the events, it is also possible to get a list of all the stored attributes in the system by clicking on the list attributes button. The produced list of attributes will include the followings fields:

![Use the buttons to the right to view the event that this attribute belongs to or to modify/delete the attribute.](figures/list_attributes2.png)
*   **Event:** This is the ID number of the event that the attribute is tied to. If an event belongs to your organisation, then this field will be coloured red.
*   **Org:** The organisation that has created the event.
*   **Category:** The category of the attribute, showing what the attribute describes (for example the malware's payload). For more information on categories, go to section xy
*   **Type:** The type of the value contained in the attribute (for example a source IP address). For more information on types, go to section xy
*   **Value:** The actual value of the attribute, describing an aspect, defined by the category and type fields of the malware (for example 11.11.11.11).
*   **Comment:** An optional contextual comment attached to the attribute.
*   **IDS:** Shows whether the attribute has been flagged for NIDS signature generation or not.
*   **Actions:** A set of buttons that allow you to view the event that the attribute is tied to, to edit the attribute (using the same view as what is used to set up attributes, but filled out with the attribute's current data) and a delete button.

### Searching for attributes:

Apart from being able to list all events, it is also possible to search for data contained in the value field of an attribute, by clicking on the "Search Attributes" button.

![You can search for attributes by searching for a phrase contained in its value. Narrow your search down by selecting a type and/or a category which the event has to belong to.](figures/search_attribute.png)

This will bring up a form that lets you enter one or several search strings (separate search strings with line breaks) that will be compared to the values of all attributes, along with options to narrow down the search based on category and type. The entered search string has to be an exact match with (the sub-string of) a value. A second text field makes it possible to enter event IDs for events that should be excluded from the search (again, each line represents an event ID to be excluded). The third text field allows the user to restrict the results to attributes from certain organisations or to attributes not created by certain other organisations, using the above described syntax.
The list generated by the search will look exactly the same as listing all attributes, except that only the attributes that matched the search criteria will be listed (to find out more about the list attributes view, [click here](categories-and-types)). The search parameters will be shown above the produced list and the search terms will be highlighted.
The last option is a checkbox that restricts all of the results to attributes that are marked as IDS signatures.

!["You can view the event that an attribute belongs to with the view button, or you can edit/delete the attribute via the buttons on the right."](figures/search_attribute_result.png)

