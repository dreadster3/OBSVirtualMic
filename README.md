# OBS Virtual Microphone

Bash script to create a virtual sink that outputs to a virtual microphone.
By addition it will also create a combined sink using the virtual sink and the default sink.

## Usage

### How to route OBS outputs and inputs

- Go to Settings > Audio > Advanced > Monitoring Device and set the device to the virtual sink created, `OBSMic Audio/Sink sink`
- In the Audio Mixer go to Advanced Audio Properties and set any audio to be sent to the virtual mic to `Monitor and Output`

### How to route a specific application to virtual mic

- Using any audio mixer set output of application to the combined sink create `OBSCombined`.
