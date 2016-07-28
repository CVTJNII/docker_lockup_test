Docker Lockup Test
==================

This is a Vagrant config that reproduces lockups seen when Docker launches short lived containers.
It is intended to reproduce lockups reproducibly seen inproduction within approximately 24 hours when 1-5 short lived containers are started every minute. 
For the test dozens of containers are launched concurrently in rapid succession to try and reproduce the error within a more reasonable time frame, though it still takes several hours.

Running
-------

### Start the vagrant machine:

```
vagrant up
```

Note that the Vagrant VM will reboot as the provisioner script (setup_vm.sh) updates the kernel.

### Run the test

```
vagrant ssh
sudo ./run_test.sh
```

The test runs multiple loops creating short lived docker containers concurrently.
The number of container per loop ($1) and concurrency ($2) are tunable.

If the test succeeds in reproducing the issue the VM will be unstable.
It is recommended to run 

```
watch 'dmesg | tail -n ${appropriate_length_for_terminal}'
```

in another vagrant ssh terminal to see the kernel errors before it chokes.

Docker issues reproduced
------------------------

- [Docker hang after intensive run/remove operations](https://github.com/docker/docker/issues/19758)
- [Docker containers leaving /run/network/ifstate files behind on Ubuntu 14.04](https://github.com/docker/docker/issues/22513)
- Driver aufs failed to remove root filesystem (Existing issues not looked up)

Notes
-----

- It was believed that network traffic (per the exe process in docker#19758) might be a factor.  This was ruled out as the current setup hangs with no network active containers.
