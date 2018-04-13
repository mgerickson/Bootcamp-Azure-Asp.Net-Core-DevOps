# Goal

In this step we will continue to build our new website in Visual Studio. We'll add the forms to made CRUD (Create, Read, Update and Delete) operations with Entity Framework Core.

## Reference

https://docs.microsoft.com/en-us/ef/core/index

# Let's code!

## Open the website

Fire up Visual Studio. Click `File -> Open  -> Project/Solution` and navigate to the supplied solution in Step 1.

![img1][img1]

Delete 'RunnerPerformancesController.cs' file in the folder 'Controllers' and delete the folder 'RunnerPerformances' in the folder 'Views'.

### Validation with DataAnnotations

In the `/Models` folder, change code in `RunnerPerformance.cs` with :

```cs

using System;
using System.ComponentModel.DataAnnotations;

namespace WebAppAspNetCore.Models
{
    public class RunnerPerformance
    {
        public int Id { get; set; }

        [Required]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name= "Time performed by the runner")]
        [Range(0, int.MaxValue, ErrorMessage = "Please enter a value bigger than {0}")]
        public int FivekmTime { get; set; }

    }
}

```

 [Required], [Display] and [Range] attributes are DataAnnotations used to specify validation for individual fields in the data model.  

### The DBContext

The Database Context (DBContext) is an important part of Entity Framework Core. It is a bridge between your domain or entity classes and the database.  In the `/Models` folder, add a new class called `BootCampContext.cs`:

```cs

using System;
using Microsoft.EntityFrameworkCore;


namespace WebAppAspNetCore.Models
{
    public class BootCampContext : DbContext
    {

        
            public BootCampContext(DbContextOptions<BootCampContext> options)
                    : base(options)
            {
            }

            public DbSet<RunnerPerformance> RunnerPerformances { get; set; }

           public DbSet<Statistic> Statistics { get; set; }

    }
}

```

### The ConnectionString

The ConnectionString is the string with information to connect to the database. This includes information like database name, username, password and provider.

We will first use a LocalDB database. Edit the appsettings.json file adding a ConnectionString, below the 'Logging' section. Here is the complete code of appsettings.json file with the connectionString.

```json

{
  "Logging": {
    "IncludeScopes": false,
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "ConnectionStrings": {
    "LocalDBConnectionStrings": "Server=(localdb)\\mssqllocaldb;Database=BootCampDB;Trusted_Connection=True;MultipleActiveResultSets=true"
  }
}

```

### Register the DBContext with dependency injection

EF Core supports using DbContext with a dependency injection container. Your DbContext type can be added to the ASP.NET Core service container by using AddDbContext<TContext>.

Edit the Startup.cs file updating the 'ConfigureServices' method. Add this line of code after services.AddMvc().

```cs
services.AddDbContext<BootCampContext>(options =>
           options.UseSqlServer(Configuration.GetConnectionString("LocalDBConnectionStrings")));
```

Here is the complete code of the 'ConfigureServices' method. 

```cs

  public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();

            services.AddDbContext<BootCampContext>(options =>
           options.UseSqlServer(Configuration.GetConnectionString("LocalDBConnectionStrings")));
        }

```

You also need to add these references. Copy and paste it at the top of Startup.cs file.

```cs

using WebAppAspNetCore.Models;
using Microsoft.EntityFrameworkCore;

```

### Use Migrations to create and update database

We are ready to access the database with our application using Entity Framework Core. But, we haven't yet created our database with the corresponding tables. We don't need to do it manually. We can use Entity Framework Core to generate and update our database.

To do this, we will use the 'Package Manager Console'. Click `Tools -> Nuget Package Manager  -> Package Manager Console` 

![img2][img2]

Enter the following command: `Add-Migration InitialMigration`. The folder Migrations will be created in the root folder of your application.

![img3][img3]

Enter the following command to update the database:

`Update-Database`

### CRUD With Entity Framework Core

Right click on the folder Controllers. Select 'Add -> Controller'.

Select 'MVC Controller with views, using Entity Framework'

![img5][img5]

In the 'Add Controller' window, fill in the following information.

Model Class : RunnerPerformance

Data context class : BootCampContext

![img6][img6]

### Build and Run!

Hit F5 and run the application.

### Explore code generated for CRUD operation

Explore the code generated in the file 'Controllers/RunnerPerformancesController.cs';

Explore the views generated in the folder 'Views/RunnerPerformances'

## End

[img1]: Media/img1.png "New Project"
[img2]: Media/img2.png "Migrations"
[img3]: Media/img3.png "Create InitialMigration"
[img4]: Media/img4.png "Add dependencies for Scaffolding"
[img5]: Media/img5.png "Add Scaffold"
[img6]: Media/img6.png "Add controller"