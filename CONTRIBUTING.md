# -- **Contributing to Vs. br --**

Welcome to the contributing guide! You can contribute to the Vs. br repository by opening issues or pull requests. This guide will cover best practices for each type of contribution.

# Chapter 1 - Issues

Issues serve many purposes, from reporting bugs to suggesting new features.
This section provides guidelines to follow when [opening an issue](https://github.com/charlesisfeline/VsBrMod/issues).

## Requirements

Make sure you're playing:

- the latest version of [Codename Engine](https://codename-engine.com/)
- in a clean slate, without any addons

## Issue Types

> [!TIP]
> If neither of these templates suit your inquiry (ex. Questions), it's best to open a [discussion](https://github.com/charlesisfeline/VsBrMod/discussions) instead to prevent clutter.

Choose the issue template that best suits your needs!
Here's what each template is designed for:

### Bug Report ([view list](https://github.com/charlesisfeline/VsBrMod/issues?q=is%3Aissue%20state%3Aopen%20label%3Abug))

For minor bugs and general issues with the mod. Choose this one if none of the others fit your needs.

### Crash Report ([view list](https://github.com/charlesisfeline/VsBrMod/issues?q=is%3Aissue%20state%3Aopen%20label%3Acrash))

For crashes and freezes. Codename Engine is still in beta, so you probably might expect some. Not to mention, the mod hasn't even released yet, so keep that in mind.

### Charting Issue ([view list](https://github.com/charlesisfeline/VsBrMod/issues?q=is%3Aissue%20state%3Aopen%20label%3A%22charting%20issue%22))

For misplaced notes, wonky camera movements, broken song events, and everything related to the mod's charts.

### Enhancement ([view list](http://github.com/charlesisfeline/VsBrMod/issues?q=is%3Aissue%20state%3Aopen%20label%3Aenhancement))

For suggestions to add new features or improve existing ones. We'd love to hear your ideas!

## But before you submit...

Use the search bar on the Issues page to check that your issue hasn't already been reported by someone else! Duplicate issues make it harder to keep track of important issues with the game.
Also only report one issue or enhancement at a time! That way they're easier to track. Once you're sure your issue is unique and specific, feel free to submit it.

**Thank you for opening issues!**

# Chapter 2 - Pull Requests

Community members are welcome to contribute their changes by [opening pull requests](https://github.com/charlesisfeline/VsBrMod/pulls).
This section covers guidelines for opening and managing pull requests (PRs).

## Merge Conflicts and Rebasing

Some updates for the mod introduce significant breaking changes that may create merge conflicts in your PR. To resolve them, you will need to update or rebase your PR.

Most merge conflicts are pretty small and will only require you to modify a few files to resolve them. However, some changes are so big that your commit history will look like a mess! In this case, you will have to perform a [**rebase**](https://docs.github.com/en/get-started/using-git/about-git-rebase). This process reapplies your changes on top of the updated branch and cleanly resolves the merge conflicts.

## Code PRs

Code-based PRs make changes such as **fixing bugs** or **implementing new features** in the mod. This involves modifying one or several of the repository’s `.hx` files, found within the `data/`, `songs/` and `source/` folders.

### Codestyle

Before submitting your PR, check that your code follows the [Style Guide](https://github.com/charlesisfeline/VsBrMod/blob/main/CODESTYLE.md).

Here are some guidelines for writing comments in your code:

- Leave comments only when you believe a piece of code warrants explanation.
- Ensure that your comments provide meaningful insight into the function or purpose of the code.
- Write your comments in a clear and concise manner.
- Only sign your comments with your name when your changes are complex and may require further explanation.

## Documentation PRs

Documentation-based PRs make changes such as **fixing typos** or **adding new information** in documentation files. This involves modifying one or several of the repository’s `.md` files, found throughout the repository. Make sure your changes are easy to understand and formatted consistently to maximize clarity and readability.

> [!CAUTION]
> DON'T YOU DARE TOUCH THE `LICENSE` FILE, EVEN TO MAKE SMALL CHANGES!

## GitHub PRs

GitHub-related PRs make changes such as **tweaking the Issue Templates** or **updating the repository’s workflows**. This involves modifying one or several of the repository’s `.yml` files, or any other file in the `.github/` folder. Please test these changes on your fork’s main branch to avoid breaking anything in this repository (e.g. GitHub Actions, issue templates, etc.)!

# Closing

Thank you for reading the Contributing Guide. We look forward to seeing your contributions to the mod!
