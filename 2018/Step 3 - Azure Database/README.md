# Goal

Explore the database created by the application. Learn how to connect, explore and see some tools.

# Let's code!

## Use Azure Portal to create Azure SQL Database 

In the Azure portal, click on new and search for "sql database".

![img1][img1]

Create an Azure SQL Database. In the form, make sure to select the same Resource Group as you used for your Web Application. The name of database must be 'BootCampDB'

![img2][img2]

Create a new Database Server in the Server section. The server name must be unique.

![img3][img3]

### Set server firewall

Before you connect your application to your new Azure SQL Database, you must first set a Firewall.

Microsoft Azure SQL Database provides a relational database service for Azure and other Internet-based applications. To help protect your data, firewalls prevent all access to your database server until you specify which IP addresses have permission. The firewall grants access to databases based on the originating IP address of each request.

To configure the firewall, click on 'SQL Databases' and select your database from the list. Click on 'Set server firewall'.

![img4][img4]

Click on 'Add client IP' to allow access to Azure services at your client IP address and click on 'Save'. 

![img5][img5]

Close the 'Firewall settings' window.

### ConnectionString

Click on 'show database connection strings'  

![img6][img6]

Copy the connectionstring.

![img7][img7]

Fire up Visual Studio. Click `File -> Open  -> Project/Solution` and navigate to the supplied solution in Step 2.

Edit the appsettings.json file and add a new parameter with the name 'AzureDBConnectionStrings'. Paste the connection string you copied from the Azure Portal as the value :

```json
   "AzureDBConnectionStrings": "Server=tcp:bootcampdb.database.windows.net,1433;Initial Catalog=BootcampDB;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
```

Replace '{your_username}' with username of your Azure SQL Database and '{your_password}' with password of your Database.

The complete code of appsettings.json file should look like :

```json

{
  "Logging": {
    "IncludeScopes": false,
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "ConnectionStrings": {
    "LocalDBConnectionStrings": "Server=(localdb)\\mssqllocaldb;Database=BootCampDB;Trusted_Connection=True;MultipleActiveResultSets=true",
    "AzureDBConnectionStrings": "Server=tcp:bootcampdb.database.windows.net,1433;Initial Catalog=BootcampDB;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}
```

Edit the Startup.cs file. Change the name of the connectionString parameter to get the Azure SQL Database ConnectionString.

```cs
Configuration.GetConnectionString("AzureDBConnectionStrings")
```

### Use Migrations to initialise your Database

You can use Entity Framework Core Migrations to create 'RunnerPerformances' and 'Statistics' tables in your Azure SQL Database.

To do this open the 'Package Manager Console' (Click `Tools -> Nuget Package Manager  -> Package Manager Console`) and execute the following command.

Update-Database

### Test your application locally

Hit F5 to run your application and test your access to Azure SQL Database.

### Deploy your application

Right-click on the web project and click on `Publish`. Select 'Microsoft Azure App Service' and click on 'Select Existing'. After that click on 'Publish'.

![img8][img8]

In the next window select your Subscription and your Azure App Service.

![img9][img9]

Click Ok and wait for a few minutes allowing the deployment to complete. You can watch the Output window to check the status. When the deployment is complete yur browser should open a new tab and display your cloud-powered website!

### Query Editor

Navigate to your Azure SQL Database. In the 'Overview' window, click on 'Tools' in the 'tools box' on the top.

Click on 'Query editor preview'. Click on 'Login' in the 'Query Editor' Window. Enter your Login and Password.

![img10][img10]

Type your SQL command inside the editor and click Run.

 ```sql
 select * from RunnerPerformances
```

![img11][img11]

## End

[img1]: Media/img1.png 
[img2]: Media/img2.png 
[img3]: Media/img3.png 
[img4]: Media/img4.png 
[img5]: Media/img5.png 
[img6]: Media/img6.png 
[img7]: Media/img7.png 
[img8]: Media/img8.png 
[img9]: Media/img9.png 
[img10]: Media/img10.png 
[img11]: Media/img11.png 