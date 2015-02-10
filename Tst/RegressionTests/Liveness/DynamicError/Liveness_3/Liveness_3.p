// Liveness Bug : Liveness bug detected with the target thread blocked (no deadlock)

event UserEvent;
event Done;
event Waiting;
event Computing;

main machine EventHandler
{
       start state WaitForUser
       {
            entry {
				new WatchDog();
				new Loop();
				monitor WatchDog, Waiting;
				send this, UserEvent;
				}
            on UserEvent goto HandleEvent;
       }
  
       state HandleEvent
       {
            entry { 
				monitor WatchDog, Computing;
				//send this, Done;
				}			
            on Done goto HandleEvent;  //if Loop machine keeps processing Done,
			                           //liveness is violated
       }
}

machine Loop
{
	start state Looping{
		entry {
			send this, Done;
		}
		on Done goto Looping;
	}
}

monitor WatchDog
{
      start cold state CanGetUserInput
      {
             on Waiting goto CanGetUserInput;
             on Computing goto CannotGetUserInput;
      } 
	  hot state CannotGetUserInput
     {
		entry {
		}
             on Waiting goto CanGetUserInput;
             on Computing goto CannotGetUserInput;
     }
}
