
[assembly: WebActivator.PreApplicationStartMethod(typeof(Moca.Di.MocaContainerFactory), "Init")]
[assembly: WebActivator.ApplicationShutdownMethod(typeof(Moca.Di.MocaContainerFactory), "Destroy")]

[assembly: WebActivator.ApplicationShutdownMethod(typeof(Moca.Configuration.SectionProtector), "Protect")] 
