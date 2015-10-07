<!-- toc -->

## General Layout

### The top bar

![This is the main menu that will be accessible from all of the views. In some instances, some additional buttons that will appear on top of these when a view provides it.](figures/menu_image.png)

This menu contains all of the main functions of the site as a series of dropdown menues. These contains all (from the current user's perspective) accessible functions sorted into several groups.

*   **Home button:** This button will return you to the start screen of the application, which is the event index page (more about this later).
*   **Event Actions:** All the malware data entered into MISP is made up of an event object that is described by its connected attributes. The Event actions menu gives access to all the functionality that has to do with the creation, modification, deletion, publishing, searching and listing of events and attributes.
*   **Input Filters:** Input filters alter what and how data can be entered into this instance. Apart from the basic validation of attribute entry by type, it is possible for the site administrators to define regular expression replacements and blacklists for certain values in addition to blocking certain values from being exportable. Users can view these replacement and blacklist rules here whilst administrator can alter them.
*   **Global Actions:** This menu gives you access to information about MISP and this instance. You can view and edit your own profile, view the manual, read the news or the terms of use again, see a list of the active organisations on this instance and a histogram of their contributions by attribute type.
*   **Sync Actions:** With administrator access rights, shows a list of the connected instances and allows the initiation of a push and a pull (more about the synchronisation mechanisms later).
*   **Administration:** Administrators can add, edit or remove user accounts and user roles. Roles define the access rights to certain features such as publishing of events, usage of the REST interface or synchronisation of any user belonging to the given role. Site administrators can also access a contact form, through which it is possible to reset the passwords of users, or to just get in touch with them via encrypted e-mails.
*   **Audit:** If you have audit permissions, you can view the logs for your organisation (or for site admins for the entire system) here or even search the logs if you are interested in something specific.
*   **Discussions:** Link to the discussion threads.
*   **Proposal Notifications:** This shows how many proposals your organisation has received and across how many events they are spread out. Clicking this will take you to the list of proposals.
*   **Log out:** Logs you out of the system.

### A list of the contents of each of the above drop-down menues

##### Event actions

*   **List Events:** Lists all the events in the system that are not private or belong to your organisation. You can add, modify, delete, publish or view individual events from this view.
*   **Add Event:** Allows you to fill out an event creation form and create the event object, which you can start populating with attributes.
*   **List Attributes:** Lists all the attributes in the system that are not private or belong to your organisation. You can modify, delete or view each individual attribute from this view.
*   **Search Attributes:** You can set search terms for a filtered attribute index view here.
*   **View Proposals:** Shows a list of all proposals that you are eligible to see.
*   **Events with proposals:** Shows all of the events created by your organsiation that has pending proposals.
*   **List Tags:**List all the tags that have been created by users with tag creation rights on this instance.
*   **Add Tag:**Create a new tag.
*   **List Templates:**List all of the templates created by users with template creation rights on this instance.
*   **Add Template:**Create a new template.
*   **Export:** Export the data accessible to you in various formats.
*   **Automation:** If you have authentication key access, you can view how to use your key to use the REST interface for automation here.

##### Input filters

*   **Import Regexp:** You can view the Regular Expression rules, which modify the data that can be entered into the system. This can and should be used to help filter out personal information from automatic imports (such as removing the username from windows file paths), having unified representation for certain common values for easier correlation or simply standardising certain input. It is also possible to block certain values from being inserted. As a site administrator or a user with regex permission, you can also edit these rules.
*   **Signature Whitelist:** You can view the whitelist rules, which contain the values that are blocked from being used for exports and automation on this instance. Site administrators have access to editing this list.

##### Global Actions

*   **News:** Read about the latest news regarding the MISP system
*   **My Profile:** Manage your user account.
*   **Members List:** View the number of users per organisation and get some statistics about the currently stored attributes.
*   **Role Permissions:** You can view the role permissions here.
*   **User Guide:** A link to this user guide.
*   **Terms & Conditions:** View the terms & conditions again.
*   **Statistics:** View a series of statistics about the users and the data on this instance.
*   **Log out:** Logs the current user out.

##### Sync Actions

*   **List Servers:** Connect your MISP instance to other instances, or view and modify the currently established connections.

##### Administration

*   **New User:** Create an account for a new user for your organisation. Site administrators can create users for any organisation.
*   **List Users:** View, modify or delete the currently registered users.
*   **New Role:** Create a new role group for the users of this instance, controlling their privileges to create, modify, delete and to publish events and to access certain features such as the logs or automation.
*   **List Roles:** List, modify or delete currently existing roles.
*   **Contact Users:** You can use this view to send messages to your current or future users or send them a new temporary password.
*   **Administrative Tools:** Various tools, upgrade scripts that can help a site-admin run the instance
*   **Server Settings:** Set up and diagnose your MISP installation
*   **Jobs:** View the background jobs and their progress
*   **Scheduled Tasks:** Schedule the pre-defined tasks for your instance (this currently includes export caching, server pull and server push).

##### Audit

*   **List Logs:** View the logs of the instance.
*   **Search Logs:** Search the logs by various attributes.

##### Discussions

*   **List Discussions:** List all of the discussion threads.
*   **Start Discussion:** Create a new discussion thread.

### The left bar

This bar changes based on each page-group. The blue selection shows you what page you are on.

