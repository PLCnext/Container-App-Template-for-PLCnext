# CI/CD Template for PLCnext apps
This template is used to create app's for the PLCnext store. 
The apps itself can contain's OCI images or binary or any other thing than can be executed.

![pipeline](https://gitlab.phoenixcontact.com/vmm-factory-automation/digital-factory/data-collection-storage-evaluation/container-app-template-for-plcnext/badges/$branch/pipeline.svg)
## Description
This project aims to create app's. This app's can run on the PLCnext controllers (like the one's that are deployed on the [plcnextstore](https://www.plcnextstore.com)).

This app's can contain a lot of stuff that's normaly runs on Linux systems. But this template focueses only on running OCI container. An app on the plcnext ecosystem means an running application that can be installed on any plcnext controller.

This projects splits into two seperate projects. One implements an build process for an existing image.
The other one builds up an totaly new one, that contains an OCI image build. 
These sample uses [nginx](https://nginx.org). For the existing image, the ready to use image, from [hub.docker.com](https://hub.docker.com/_/nginx) is used. And for the new build, the [official](https://github.com/nginxinc/docker-nginx) build from the nginx is used.

The Project don't focus on binary files or self developed application that must run on the bare metal. It's aims either create an OCI image or pull some and get that image running on the PLCnext hardware.
## Prerequisites
So if you want to deploy or create an PLCnext app, you have to decide two different cases.
1. ### An existing amage
    If you have already created an image or you want use an existing that you have to adapt, you can choose the folder [build_existing_image](./build_existing_image/). There is everything explained within it. It's load an prebuild nginx image from dockerhub and passes the wrapper system to run on the controllers.
2. ### An build for a new image
    If you have to create an completly new image. There is an sample folder [build_new_image](./build_new_image/) which contains anything that's needed to build an image with the wrapper for running an app.

## File/Project structure
    .
    ├── gitlab-ci.yml
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

So they structure is pretty straightforward. It's splitted within two projects. Also there is an "scripts" folder, it contain's scripts that are needed for the pipeline.
The other two folder represents only the two different projects. A description how to use it, is placed inside this two folders.

Inside the root folder, there is also an gitlab-ci.yml. Within this file, the build process for CI/CD Gitlab is handled there.

## Usage
If you want to use this project. The easiest way is to enable CI/CD Pipeline within Gitlab and to have installed MultiArc runner.
Then it will run through the pipeline. And you can develop your own instance and customized projects.

## Support
If you need help or find some errors, feel free to contact digitalfactorynow@phoenixcontact.com

## Contributing
If you have any suggestions to improve our projects, please feel free to contact us or commit new features to this project.

## License
MIT License, please see [LICENSE](./LICENSE) for details.

## Project status
Project is going through continous improvements.
