Docker - Anaconda and Tensorflow
=============================================

Welcome to the anaconda/tensorflow image.  This image was built to be used as a simple way
to run a standard ML system with tensorflow.    

## Structure

The latest branch will (by default) be setup to use the latest version of python and
tensorflow that are CPU based.  This will allow for the system to use the standard 
ubuntu base image.   

However there are tags that will be created for the gpu specific versions of the system. 
These will each be tagged as such.   

So for every tensorflow example that exists a corresponding version will also exist that
will just have the appended tag value of -gpu, for example: 

        latest           ->    latest-gpu 
        python35         ->    python35-gpu
        python35-onbuild ->    python35-onbuild-gpu

## Running

To use this image you will want to have a volume mounted at `/notebooks`, and expose port
8888.   

        docker run -it --rm -p 8888:8888 -v $PWD:/notebooks mikewright/anaconda-tensorflow:latest-gpu

At this point you can open your browser to [localhost:8888](http://localhost:8888).    

## Building

If you want to have your own tools installed you may do so by creating a Dockerfile based on the
`onbuild` tag.  You will need to have your anaconda environment file created and named `environment.yml`, 
and you will want to set the environment variable `CONDA_ENV` to the name of the enviroment you created.  

        -- environment.yml
        name: myenv
        dependencies:
          - jupyter
          - pymc 

        -- Dockerfile
        FROM mikewright/anaconda-tensorflow:latest-onbuild
        
        ENV CONDA_ENV myenv
