﻿
<Assembly: WebActivator.PreApplicationStartMethod(GetType(Moca.Di.MocaContainerFactory), "Init")> 
<Assembly: WebActivator.ApplicationShutdownMethod(GetType(Moca.Di.MocaContainerFactory), "Destroy")> 
