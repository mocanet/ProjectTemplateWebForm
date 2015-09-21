param($installPath, $toolsPath, $package, $project)

$myProject = $project.ProjectItems.Item("My Project")
$Properties = $project.ProjectItems.Item("Properties")
$readme = $project.ProjectItems.Item("App_Readme")

$item = $readme.ProjectItems | where-object {$_.Name -eq "Elmah.sqldb.readme.txt"}
$item.Properties.Item("BuildAction").Value = [int]0

$readmeScriptsTables = $readme.ProjectItems.Item("Scripts").ProjectItems.Item("Tables")

$item = $readmeScriptsTables.ProjectItems | where-object {$_.Name -eq "ELMAH_Error.sql"}
$item.Properties.Item("BuildAction").Value = [int]0

$readmeScriptsStored = $readme.ProjectItems.Item("Scripts").ProjectItems.Item("Stored Procedures")

$item = $readmeScriptsStored.ProjectItems | where-object {$_.Name -eq "ELMAH_GetErrorsXml.sql"}
$item.Properties.Item("BuildAction").Value = [int]0
$item = $readmeScriptsStored.ProjectItems | where-object {$_.Name -eq "ELMAH_GetErrorXml.sql"}
$item.Properties.Item("BuildAction").Value = [int]0
$item = $readmeScriptsStored.ProjectItems | where-object {$_.Name -eq "ELMAH_LogError.sql"}
$item.Properties.Item("BuildAction").Value = [int]0

Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'
$msbuild = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($project.FullName) | Select-Object -First 1

if ($project.CodeModel.Language -eq "{B5E9BD34-6D3E-4B5D-925E-8A43B79820B4}") 
{
	$myProject.Delete()

	$item = $project.ProjectItems | where-object {$_.Name -eq "ApplicationEvents.vb"}
	$item.Delete()

	$item = $Properties.ProjectItems | where-object {$_.Name -eq "AjaxMin.targets"}
	$item.Properties.Item("BuildAction").Value = [int]0

	$targetsAjaxMinFile = 'Properties\AjaxMin.targets'
}
if ($project.CodeModel.Language -eq "{B5E9BD33-6D3E-4B5D-925E-8A43B79820B4}") 
{
	$Properties.Delete()

	$item = $myProject.ProjectItems | where-object {$_.Name -eq "AjaxMin.targets"}
	$item.Properties.Item("BuildAction").Value = [int]0

	$targetsAjaxMinFile = 'My Project\AjaxMin.targets'
}

$msbuild.Xml.AddImport($targetsAjaxMinFile) | out-null

$project.Save()
