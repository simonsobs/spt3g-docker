# spt3g-docker

Automated builds of a docker image with spt3g installed.

We rely on the [spt3g_software](https://github.com/CMB-S4/spt3g_software)
repository as a basis for any of our containers that require so3g. This
repository automates checking for updates upstream, rebuilding an spt3g base
image, and pushing it to a registry.

## Getting Started

### Dependencies

* git
* make
* docker

### Quickstart

If you're simply interested in building the image yourself, clone this repository and run:

```bash
make build
```

### Publishing to Registry
If you want to push to the registry you need to be logged into the registry in
question (this repo uses a private registry). This is encoded in the name for
our docker image at the top of the `Makefile`. Once you are logged in you can
build and push simply with:

```bash
make
```

### Details
The `Makefile` is setup to do the following steps in this order:

* Clone the `spt3g_software` git repo
* Check if the repo is up to date with a fetch
* Pull if it is it out of date
* Build the docker image
* Test importing the spt3g package within the container
* Push the image to the registry

There are several dummy files output as `make` targets, which ensures each step
is only run when required, i.e. if the repo has been updated.

The image will be tagged with the short git commit hash, and the "latest" tag
will only be updated if the build was successful.

## Cleaning-up
If the spt3g repo has been updated since you last ran `make`, running it again
will fetch updates and rebuild. If you want to force a rebuild, or just clean
up the dummy targets and pulled repo you can do so with:

```bash
make clean
```

## crontab
For regularly building the image you can setup a cronjob like:

```bash
 0 */6 * * * /usr/bin/make -C /home/user/spt3g-docker >> /home/user/log/spt3g-docker.log
```

This will check for updates and rebuild every six hours.

## License

This project is licensed under the BSD 2-Clause License - see the [LICENSE.txt](LICENSE.txt) file for details.
