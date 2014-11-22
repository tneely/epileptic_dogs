 _____      _ _                           
|  ___|    (_) |                          
| |__ _ __  _| | ___ _ __  ___ _   _      
|  __| '_ \| | |/ _ \ '_ \/ __| | | |     
| |__| |_) | | |  __/ |_) \__ \ |_| |     
\____/ .__/|_|_|\___| .__/|___/\__, |     
     | |            | |         __/ |     
     |_|            |_|        |___/      
______             _ _      _             
| ___ \           | (_)    | |            
| |_/ / __ ___  __| |_  ___| |_ ___  _ __ 
|  __/ '__/ _ \/ _` | |/ __| __/ _ \| '__|
| |  | | |  __/ (_| | | (__| || (_) | |   
\_|  |_|  \___|\__,_|_|\___|\__\___/|_|   
                                          
===============================================================================                                     
by Jack Terwilliger and Taylor Neely
===============================================================================

Before you begin, please add the entiredirectory to your path

===============================================================================
Feature Generation note: you must select multiple examples
===============================================================================

1.)enter: read_gen(1, 0, 1, 1, 1, 1)

2.)Wait for the file browser, then navigate to /features/Dog5 Partial RAW/

3.)Select Multiple Files or the Function will crash

===============================================================================
Run A Test
===============================================================================

to test that the Neural Network works 
1.)enter: XOR


to test gradient descent
1.) enter: load('dog5')

2.) [error, net, sens, fpr]= eeg_train(feats5_1w_0o, Y5, 200, .3, .85, .05)
plot(error)



Cross Validation Warning it takes a significant amount of time
1.) enter: [sensitivity, falsepositive] = cross_val(feats5_1w_0o, Y5, 10, 200)

