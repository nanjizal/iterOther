@:forward(iterator)
abstract Set<T>( Array<T> ){
  public inline function new(a:Array<T>){
		this = a;
  }
  public inline function contains(o:T): Bool {
    var n = this.lastIndexOf(o);
    return ( n == -1 );
  }
  public inline function add(o:T){
    return if( contains(o) ){
		  this.push(o);
      true;
    } else {
			false;
    }
  }
  public inline function remove(o:T){
	  this.remove(o);
  }
  public inline function clear(){
    this.resize(0);
  }
}
