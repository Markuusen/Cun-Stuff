# This will paste the stored stuff in OneDrive back to the app folders (beta!)

# Path to the (dynamic) OneDrive-Root folder
$OneDrive = "Path/To/OneDrive"

# Path to the relevant app folders as arrays
# array[0] is the name and array[1] the app path
$SAP = @("SAP", "Path/To/SAP")
$MOC =  @("MOC", "Path/To/MOC")
$Downloads = @("Downloads", "$env:Userprofile\Download")

# creating an array of arrays
$srcPaths = @($SAP, $MOC, $Downloads)

#Iterating through the array
foreach ($obj in $srcPaths) {
    # checks if the folder is in OneDrive (and software is installed)
    if(Test-Path "$OneDrive\$obj[0]" -And Test-Path "$obj[1]") {
        # checks if the path, like "Path/To/SAP" exists and if not it will created as a dir
        # side note: if checked previous this if-condition can be commented out
        if(-not(Test-Path "$obj[1]")) {
            New-Item -Path "$obj[1]" -ItemType Directory
        }
        # copies everything the users OneDrive back to said app user-config folders
        Copy-Item -Path "$OneDrive\$obj[0]" -Destination "$obj[1]" -Recurse

    }
}