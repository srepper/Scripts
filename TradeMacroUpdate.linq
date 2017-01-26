<Query Kind="Program" />

void Main()
{
	var workingDirectory = @"C:\Program Files (x86)\Grinding Gear Games\Path of Exile\AHK Script\POE-TradeMacro";
	var path = @"C:\Program Files (x86)\Grinding Gear Games\Path of Exile\AHK Script";
	var versionedFolder = "POE-TradeMacro-";
	var updateDirectory = Directory.EnumerateDirectories(path)
							.Where(x => x.Contains(versionedFolder))
							.OrderBy(GetVersion)
							.Last();
	var updateFileName = Directory.EnumerateFiles(updateDirectory).Where(x => Path.GetFileName(x) == "POE-ItemInfo.ahk").First();
	var updatedLines = File.ReadAllLines(updateFileName);
	
	using(var updateFile = new StreamWriter(updateFileName))
	{
		var newFileLines = updatedLines.TakeWhile(x => !x.StartsWith("GetClipboardContents("))
			.Concat(updatedLines.SkipWhile(x => !x.StartsWith("SetClipboardContents(")))
			.Concat(new[] { @"#Include %A_ScriptDir%/../MyMacros.txt" })
			.ToList();
		
		("Writing lines to " + updateFileName).Dump();
		foreach (var line in newFileLines)
			updateFile.WriteLine(line);
		("Finished writing " + updateFileName).Dump();
	}
	
	("Copying directory " + updateDirectory + " to new location:\r\n" + workingDirectory).Dump();
	DirectoryCopy(
		updateDirectory,
		workingDirectory,
		true
	);
	"Directory copy finished.".Dump();
	
	"Update complete.".Dump();
}

// Define other methods and classes here
int GetVersion(string input)
{
	return int.Parse(string.Concat(input.Split('-').Last().Split('.').Select(x => PadZeros(x))));
}

string PadZeros(string input)
{
	return input.PadLeft(4, '0');
}

private static void DirectoryCopy(string sourceDirName, string destDirName, bool copySubDirs)
{
   // Get the subdirectories for the specified directory.
   DirectoryInfo dir = new DirectoryInfo(sourceDirName);

   if (!dir.Exists)
   {
       throw new DirectoryNotFoundException(
           "Source directory does not exist or could not be found: "
           + sourceDirName);
   }

   DirectoryInfo[] dirs = dir.GetDirectories();
   // If the destination directory doesn't exist, create it.
   if (!Directory.Exists(destDirName))
   {
       Directory.CreateDirectory(destDirName);
   }

   // Get the files in the directory and copy them to the new location.
   FileInfo[] files = dir.GetFiles();
   foreach (FileInfo file in files)
   {
       string temppath = Path.Combine(destDirName, file.Name);
       file.CopyTo(temppath, true);
   }

   // If copying subdirectories, copy them and their contents to new location.
   if (copySubDirs)
   {
       foreach (DirectoryInfo subdir in dirs)
       {
           string temppath = Path.Combine(destDirName, subdir.Name);
           DirectoryCopy(subdir.FullName, temppath, copySubDirs);
       }
   }
}