# Goal

In this step of the bootcamp, you will explore Visual Studio Team Services (VSTS) and learn how to deploy directly from it.

## Let's Get Started

First, you need an account. Navigate to https://www.visualstudio.com/team-services/ and click on the `Get started for free >` button.  Use the same credentials as you are using for the Azure.portal.com. After few minutes, you should see your greeting from VSTS.

## Create a Project

Create a new Project called BootCamp by clicking the New Project Button. Give it a short description and leave the other options as their defaults. Then click the Create button.

![CreateProject][CreateProject]

### Get Some Code

As soon as the project is created you have many different options. In this example you will import the code from a Github repository. Click on the Import button and enter this url: `https://github.com/FBoucher/AzureBootcampAspNetCoreSample.git`. After the import is completed you should have something like this.

![TheCodeIsIn][TheCodeIsIn]

### Explore the environment a bit

It's a good idea now to take some time and explore VSTS. 

### Create a deployment

In the next step, you will configure VSTS to automatically start a build and a deployment when changes are pushed to the repository.

From the top menu, select *Build and Release*, then click the blue button *+ New Definition*.

![NewDefenition][NewDefenition]

Several templates are available. Since our application is an Asp.Net Core based application select that one from the list and click *Apply*.

![SelectTemplate][SelectTemplate]

For the bootcamp our Build process will also be deploying our solution in Azure. Add another Task. Click on the "+" sign and select Azure App Service Deploy.

![AddTaskDeploy][AddTaskDeploy]

### Configuration Time

Next you need to configure your deployment. On this **Azure App Service Deploy:** task, select your subscription (you will probably need some authorization) and the App Service Name you deployed earlier. Set the Package folder to `$(build.artifactstagingdirectory)\WebApp.zip`. This value can be found in the **Build solution** task.

> **Note**
> Be sure to select **Hosted VS2017** as the build Agent in the **Phase 1** task.

Then go to the Triggers Tab and enable the Continuous Integration trigger. This will trigger your build definition whenever code changes are pushed to the repository.

![EnableTrigger][EnableTrigger]

When you are done click on *Save & Queue*. A build agent should start building your solution. If everything works correctly you will see the  **Build succeeded**.

## Testing time

Navigate to your newly deployed application. If you are not sure of the URL, go to portal.azure.com. Once in the application navigate to the About page. Now let's fix this.

VSTS contains a very good editor so you can fix this online. As another option you could clone the repository to your PC fix the code from there and push it back to VSTS.

 ![CloneCode][CloneCode]

In this case, you will fix it online. Navigate to the code in the `HomeController.cs` file. Edit the file to fix the error. Once you are done, Commit your work and add a comment.  This should trigger your build. After a few minutes your fix should be live in your website.

## End

[CreateProject]: Media/CreateProject.png "Creating a new Project"
[TheCodeIsIn]: Media/TheCodeIsIn.png "The Code Is In"
[NewDefenition]: Media/NewDefenition.png "New Defenition"
[SelectTemplate]: Media/SelectTemplate.png "Select the template"
[AddTaskDeploy]: Media/AddTaskDeploy.png "Add Task to Deploy"
[EnableTrigger]: Media/EnableTrigger.png "Enable Trigger"
[CloneCode]: Media/CloneCode.png "Clone Code"

