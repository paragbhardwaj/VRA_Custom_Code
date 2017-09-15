# VRA_Custom_Code
Declare all attributes in VRA as Below
![1](https://user-images.githubusercontent.com/31999666/30501733-435f6b54-9a29-11e7-8695-2ff24b1fe77f.png)

Declare Payload Variable as parameter. This needs to be set in VRA as extensiblity variable.
![2](https://user-images.githubusercontent.com/31999666/30501818-7c4458a8-9a29-11e7-8cc9-51a0430e66d2.png)

Declare output as powershell:powershellRemotePSobject
![3](https://user-images.githubusercontent.com/31999666/30501901-c9a01ce0-9a29-11e7-84f0-81bbb915f069.png)

Drag Scriptable Task here. This will be use as delcare all variables. These variables will be use to run the powershell script and these variable will be use as parameter.
![4](https://user-images.githubusercontent.com/31999666/30501997-20ace874-9a2a-11e7-881f-2b2b4d24eb0b.png)

Add the below variables as output.
![5](https://user-images.githubusercontent.com/31999666/30502049-5405f896-9a2a-11e7-91a9-e83d18a91963.png)

Bind the variables as below binding
![6](https://user-images.githubusercontent.com/31999666/30502099-82cde1f2-9a2a-11e7-97e1-dc006ecff8b3.png)

Drag the other scriptable task as import below variables as input.
![7](https://user-images.githubusercontent.com/31999666/30502153-adad985e-9a2a-11e7-80e9-d3a552c952f2.png)

Below Variable will be as out variables
![8](https://user-images.githubusercontent.com/31999666/30502211-e356dbaa-9a2a-11e7-8226-3d95b198bc79.png)

Bind the variables as below binding
![9](https://user-images.githubusercontent.com/31999666/30502243-01c1c046-9a2b-11e7-9df9-1b0504bf9787.png)

Below will be in scripting pane
![10](https://user-images.githubusercontent.com/31999666/30502270-24ad3662-9a2b-11e7-8844-4fb2499f7cf9.png)

Drag other workflow (Invoke an external) and bing the variable as below
![11](https://user-images.githubusercontent.com/31999666/30502323-5c73fe1e-9a2b-11e7-8250-8a6857e846de.png)

At the end workflow should be as below.
![12](https://user-images.githubusercontent.com/31999666/30502375-97050a6e-9a2b-11e7-91c5-2f9836e8a70e.png)
