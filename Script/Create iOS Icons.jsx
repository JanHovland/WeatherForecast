// Photoshop Script to Create iPhone Icons from iTunesArtwork
//
// WARNING!!! In the rare case that there are name collisions, this script will
// overwrite (delete perminently) files in the same folder in which the selected
// iTunesArtwork file is located. Therefore, to be safe, before running the
// script, it's best to make sure the selected iTuensArtwork file is the only
// file in its containing folder.
//
// Copyright (c) 2010 Matt Di Pasquale
// Added tweaks Copyright (c) 2012 by Josh Jones http://www.appsbynight.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// Prerequisite:
// First, create at least a 1024x1024 px PNG file according to:
// http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/BuildTimeConfiguration/BuildTimeConfiguration.html
//
// Install - Save Create Icons.jsx to:
//   Win: C:\Program Files\Adobe\Adobe Utilities\ExtendScript Toolkit CS5\SDK
//   Mac: /Applications/Utilities/Adobe Utilities/ExtendScript Toolkit CS5/SDK
// * Restart Photoshop
//
// Update:
// * Just modify & save, no need to resart Photoshop once it's installed.
//
// Run:
// * With Photoshop open, select File > Scripts > Create Icons
// * When prompted select the prepared iTunesArtwork file for your app.
// * The different version of the icons will get saved to the same folder that
//   the iTunesArtwork file is in.
//
// Adobe Photoshop JavaScript Reference
// http://www.adobe.com/devnet/photoshop/scripting.html


// Turn debugger on. 0 is off.
// $.level = 1;

try
{
  // Prompt user to select iTunesArtwork file. Clicking "Cancel" returns null.
  var iTunesArtwork = File.openDialog("Select a sqaure PNG file that is at least 1024x1024.", "*.png", false);

  if (iTunesArtwork !== null)
  {
    var doc = open(iTunesArtwork, OpenDocumentType.PNG);
    
    if (doc == null)
    {
      throw "Something is wrong with the file.  Make sure it's a valid PNG file.";
    }

    var startState = doc.activeHistoryState;       // save for undo
    var initialPrefs = app.preferences.rulerUnits; // will restore at end
    app.preferences.rulerUnits = Units.PIXELS;     // use pixels

    if (doc.width != doc.height)
    {
        throw "Image is not square";
    }
    else if ((doc.width < 1024) && (doc.height < 1024))
    {
        throw "Image is too small!  Image must be at least 1024x1024 pixels.";
    }
    else if (doc.width < 1024)
    {
        throw "Image width is too small!  Image width must be at least 1024 pixels.";
    }
    else if (doc.height < 1024)
    {
        throw "Image height is too small!  Image height must be at least 1024 pixels.";
    }
    
    // Folder selection dialog
    var destFolder = Folder.selectDialog( "Choose an output folder");

    if (destFolder == null)
    {
      // User canceled, just exit
      throw "";
    }

    // Save icons in PNG using Save for Web.
    var sfw = new ExportOptionsSaveForWeb();
    sfw.format = SaveDocumentType.PNG;
    sfw.PNG8 = false; // use PNG-24
    sfw.transparency = true;
    doc.info = null;  // delete metadata
    
    var icons = [
      {"name": "Cloudkit-16",          "size":16},
      {"name": "Cloudkit-16@2x",       "size":32},
      {"name": "Cloudkit-20",          "size":20},
      {"name": "Cloudkit-20@2x",       "size":40},
      {"name": "Cloudkit-20@3x",       "size":60},
      {"name": "Cloudkit-23",          "size":23},
      {"name": "Cloudkit-23@2x",       "size":46},
      {"name": "Cloudkit-23@3x",       "size":69},
      {"name": "Cloudkit-25",          "size":25},
      {"name": "Cloudkit-25@2x",       "size":50},
      {"name": "Cloudkit-25@3x",       "size":75},
      {"name": "Cloudkit-29",          "size":29},
      {"name": "Cloudkit-29@2x",       "size":58},
      {"name": "Cloudkit-29@3x",       "size":87},
      {"name": "Cloudkit-30",          "size":30},
      {"name": "Cloudkit-30@2x",       "size":60},
      {"name": "Cloudkit-30@3x",       "size":90},
      {"name": "Cloudkit-31",          "size":31},
      {"name": "Cloudkit-31@2x",       "size":62},
      {"name": "Cloudkit-31@3x",       "size":93},
      {"name": "Cloudkit-32",          "size":32},
      {"name": "Cloudkit-32@2x",       "size":64},
      {"name": "Cloudkit-32@3x",       "size":96},
      {"name": "Cloudkit-35",          "size":35},
      {"name": "Cloudkit-35@2x",       "size":70},
      {"name": "Cloudkit-35@3x",       "size":105},
      {"name": "Cloudkit-40",          "size":40},
      {"name": "Cloudkit-40@2x",       "size":80},
      {"name": "Cloudkit-40@3x",       "size":120},
      {"name": "Cloudkit-58",          "size":58},
      {"name": "Cloudkit-58@2x",       "size":116},
      {"name": "Cloudkit-58@3x",       "size":174},
      {"name": "Cloudkit-60",          "size":60},
      {"name": "Cloudkit-60@2x",       "size":120},
      {"name": "Cloudkit-60@3x",       "size":180},
      {"name": "Cloudkit-76",          "size":76},
      {"name": "Cloudkit-76@2x",       "size":152},
      {"name": "Cloudkit-76@3x",       "size":228},
      {"name": "Cloudkit-80",          "size":80},
      {"name": "Cloudkit-80@2x",       "size":160},
      {"name": "Cloudkit-80@3x",       "size":240},
      {"name": "Cloudkit-83.5",        "size":83.5},
      {"name": "Cloudkit-83.5@2x",     "size":167},
      {"name": "Cloudkit-83.5@3x",     "size":250.5},
      {"name": "Cloudkit-128",         "size":128},
      {"name": "Cloudkit-128@2x",      "size":256},
      {"name": "Cloudkit-256",         "size":256},
      {"name": "Cloudkit-256@2x",      "size":512},
      {"name": "Cloudkit-512",         "size":512},
      {"name": "Cloudkit-512@2x",      "size":1024}
    ];

    var icon;
    for (i = 0; i < icons.length; i++)
    {
      icon = icons[i];
      doc.resizeImage(icon.size, icon.size, // width, height
                      null, ResampleMethod.BICUBICSHARPER);

      var destFileName = icon.name + ".png";

      doc.exportDocument(new File(destFolder + "/" + destFileName), ExportType.SAVEFORWEB, sfw);
      doc.activeHistoryState = startState; // undo resize
    }

    alert("iOS Icons created!");
  }
}
catch (exception)
{
  // Show degbug message and then quit
    if ((exception != null) && (exception != ""))
    alert(exception);
 }
finally
{
    if (doc != null)
        doc.close(SaveOptions.DONOTSAVECHANGES);
  
    app.preferences.rulerUnits = initialPrefs; // restore prefs
}
