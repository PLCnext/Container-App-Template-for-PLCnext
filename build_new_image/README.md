# Base wrapper for new buildings Images

## Description

This project subfolder contain's a basic wrapper for PLCnext app's. We have the possibility to create new image. This is possible with this folder and the related processes in the pipelines.
The project itself holds three folders:

      .
      ├── arm
      ├── build
      └── x86
PLCnext consist out of two different processor architectures. The 1152, 2152 are using the ARM architecture, and all other PLC's from PLCnext family containing an x86 architecture. Therefore we had to build two slightly different app structures.

The file structure itself is nearly identical, but for e.g. we use podman and therefore we have to differentiate between *[podman-compose](https://github.com/containers/podman-compose)* version.

So if you have to use an special version for each architecture or need to add architecture specific dependecies, you can archive this by adding to the respective folder.

The *[build directory](./build)* holds all neccessary context for the build process. As sample for this template was an [nginx](https://github.com/nginxinc/docker-nginx) build choosen.  

## Configure Project

In order to adapt your project there are few things that have to be adapted.
Within the root directory you have to edit the [gitlab-ci.yml](../.gitlab-ci.yml) file. There are some environmental variables to be changed and if you want you can adapt your folder structure.

### Edit Environmental Variables to Pipeline Configuration

An PLCnext app needs the app_info.json as information for the plcnext runtime. It provides information about the appname, id etc. The following variables are heavily needed for an existing images.

1. `APP_VERSION` is the displayed version number in the web based managment app section (The appversion on the *[plcnextstore](https://plcnextstore.com)* must be set seperat on the app configuration via *[plcnextstore](https://plcnextstore.com)*).
2. `MINFIRMWARE_VERSION` sets the executable minimum firmware version.
3. `APP_NAME` is the displayed and overall used Name inside the app and on the running system.
4. `LICENSE_TYPE` it can be set to activate an licensing function.
5. `MANUFACTOR` you can set your name or your company name. It will be represenet on the web based managment.
6. `LINUXDAEMON_PATH` these path is preconfigured, if no additional script is needed, these settings can be retained(it's needed that the app can be executed). The script that will be executed is an empty placeholder.
7. Different version between x86 and arm architecture:
   1. `IDENTIFIER_ARM` and `IDENTIFIER_X86` are the unique identifier provided by the *[plcnextstore](https://plcnextstore.com)*. These must be different due to the different platforms.
   2. `TARGET_ARM` and `TARGET_X86`
8. Build specific variables(also this information will set to [env_x86](./x86/.env) and [env_arm](./arm/.env) so that containers can be startet proberly):
   1. `IMAGE_NAME` it's the image name that will used for the build.
   2. `IMAGE_TAG` is the tag that we set to the OCI image.

So all of these variables need to be changed to your needs and project.

### Add Project Dependecies

The also a few other steps to get an running OCI Container.
Currently the *[init.d](https://github.com/plcnextusa/init.d_Example)* system is used to manage start and stop scripts on plcnext controller.
So there is an script  ([initscript_arm](./arm/initscript.sh), [initscript_x86](./x86/initscript.sh)) for each startup process. Inside these script all dependecies are accomplished and copied, neccessary things will be loaded and if everything runs succesfuel podman will start up the containers.

If you want extend your applications with additional information, normally all things that has to be in some form executed must be done there(like overwrite existing file/folder permissions etc. ).

If you want to extend base images you could mount files. These can be done by adding an new folder (e.g ./arm/volumes and ./x86/volumes) and add these as an mounting volume to the [docker-compose.yml](./arm/docker-compose.yml) file.

### Build Context

These pipeline builds it's images with [kaniko](https://github.com/GoogleContainerTools/kaniko). The main benefits is that it can be run rootless and build multiplatform images. This is the right advantages for this use case.
In order to build such images it has to provide the context for the build process. Within the folder [build](./build) all relevant information and scripts for the build are provided.

      .
      ├── 10-listen-on-ipv6-by-default.sh
      ├── 20-envsubst-on-templates.sh
      ├── 30-tune-worker-processes.sh
      ├── Dockerfile                         
      └── docker-entrypoint.sh

Inside this structure you can adapt to your images. If the build process runs on your local machine, it can be run also on the kaniko executer. So you just have to adapt to your own settings and build scene and then it's possible to run on an CI/CD pipeline.

## Pipeline structure

The pipeline splits into one stage. The stage is called *container_existing_image* it will download the predefined image, that has been set in [configuration part](#edit-environmental-variables-to-pipeline-configuration)
