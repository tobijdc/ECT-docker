# ECT Docker

Docker image for [ECT - Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool.git).

The ECT project is licensed under Apache License 2.0, but has depencencies to other libraries, which have other licenses.
You can find those in the ECT repository or in the Docker image in the folder "/opt/licenses".

Relevant code here is under MIT License.

## Background

To make the docker image as small as possible, some analysis was needed.
Here are some notes.

### Dynamic Links of ECT executable

```
  NEEDED               libpthread.so.0
  NEEDED               libstdc++.so.6
  NEEDED               libm.so.6
  NEEDED               libgcc_s.so.1 // libgcc-s1
  NEEDED               libc.so.6
```

### Where libraries where found in debian-slim

```
./lib/x86_64-linux-gnu/libpthread.so.0
./usr/lib/x86_64-linux-gnu/libstdc++.so.6
./lib/x86_64-linux-gnu/libm.so.6
./lib/x86_64-linux-gnu/libgcc_s.so.1
./lib/x86_64-linux-gnu/libc.so.6
```
