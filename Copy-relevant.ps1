# This will save user-infos to the OneDrive folder of a user
 
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
    # checks if the path, like "$OneDrive\SAP" exists and if not it will created as a dir
    if(-not(Test-Path "$OneDrive\$obj[0]")) {
        New-Item -Path "$OneDrive\$obj[0]" -ItemType Directory
    }
    # copies everything the user needs to said OneDrive
    Copy-Item -Path "$obj[1]" -Destination "$OneDrive\$obj[0]" -Recurse
}
