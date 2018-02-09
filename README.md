# one-thing
One Thing at a Time: a simple, yet intelligent task management tool.  
Written in Swift 4.0.

## Premise
**One Thing at a Time** helps you focus on what matters _right now_. It balances urgent tasks & projects _(File taxes by Friday!)_ against the truly important but non-urgent stuff you've never gotten around to _(Write a best-selling novel)_.   

The key concept to reducing resistance against working against these types of big projects is what [Mark Forster](http://markforster.net/) calls "little and often" — work on it for a little bit, and come back to it often.  You don't necessarily have to _finish_ that seemingly [Sisyphean](https://en.oxforddictionaries.com/definition/sisyphean) task in a single session. Even if you only make _some_ kind of measurable progress, you're moving forward.

By following a simple decision making progress, you can stop dithering and finally get _started_ on your To Do list rather than get stuck staring at it.  



## How to Use This App  
### Main Task List  
Easy, right? It's your To Do list.  
However, instead of working from top to bottom, you'll be working from _bottom to top_. The current active task (<img src="img/task_active.png" valign="middle">) will be lowest on the list, and is the one you should be working on after **[planning](#planning-view)**. (You can change this behavior in the app settings.)  
  
<p align="middle">  
	<img src="img/Task List VC.png">  
</p>

#### Controls  
- **Top**  
	- Use the segmented control at the top to see either your entire task list, or only the ones you are working on in your current session.  
- **Bottom**  
	- Tap the new task button (the **+** symbol at the bottom) to add a new task or project.  
	- Use the tabs at the bottom take you to the **[Planning View](#planning-view)** or the **Help / About** page.  
- **Left Side**
	- Tap the selection button on the left to toggle the selection state of a task (whether you will be working on it during your current session):
		- Selected: <img src="img/task_selected.png" valign="middle">  
		- Unselected: <img src="img/task_default.png" valign="middle">  
- **Right Side**  
	- Tap the checkmark button (<img src="img/checkmark_green.png" valign="middle">) to mark a task as complete — all work is complete and you don't expect to work on it any further.
	- Tap the progress button (<img src="img/arrow_down_tungsten.png" valign="middle">) to mark a task as "worked on" but incomplete — either it's a larger project that you aren't finished with yet, or it's a recurring task you will work on again some time later.  

<hr/>  


### Creating a New Task  
<p align="middle">  
	<img src="img/New Task VC.png" align="middle">  
</p>  

- Tap return or "**<font color="#115efb">Add to list</font>**" to add multiple tasks to your list
- Tap "**<font color="#115efb">Start task now</font>**" to add a single task and get right back to work.  
 
<hr/>  


### Planning View  
<p align="middle">  
	<img src="img/Planning VC 1.png" width="27%" hspace="3%">  
	<img src="img/Planning VC 2.png" width="27%" hspace="3%">  
	<img src="img/Planning VC 3 - Done.png" width="27%" hspace="3%">  
</p>  

The **Planning View** guides you through the process of deciding on what tasks to work on in your current session. 

The first task on your list is _always_ pre-selected. This ensures that you will continue to make progress on more important (but likely less urgent) older tasks.
As you work down the list, answering the question "Before you work on **Task A**, do you want to work on **Task B**?" allows you to subconsciously balance the urgency and importance of tasks, and helps you gradually overcome the resistance you may have to some unactioned tasks.

When you're done planning, tap "<b><font color="green">Ready to work!</font></b>" to return to your **[Task List](#main-task-list)** and get started!


## FAQ  
### Q: How long should a "session" be?
**A:** Your session may be the entire working day, or the next half hour. That is up to you. However, the more often you review your list, the more likely it is to remain current and keep your momentum going. As you keep in mind how long you'll be working, you'll know which tasks to say "Yes" to.  
Mark Forster, who created the [system](#concept) that **OT@aT** uses, says the following:
> You should aim to go through the list three or more times on a normal day. Less than that will tend to be too slow-moving. Don’t put too many tasks into the preselect list, and remember the principle of “little and often”.


### Q: What do you mean by what do I \*\*WANT* to work on before a particular task?
**A:** Mark Forster:
> What exactly is meant by "want" in this context is deliberately left undefined. There may be a whole variety of reasons why you might want to do one thing before another thing and all of them are valid.
 
He also clarifies that this question asks, not what you want to work on **most**, but **first**:  
> You may not particularly want to do any of the tasks but, given that you have to do them whether you like it or not, the question is about the order you are going to do them in.
  
I have personally found that I tend to have less resistance to stuff lower on the list, which lets me start on the easy tasks and work my way up in level of "difficulty".  


## Attribution  
### Concept  
**OT@aT** is based on the [Final Version](http://archive.constantcontact.com/fs004/1100358239599/archive/1109980854493.html) time management system created by [Mark Forster](http://markforster.net/). I found it so elegant and useful that I wanted to create an electronic version that I could always have on hand.  

### Images  
All images used in **OT@aT** are royalty-free and were provided by [The Noun Project](https://thenounproject.com):  

- [List](https://thenounproject.com/term/list/888710/) by Noun Project  
- [Target](https://thenounproject.com/term/target/888735/) by Noun Project  
- [Arrow Down](https://thenounproject.com/term/arrow-down/888649/) by Noun Project  
- [Check Mark](https://thenounproject.com/term/check-mark/888686/) by Noun Project  

### External frameworks used  
- [UICircularProgressRing](https://github.com/luispadron/UICircularProgressRing) — created by [Luis Padron](https://github.com/luispadron)