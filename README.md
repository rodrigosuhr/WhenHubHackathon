# WhenHub Hackathon App

## How to download the WhenHub Hackathon App

You can clone the git repository from github (1), or just download a zip file that contains the project (2).

1. Clone the git repository on your destination folder:

    ```
    git clone https://github.com/rodrigosuhr/WhenHubHackathon.git
    ```

2. Download [this zip file](https://github.com/rodrigosuhr/WhenHubHackathon/archive/master.zip) and unzip it in your destination folder.

## How to test the WhenHub Hackathon App

1. Open the project in Xcode:

    ```
    double click on your_destination_folder/WhenHubHackathon/WhenHubApp.xcworkspace
    ```

2. In the file WhenHubAPIConstants.swift, change the property ACCESS_TOKEN, filling it with your own access token string:

    ```Swift
    import Foundation

    class WhenHubAPIConstants {
        static let ACCESS_TOKEN = "AccessTokenString"
    }
    ```

3. Run the project in Xcode, choosing any iPhone simulator.
