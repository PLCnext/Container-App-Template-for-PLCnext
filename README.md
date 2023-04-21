# CI/CD Template for PLCnext apps
This template is used to create app's for the PLCnext store. 
The apps itself can contain's OCI images or binary or any other thing than can be executed.

![pipeline](https://gitlab.phoenixcontact.com/vmm-factory-automation/digital-factory/data-collection-storage-evaluation/container-app-template-for-plcnext/badges/$branch/pipeline.svg)
## Description
This project aims to create app's. This app's can run on the PLCnext controllers (like the one's that are deployed on the [plcnextstore](https://www.plcnextstore.com)). 

This app's can contain a lot of stuff that's normaly runs on Linux systems. 

This projects splits into two seperate projects. One implements an build process for an existing image.
The other one builds up an totaly new one, that contains an OCI image build. 
These sample uses [nginx](https://nginx.org). For the existing image, the ready to use image, from [hub.docker.com](https://hub.docker.com/_/nginx) is used. And for the new build, the [official](https://github.com/nginxinc/docker-nginx) build from the nginx is used.

The Project don't focus on binary files or self developed application that must run the bare metal. It's aims either create an OCI image or pull some and get that image running on the PLCnext hardware.
## Prerequisites
So if you want to deploy or create an PLCnext app, you have to decide two different cases. 
1. ### An existing amage
    You can choose the folder [build_existing_image](./build_existing_image/) 
2. ### An build for a new image
## File/Project structure

    .
    ├── LICENSE
    ├── README.md
    ├── build_existing_image                 
    │   ├── README.md   
    │   ├── arm                 # base structure app arm
    │   └── x86                 # base structure app x86
    ├── build_new_image
    │   ├── README.md
    │   ├── build               # dependecys for build process
    │   ├── arm                 # base structure app arm
    │   └── x86                 # base structure app x86
    └── scripts
        ├── download-frozen-image-v2.sh 
        └── replace_or_add_string.sh

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
This project is licensed 

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
