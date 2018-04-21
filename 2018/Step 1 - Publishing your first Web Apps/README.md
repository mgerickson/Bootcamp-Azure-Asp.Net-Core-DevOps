# Goal
In this step we will create a shiny new website in Visual Studio. We'll add a form to capture a message submitted by the user. Finally, we'll deploy the website to the Azure App Service so the entire world can marvel at our amazing website!

# Reference

https://docs.microsoft.com/en-us/aspnet/core/

# Clone the Github respository
The files used today can be found in the following Github repository.

https://github.com/mgerickson/Bootcamp-Azure-Asp.Net-Core-DevOps

Please create a folder on your computer and clone the repository to support your work on the sample application. This will also give you the presentation files to review.

# Let's code!
## Open website
Fire up Visual Studio. Click `File -> Open  -> Project/Solution` and navigate to the supplied <span style="color:teal">*solution in Step 0*</span>.

![img1][img1]

### The Model

In the `/Models` folder, add a new class called `RunnerPerformance.cs`:

```cs
using System;

namespace WebAppAspNetCore.Models
{
    public class RunnerPerformance
    {
        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public int FivekmTime { get; set; }
    }
}
```

Add another new class called 'Statistic.cs'

```cs

using System;

namespace WebAppAspNetCore.Models
{
    public class Statistic
    {
        public int Id { get; set; }

        public int BestTime { get; set; }

        public int AverageTime { get; set; }
    }
}

```

### Enable Scaffolding

Scaffolding is a code generation framework for ASP.NET Web applications. 

Right click on the folder Controllers. Select 'Add -> Controller'. In the dialogbox, click on 'Full Dependencies'.

![img11][img11]

### The Controller

Right click on the folder Controllers. Select 'Add -> Controller'. 

Select 'MVC Controller - Empty'. 

![img11][img12]

In the next window set the name to "RunnerPerformancesController".

Select all the lines of code in this file, and replace with :

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebAppAspNetCore.Models;

namespace WebAppAspNetCore.Controllers
{
    public class RunnerPerformancesController : Controller
    {

       
        public IActionResult Index()
        {
            var runnerPerformances = new List<RunnerPerformance>() {
            new RunnerPerformance(){Id = 1, FirstName = "John", LastName = "Smith", FivekmTime = 15},
            new RunnerPerformance(){Id = 2, FirstName = "Kevin", LastName = "Brady", FivekmTime = 10}
            };

            return View(runnerPerformances);
        }
    }
}
```

### The View

Under the `/Views` folder, create a `RunnerPerformances` folder [Add -> New Scaffolded item... -> MVC View]. Add a new view called `Index`. Use the `List` template, and select the model we just created `RunnerPerformance`. Click `Add` and then open the view for editing.

![img10][img10]

The only edit we need to make is to remove the `ActionLink` for Edit, Details and Delete.

```html
       <td>
                @Html.ActionLink("Edit", "Edit", new { /* id=item.PrimaryKey */ }) |
                @Html.ActionLink("Details", "Details", new { /* id=item.PrimaryKey */ }) |
                @Html.ActionLink("Delete", "Delete", new { /* id=item.PrimaryKey */ })
            </td>
```

### The Layout

Open the file `/Views/Shared/_Layout.cshtml`. Find this line of code:

```html
<li><a asp-area="" asp-controller="Home" asp-action="Index">Home</a></li>
```

Under the line of code enter the following to add a link to the RunnerPerformances section :

```html
<li><a asp-area="" asp-controller="RunnerPerformances" asp-action="Index">RunnerPerformances</a></li>
```

### Build and Run!

Hit F5 to build and execute the website.

## Deploying to Azure

There's no point in building a glorious form like this unless you can show it off. We'll now do a deployment to an Azure App Service.

### Visual Studio Publish

The easiest way to deploy the website is by having Visual Studio publish it for you. During the course of the publish, you'll be asked for your credentials, and you'll have to fill in some additional deployment details.

Start by right-clicking on the web project and clicking `Publish`. If you haven't logged in with your Microsoft account, you'll be asked for your credentials now. Once you are logged in, you should be presented with this screen:

![img4][img4]

Choose your subscription, and click `New` to setup your App Service:

![img5][img5]

The Web App Name field will be pre-populated with a globally unique name. If you have not already created a Resource Group and App Service Plan in the subscription they will need to be added now. Once all the fields have been entered, click `Create` and your App Service will be provisioned.

Once provisioning is complete and your publishing profile is complete the Publish dialog will appear to guide you through the rest of the process:

![img6][img6]

At this point you should be able to click Publish, and wait a few minutes for the deploy to complete. You can monitor the Output window to check the status. When the deployment is complete, your browser should open a new tab and display your new cloud-powered website!

![img7][img7]

## Check out the portal

Point a browser to https://portal.azure.com. Click on the Hamburger menu and select `All resources` from the side menu. The new App Service should show up:

![img8][img8]

Clicking on the App Service will take you to a screen where you can manage and monitor your website.

![img9][img9]

Bonus
=====

Try a remote debugging session from whithin Visual Studio:

https://blogs.msdn.microsoft.com/benjaminperkins/2016/09/22/remote-debug-your-azure-app-service-web-app/

# End

[img1]: Media/img1.png "New Project"
[img4]: Media/img4.png "Create new App Service"
[img5]: Media/img5.png "Add App Service details"
[img6]: Media/img6.png "Publish website"
[img7]: Media/img7.png "Deployed website in browser"
[img8]: Media/img8.png "Azure Resources screen"
[img9]: Media/img9.png "Web app management screen"
[img10]: Media/img10.png "Add a view"
[img11]: Media/img11.png "Scaffolding"
[img12]: Media/img12.png "Add Scaffold"