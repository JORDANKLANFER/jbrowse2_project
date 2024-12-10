# ⚙️ Setup
We assume you are running the project on either macOS or Linux through AWS. Clone this repository using the `git clone <link-to-repo>`.

## 1.1 MacOS Setup 
Open a terminal and run the line below to install **homebrew**, a macOS package manager. You can skip this step if you already have brew installed.
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
If this doesn't work, visit https://docs.brew.sh/Installation for further installation options, including a .pkg installer that should be convenient and easy to use.

## 1.2 Linuxbrew for AWS
Follow the separate AWS [setup guide](./aws_instructions.md), then return here to set up linuxbrew below.
Make sure you are using a Debian or Ubuntu distribution. Then go ahead and install linuxbrew, using the instructions below:

1. Switch to root with: `sudo su -`
2. Then run: `passwd ubuntu`
3. It is going to prompt : `Enter new UNIX password:`

Set the password and exit root by typing `exit`. 

Install brew using the bash script from https://brew.sh/. You will be prompted to set the password you made earlier.
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After this is complete, add brew to your execution path:
```
echo >> /home/ubuntu/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

# 🛠️ Install Tools 

## 2.1.1 Node.js on MacOS 
Check if Node.js is downloaded by running the following command. If the following command, prints out `v20.18.0` or higher, this step can be skipped. If not, run the following command:

```
# download and install Node.js
brew install node@20
# verifies the right Node.js version is in the environment
node -v # should print `v20.18.0`
# verifies the right npm version is in the environment
npm -v # should print `10.8.2`
```
## 2.1.2 Node.js on Linux for AWS
 See https://nodejs.org/en/download/package-manager for more detail. On AWS, you may need to run `sudo apt install unzip` first.
```
# Install fnm (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | bash
# activate fnm
source ~/.bashrc
# Download and install Node.js using fsm
fnm use --install-if-missing 20
# Verify Node.js version in the environment
node -v # should print `v20.18.0`
# Verify npm version in the environment
npm -v # should print `10.8.2`
```
**Note:** if you try something and are denied due to permissions, running the command with `sudo` is often the solution, which runs the commands with root/admin privileges.

## 2.2 @jbrowse/cli for both MacOS and Linux (AWS)
Run the following command to use Node.js package manager to download the latest stable version of the jbrowse command line tool on both MacOS/Linux (AWS).
```
sudo npm install -g @jbrowse/cli
jbrowse --version # should print @jbrowse/cli/2.17.0 darwin-arm64 node-v20.18.0
```
**Note:** if the above command doesn't work, you can try `npm install -g @jbrowse/cli `.
## 2.3 System dependencies
Install the following tools, if not already installed:
### MacOS
```
brew install wget httpd samtools htslib minimap2
```
### Linux (AWS)
```
sudo apt install wget apache2
brew install samtools htslib minimap2
```
# 🌐 Start the Server
## 3.1 Start the apache server
Starting up the web server will provide a localhost page to show that apache2 is installed and working correctly. 
### MacOS
```
sudo brew services start httpd
```

if you receive error message: "httpd must be run as non-root to start at user login!" Retry without Sudo-ing in
```
brew services start httpd
```

### Linux (AWS)
AWS will have a public IP address that you need to identify in the aws_instructions.
```
sudo service apache2 start
```
## 3.2 Get the host
### MacOS
The hostname is `localhost`
### Linux (AWS)
In your instance summary page, there should be an "auto-assigned IP address." Your web server can be accessed at `http://ipaddress`. You don't need to provide a port.

Open a browser and type the appropriate url into the address bar. You should then get to a page that says **"It works!"** (for AWS there may be some additional info). If you have trouble accessing the server, you can try checking your firewall settings and disabling any VPNs or proxies to make sure traffic to localhost is allowed.

## 3.3 Apache server folder
### MacOS
Installation on MacOS using brew, the apache2 server holder is likely in in `/opt/homebrew/var/www` (for M1) or `/usr/local/var/www` (for Intel).
### Linux (AWS)
For a normal linux installation, the folder should be `/var/www` or `/var/www/html`.

You can run `brew --prefix` to get the brew install location, and then from there it is in the `var/www` folder. Make sure that one of these folders exist and take note of what the folder is. Run the command below to store it as a command-line variable. You will need to re-run the export if you restart your terminal session!
```
# Replace the path with your actual true path!
export APACHE_ROOT='/path/to/rootdir'
```

## 3.4 Download JBrowse2 into Apache2
Download and copy over JBrowse 2 into the apache2 root dir, setting the owner to the current user with `chown` and printing out the version number. This version doesn't have to match the command-line jbrowse version, but it should be a version that makes sense.
```
jbrowse create output_folder
sudo mv output_folder $APACHE_ROOT/jbrowse2
sudo chown -R $(whoami) $APACHE_ROOT/jbrowse2
```
In your browser, now type in   `http://yourhost/jbrowse2/`, where `yourhost` is either localhost or the IP address from earlier. Now you should see the words **"It worked!"** with a green box underneath saying "JBrowse 2 is installed." with some additional details.

# 📊 Load and Process Data
Within the `jbrowse2_project` directory, run the following script to fetch and process the data on both MacOS and Linux (AWS):
```
bash fetch_and_process_data.sh
```

# 🧬 Launch the JBrowse Instance
Open `http://yourhost/jbrowse2/` again in your web browser and use the database tool to conduct explorations on Lentivirus genomic and functional protein data.

# 🌍 Access Virus Data via Accession Numbers

This table provides the accession numbers for various virus datasets. If the provided links fail, you can use these accession numbers to retrieve the data directly from the [UniProt database](https://www.uniprot.org).

| **Virus Label**       | **Accession Number** |
|------------------------|----------------------|
| HIV1 M B gag pol       | P12497              |
| HIV1 M C gag pol       | O12158              |
| HIV2 A gag pol         | P12451              |
| HIV2 B gag pol         | P15833              |
| SIV cpz gag pol        | Q1A267              |
| HIV1 M B env           | P12490              |
| HIV1 M C env           | O12164              |
| HIV2 A env             | P12449              |
| HIV2 B env             | P15831              |
| SIV cpz env            | Q1A261              |

Feel free to use these accession numbers to manually search and access genomic and protein data from trusted resources. 🔗
