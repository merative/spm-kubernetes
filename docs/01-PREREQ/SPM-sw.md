# IBM Cúram Social Program Management (SPM) software

## SPM installers

The SPM release that supports deployment to Kubernetes requires running a base level, full SPM 7.0.5.0 platform installer, and two delta installers in the following order:

1. SPM 7.0.5.0 (full SPM platform installer from [Passport Advantage](https://www.ibm.com/software/passportadvantage/index.html))
1. SPM 7.0.8.0 (delta installer from [Fix Central](https://www-945.ibm.com/support/fixcentral/))
1. Early Adapter Cloud Enablement is available from [Fix Central](https://www-945.ibm.com/support/fixcentral/). To access the preview, contact your local IBM Account executive.

## Installing SPM

Before you run an installer JAR file, you must have your SPM `license` folder in the location where you run the installer command.

Run each of the installers (full or delta) using the following steps:

* Substitute `<installername.jar>` with your actual installer file name to run this command:

    ```shell
    java -jar <installername.jar>
    ```

This command starts the SPM (izPack) installer.

* Go through the installation dialogs as follows:

* Click _Next_ on the Welcome screen.
  * The value for _Select the installation path:_ defaults to: `./IBM/Curam/Development`
    Change this value as needed, be aware that the default value appends to the working directory from where you ran the Java command.
    * Click _Next_.
    * Respond to the dialog to create or reuse the installation folder.
  * For _Select the language of the application_, select a language. Note: If left blank _English - United States_ is the default.
    * Click _Next_.
  * For _Please select the license types for which you are licensed:_ select the appropriate type(s)
    * Click _Next_.
  * For _Please select the components for which you are licensed:_ select the appropriate component(s)
    * Click _Next_.
  * Provide values for the following items:
    * Organization Name:
    * Organization Address:
    * Click _Next_.
  * Provide values corresponding to the database to connect to:
    * Select the appropriate _Database Platform_
    * Database Account Logon:
    * Database Account Password:
    * Click _Next_.
  * Provide values corresponding to the database to connect to:
    * Database Server Name:
    * Database Server Port:
    * Database Name:
    * Click _Next_.
  * Installation progresses for some time.
    * Click _Next_.
  * Updating of various files and settings occurs.
    * Click _Next_.
  * Installation is complete.
    * Click _Done_.
