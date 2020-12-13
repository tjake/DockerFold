## Running AlphaFold with Docker


 Setup of the [alphafold casp13](https://github.com/deepmind/deepmind-research/tree/master/alphafold_casp13) model is only for linux, this tools allows anyone with docker (mac,pc,etc) to run the model.


### Installation:

  * Install [Docker for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac/)
  
  * Download [this code](https://github.com/tjake/DockerFold/archive/dockerfold.zip)

     `curl https://github.com/tjake/DockerFold/archive/dockerfold.zip --output dockerfold.zip`
     
     `unzip dockerfold.zip`

     `cd DockerFold`


  * Download the model data **(45GB)**

     `curl http://bit.ly/alphafold-casp13-data --output data.zip`

  * Unzip data into same directory
  
     `unzip data.zip -d data`

  * Run model and generate output (first run will build the docker image)
  
     `./run.sh -i data -t T1019s2 -o output_T1019s2`  

     **This will take many hours to run!**