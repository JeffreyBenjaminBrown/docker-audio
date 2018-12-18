Virtual package that breaks other packages appears to have no dependencies, so I cannot remove it
---
Some [Dockerfiles on Github](https://github.com/JeffreyBenjaminBrown/docker-audio) demonstrate how to recreate these problems.


# jackd1 and jackd2: Apt considers both impossible?

The [notes for installing SuperCollider from source](https://github.com/supercollider/supercollider/wiki/Installing-SuperCollider-from-source-on-Ubuntu) suggest running `apt-get -s install jackd1 jackd2` to determine which version of JACK is installed. From a *fresh* Ubuntu 18.04 distribution, after doing nothing but apt-update and apt-upgrade, that command reports [these errors](https://github.com/JeffreyBenjaminBrown/docker-audio/blob/936a7817ea50c7de1b63673e09252081a989a582/apt-updated/the-problem.txt).

The `jack-daemon` package appears to be breaking both possibilities. It is a virtual package, so [to remove it I have to remove all of its dependencies](https://askubuntu.com/questions/207505/how-to-completely-remove-virtual-packages). But it appears to depend on nothing but itself:

```
root@7257efef2b18:/# apt-cache depends jack-daemon
<jack-daemon>
root@7257efef2b18:/# 
```

And it looks like I don't have it installed, either:

```
root@7257efef2b18:/# apt-cache policy jack-daemon
jack-daemon:
  Installed: (none)
  Candidate: (none)
  Version table:
root@7257efef2b18:/# 
```

# KXStudio: uninstallable after SuperCollider?

On my native machine I tried installing SuperCollider (from source) after KxStudio (via apt), and I ran into similar errors. So I tried the reverse, in [another Docker image](https://github.com/JeffreyBenjaminBrown/docker-audio/blob/936a7817ea50c7de1b63673e09252081a989a582/supercollider/Dockerfile).

It manages to install `kxstudio-meta-audio`, but breaks at `kxstudio-meta-audio-plugins`.

### Unfinished

So then I tried reversing those two steps. I got some complaints but it installed `kxstudio-meta-restricted-extras`. That's saved as `jeffreybbrown/supercollilder:sc_and_kx_thru_restricted_extras`.

When I try to then install `kxstudio-meta-audio-plugins` I get this error:

 
root@64a4dfdbd1a1:/# apt install kxstudio-meta-audio-plugins -y      
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 kxstudio-meta-audio-plugins : Depends: guitarix but it is not going to be installed
                               Depends: gigedit but it is not going to be installed
                               Depends: dpf-plugins but it is not going to be installed
                               Recommends: kxstudio-meta-audio-plugins-collection but it is not going to be installed or
                                           kxstudio-meta-audio-plugins-ladspa but it is not going to be installed
                               Recommends: kxstudio-meta-audio-plugins-collection but it is not going to be installed or
                                           kxstudio-meta-audio-plugins-dssi but it is not going to be installed
                               Recommends: kxstudio-meta-audio-plugins-collection but it is not going to be installed or
                                           kxstudio-meta-audio-plugins-lv2 but it is not going to be installed
                               Recommends: kxstudio-meta-audio-plugins-collection but it is not going to be installed or
                                           kxstudio-meta-audio-plugins-vst but it is not going to be installed
E: Unable to correct problems, you have held broken packages.
root@64a4dfdbd1a1:/# 
