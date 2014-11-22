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

       __,-----._                       ,-.   
     ,'   ,-.    \`---.          ,-----<._/           ,--._______,-. 
    (,.-. o:.`    )),"\\-._    ,'         `.        ,','  ,    .  ,_`-. 
   ('"-` .\       \`:_ )\  `-;'-._          \      / /  ,' , _` ``. |  )       `-.. 
  ,,-.    \` ;  :  \( `-'     ) -._     :   `:    (,';'""`/ '"`-._ ` \/ ______    \\ 
 (    \ `._\\ ` ;             ;    `    :    )     : ,o.-`- ,o.  )\` -'      `---.)) 
  \`.  `-.    __   ,         /  \        ;, (      : , d8b ^-.   '|   `.      `    `. 
   `.`-.___--'  `-          /    ;     | :   |     |/ __:_     `. |  ,  `       `    \ 
     `-' `-.`--._          '           ;     |     ;-'`:::._,`.__),'             :     ; 
           (`--._`.                ;   /\    |    / ,  `-   `--                  ;     | 
            \     '                \  ,  )   :   /  \                   `       ,      | 
            |  `--::----            \'   ;  ;|  (    `     :              :    ,\      | 
            \    .__,-      (        )   :  :|   \   `.    :     :        :  ,'  \    : 
             \    : `------; \      |    |   ;    \    `|-- `     \ ,'    ,-'     :-.-'; 
              \   :       / , )     |    |  (     :     |`--.______;     |        :    : 
     -hrr-     \   \      `-^-|     |   / , ,\    :    /           |    |         |   \ 
                )  )          | -^- ;   `-^-^'    |    ;           ;    ;        /     ; 
             _,' _ ;          |    |            _/--' |   -hrr-   :`-- /         \_:_:_| 
            / , , ,'         /---. :          ,',','  |           |___ \ 
            `-^-^'          (  :  :,'         `^._,--'           / , , .) 
                             `-^--'                 
    
                                          
===============================================================================                                     
by Jack Terwilliger and Taylor Neely
===============================================================================

Before you begin, please add the our whole project to your MATLAB path.

Please note, that all features have been already computed, however
a sampling of raw data has been provided for you to test feature generation.

===============================================================================
I. Feature Generation | note: you must select multiple examples
===============================================================================

1.)enter: [featsX, Y] = read_gen(1, 0, 1, 1, 1, 1)
	read_gen allows you to turn on and off different parts of feature
	generation, here we choose all the features, choose one time window
	and turn off overlapping sliding windows(it never improved our results)


2.)Wait for the file browser, then navigate to /features/Dog5 Partial RAW/

IMPORTANT: Select Multiple Files or the Function will crash

===============================================================================
II. Gradient Descent on those Features
===============================================================================

Now you will run gradient descent on the features you just generated
eeg_train takes, trainX trainY, a learning rate, momentum, and decay
Feel free to play with the parameters.

1.)enter: [error, net, ~, ~]= eeg_train(featsX, Y, 200, .3, .85, .05)

Note: the last two outputs are sensitivity and FPR and require additional
input parameters (testX, testY). These are used for getting accuracy
over each epoch in cross_val_aot.m

Now plot the error over epochs. It should appear to descend.

2.)plot(error)



===============================================================================
III. Cross Validation Warning it takes a significant amount of time
===============================================================================

This takes a little longer than gradient descent, however if you run this on 
the features that you recently generated, it should take no more than 1 minute.
Folds (10) and trials (200) can be adjusted at will.

1.) enter: [sensitivity, falsepositive] = cross_val(featsX, Y, 10, 200)

===============================================================================

===============================================================================
