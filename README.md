# EDA Code Downloader

`eda-code-downloader` is a command line tool that clones down all of your Dev Academy code for you. It handles pairing and solo branch names, and can also be used to download all the challenges for a cohort.

## Installation

```
$ gem install eda-code-downloader
```

## Usage

```
$ eda-code-downloader
```

You will be prompted to enter your cohort's Github organization, your Github credentials, your name and the location to clone.

Github organization is expected to be formatted as `great-spotted-kiwis-2014`. It's in the url of your cohort's github organization.

Your Github credentials are required to access your cohort's repositories. I recommend you choose to use a personal access token instead of your password, but either way nothing is stored.

You can issue a personal access token by visiting [this page](https://github.com/settings/tokens/new). You can then use it in place of a password. See this [Github help page](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) for more information.

Your name is used to determine the branches to clone down. `eda-code-downloader` simply finds the first branch that contains the name you provide (case insensitive), so it finds branches like 'nick' or 'Nick_and_Hannah' alike. Bonus functionality. If you you provide 'master' as your name, the tool will download all of the repos from the cohort.

The location to clone defaults to `~/eda-code/<cohort>` if left blank.

Example usage for me:

```
 $ eda-code-downloader
Github Organization to download from (e.g: kakapo-2015):  great-spotted-kiwis-2014
Github Username: Widdershin
Github Password/Personal Access Token (not stored): ****************
What's your name? All branches containing this string will be cloned.
nick
Where should I clone the repos to?  |~/eda-repos/great-spotted-kiwis-2014|

Cloning repos from great-spotted-kiwis-2014...

...
```


## Contributing

Bug reports and pull requests are welcome.

