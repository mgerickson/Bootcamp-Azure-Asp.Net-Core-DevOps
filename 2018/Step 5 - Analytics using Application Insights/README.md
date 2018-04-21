# Goal

Get metrics from the application and see how we can analyze them

## References

https://azure.microsoft.com/en-us/services/application-insights/

https://docs.microsoft.com/en-us/azure/application-insights/app-insights-analytics

# Let's code!

## Add App Insights to the web application

Right click on the web project and select "Add | Application Insights Telemetry..."

![img2][img2]

Click on the Start Free button

![img1][img1]

Notice that an ApplicationInsights folder has been added to the project.

![img3][img3]

Open the appsettings.json file. You should see a new section as shown below:

  ```json

  "ApplicationInsights": {
    "InstrumentationKey": "509d0f55-xxxx-4d24-xxxx-3d0847696552"
  }

  ```
 
 Take note of the InstrumentationKey. This will be used in the next step.

## Add code to track javascript calls

Open the file `/Views/Shared/_Layout.cshtml`. Copy the following javascript code and paste it immediatly before the `</html>` tag. Then copy and paste the instrumentation key.

```javascript

<script type="text/javascript">
var appInsights=window.appInsights||function(config)
{
	function i(config){t[config]=function(){var i=arguments;t.queue.push(function(){t[config].apply(t,i)})}}var t={config:config},u=document,e=window,o="script",s="AuthenticatedUserContext",h="start",c="stop",l="Track",a=l+"Event",v=l+"Page",y=u.createElement(o),r,f;y.src=config.url||"https://az416426.vo.msecnd.net/scripts/a/ai.0.js";u.getElementsByTagName(o)[0].parentNode.appendChild(y);try{t.cookie=u.cookie}catch(p){}for(t.queue=[],t.version="1.0",r=["Event","Exception","Metric","PageView","Trace","Dependency"];r.length;)i("track"+r.pop());return i("set"+s),i("clear"+s),i(h+a),i(c+a),i(h+v),i(c+v),i("flush"),config.disableExceptionTracking||(r="onerror",i("_"+r),f=e[r],e[r]=function(config,i,u,e,o){var s=f&&f(config,i,u,e,o);return s!==!0&&t["_"+r](config,i,u,e,o),s}),t    }(

{        instrumentationKey:"YOUR INSTRUMENTATION KEY HERE"    });

 window.appInsights=appInsights;    appInsights.trackPageView();</script>

```

This code is also available in the portal (App Insight -> Getting Started -> Monitor and diagnose client side application)

![img4][img4]

Now you can view the application in your favorite web browser. Open the developper console (F12) and you will notice calls to App Insights in the network tab. You should see requests to `https://dc.services.visualstudio.com/v2/track` which is the App Insights end point to collect data.

At this point, you should be able to see some data in Application Insights if you login in the Portal and look at the overview section.

## Tracking Unhandled Exceptions (request failures)

Next you will see how to track exceptions and how to log them yourself (custom exception logging).

Add a new folder named `Services` to the project.
Next add a new .cs file to the folder and name it `SomeService.cs`
Copy and paste the following code into the file you just created. This code contains the definition of a custom exception `ServiceException` and the `SomeService` class:

```cs

    public class ServiceException : Exception
    {
        public ServiceException() : base("Service Exception") { }
        public ServiceException(Exception inner) : base("Service Exception", inner) { }
    }

    public class SomeService
    {
        public static void ThrowAnExceptionPlease()
        {
            throw new ServiceException();
        }
    }

```

Next add an empty controller named `ServiceController.cs` to the web application.
In the `Index` method of the controller, add the following line of code:

```cs

        Services.SomeService.ThrowAnExceptionPlease();

```

Create the related view file  `views\service\index.cshtml` and add the following code to it.

```cshtml

@{
    ViewBag.Title = "ViewService";
}

<h2>Hello!!!!</h2>

```

Then open the layout file `views\Shared\_Layout.cshtml`, and add the following code after line 37:

```cshtml

<li>@Html.ActionLink("Service", "Index", "Service")</li>

```

Run the applicaiton and click on the 'Service' link on the top. You should see an exception stack.

## Tracking Handled Exceptions

Navigate to the Index method of the `ServiceController`. Replace the code of the method with the following:

```cs

            try
            {
                Services.SomeService.ThrowAnExceptionPlease();
            }
            catch(Exception ex)
            {
                var client = new TelemetryClient();
                client.TrackException(ex);
            }
            return View();

```

Add the using line to make it build:

```cs

using Microsoft.ApplicationInsights;

```

Run the application again. Click on the `Service` menu item. You should not see the exception stack at this point.

In the Azure Portal, click on Metric Explorer and then add metrics to add the exceptions. You should be able to see the details of the exceptions.

![ExceptionMetric][ExceptionMetric]

## Explore Application Map to track dependencies

Application Insights will track dependencies calls by default, though you can explicitly track dependencies using the SDK.

First add the following line at the top of the SomeService.cs file:

```cs

    using Microsoft.ApplicationInsights;

```

Add the following method to the SomeService class:

```cs

        public static void SomeWorkWithDependency()
        {
            var success = false;
            var telemetry = new TelemetryClient();            
            var startTime = DateTime.UtcNow;
            var timer = System.Diagnostics.Stopwatch.StartNew();
            try
            {
                var dependency = new DependencyService();
                success = dependency.DoSomeWork();
            }
            finally
            {
                timer.Stop();
                telemetry.TrackDependency("DependencyService", "DoSomeWork", startTime, timer.Elapsed, success);
            }
        }

```

In the same file, add the following class:

```cs

    public class DependencyService
    {
        public bool DoSomeWork()
        {
            System.Threading.Thread.Sleep(5000);
            return true;
        }
    }

```

Now, change the code in the ServiceController file, Index method by replacing the call to `Services.SomeService.ThrowAnExceptionPlease();` by `Services.SomeService.SomeWorkWithDependency();`

Build and run the application. Click on the Service menu item. You can also change the delay in the `DoSomeWork` method (make it very low for instance). Rebuild and run the application again. Click on the Service menu item.

Go into the Portal and click on the App Insights instance then Application Map. You should be able to see the calls the newly created method.


## Track Event and Metrics

You can track many things other than exceptions. Next you will add some metrics when we create a new runners entry.

First, open the SomeService class and add the following method:

```cs

    public static void TrackCustomStuff(int fivekmTime) {
        var telemetry = new TelemetryClient();
        var properties = new Dictionary<string, string> { { "Run", "RunName" }, { "Jog", "Race" } };
        var measurements = new Dictionary<string, double> { { "RunTime", fivekmTime }, { "Opponents", 1 } };
        telemetry.TrackEvent("RunCompleted", properties, measurements);
        telemetry.TrackMetric("RunTime", fivekmTime, properties);
    }

```

This method will help us track a custom Event and Metric. Add a call to the method in the RunnerPerformancesController in the Create Action. After adding the call the code should look like:

```cs

    public async Task<IActionResult> Create([Bind("Id,FirstName,LastName,FivekmTime")] RunnerPerformance runnerPerformance)
        {
            if (ModelState.IsValid)
            {
                Services.SomeService.TrackCustomStuff(runnerPerformance.FivekmTime);
                _context.Add(runnerPerformance);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(runnerPerformance);
        }

```

Now test it the change. Deploy your application and create a few new results. Once you are done go back into the Azure portal. In the Application Insight blade, open a Metrics Explorer blade, add a new chart, and select Events

![ExceptionMetric][ExceptionMetric]

After a few minutes (around two), you should see your new metric populated.

> *Note*
> Your custom metric might take several minutes to appear in the list of available metrics.

![Results][Results]


[img1]: Media/img1.png
[img2]: Media/img2.png
[img3]: Media/img3.png
[img4]: Media/img4.png
[ExceptionMetric]: Media/ExceptionMetric.png "Add an exception Metric"
[Results]: Media/Results.png "Results"