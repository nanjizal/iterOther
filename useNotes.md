## Use notes for iterOther

#### simple backwards
```Haxe
import iterOther.IntIterBase;
  
for(i in ((0...10) : Backwards) ) trace( i );

```
  
#### reuse 
  
```Haxe
import iterOther.IntIterBase;
  
var forward: Forward = 0...10;  
for(i in forward) trace(i);
forward.reset();
for(i in forward) trace(i);
```
  
#### step
  
no reset option for step as keeping overhead minumum, currently no negative step either ( but see more extensive Float implementation )
  
```Haxe
import iterOther.IntIterBsse;

var step: Steps = 0...12;
step.step = 2;
for(i in steps) trace(i);
```
  
#### Float steps ( up or down ), optional iterate and then clamp to last value.
    
```Haxe
import iterOther.FloatIterBase;

var step: Stepsf = ( 5.5: F )...( 12.3: F );
step.step = 0.35;
for( i in steps ) trace( i );

step = ( -15.4: F )...( 10.1: F );
step.step = 0.5;
step.clampEnd = true;
for( i in steps ) trace( i );
```
  
    
