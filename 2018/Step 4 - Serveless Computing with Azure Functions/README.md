Goal
======

Create an Azure Function that will be executed every 5 minutes to calculate the average of the times saved in the database and saving the result. Validate in the debug window that the text for the message is the same as written in the Website textbox.

Reference
=========

- https://docs.microsoft.com/en-us/azure/azure-functions/

Let's code!
===========

Create an Azure Function Domain
-------------------------------

From portal.azure.com click the big green "+" in the top left corner. Search for "Function", and select **Function App**. Click the create button. This will open a form to specify the information related to your Function App "domainname".

![SearchFunctionApp][SearchFunctionApp]

Set the following values:
- App Name: The name of the domain, where all your functions will be regrouped. This name must be unique.
- Subscription: The subscription with which the Function App will associated.
- Ressource Group: Select the same Ressource Group used for the previous components.
- Hosting plan: Select Consumption Plan.
- Location: Select the same location used for the previous components.
- Create a new Storage Account. Give it a name like [yourname]functions

![CreateFunctionApp][CreateFunctionApp]

Click the create button.

Create The Data processing Azure Function
-----------------------------------------

1. Click the "+" sign to add a new Function App.
1. Select the Scenario Data processing
1. Select C#
1. Click the *Create this function* button.

![CreateDataFunction][CreateDataFunction]

(Because it's our first function, the portal will do a little overview of the interface)

Configure the Function App
--------------------------

1. From the left section, select your Function Apps.
1. Click on the *Platform features* tab on the top of the screen.
1. Click on Application settings under the GENERAL SETTINGS section.
1. Scroll to the section **Connection strings** and click on *+ Add new connection string*.
1. Set the name to something like sqlConn and the value to the connectiontring used in the last exercise.
1. Don't forget to scroll back up to click the save button.

![ShowApplicationSettings][ShowApplicationSettings]

Test the Function App
--------------------------

Now let's calculate some statistics. Copy-Paste the code from the snippet `function_TimeTrigger_final.txt` inside your function.

The `#r` commands are to add references to libraries we need that are already available in Azure. Save your changes.

Clear the Logs windows by clicking the Clear button, and go back save another comment in the WebApp. You should have something similar to this.

![Result][Result]

Bonus
=====

Try to do the same thing from a Visual Studio Function Project.

![NewProject][NewProject]

Then to add a new Function, right mouse click on the project node in Solution Explorer, then choose Add > New Item. Choose Azure Function from the dialog box.

![AddFunction][AddFunction]

Select the type of function you need...

Once all the code is in place hit F5 to run it locally.

![DebugMode][DebugMode]

To complete this bonus, change your deployment setting from `Release` to `Debug`, hit F5, place a breakpoint in your code and you can begin a debugging session! ;)

## End

[SearchFunctionApp]: Media/SearchFunctionApp.png "Search Function App"
[CreateFunctionApp]: Media/CreateFunctionApp.png "Create a Function App"
[CreateDataFunction]: Media/CreateDataFunction.png "Create Data processing Function"
[ShowApplicationSettings]: Media/ShowApplicationSettings.png "Set Queue Storage"
[Result]: Media/Result.png "See Logs"
[connectionstring]: Media/connectionstring.png "Connectionstring available in the portal"
[NewProject]: Media/NewProject.png "Create a new Function Type Project"
[AddFunction]: Media/AddFunction.png "Add a new Function"
[DebugMode]: Media/DebugMode.png "Run the project in Debug"